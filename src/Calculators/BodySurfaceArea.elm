module Calculators.BodySurfaceArea exposing (Model, Msg(..), init, update, view)

import Calculators.Card as Card
import Calculators.Label as Label
import FormFields exposing (numberField)
import Functions exposing (calculateBodySurfaceArea, errorDisplay, strToFloat)
import Html exposing (Html)
import Translations exposing (Strings)



-- MODEL


type alias Model =
    { height : String
    , weight : String
    , result : Maybe Float
    , error : Maybe String
    }


init : Model
init =
    { height = ""
    , weight = ""
    , result = Nothing
    , error = Nothing
    }



-- UPDATE


type Msg
    = UpdateHeight String
    | UpdateWeight String
    | Calculate
    | Reset


update : Msg -> Model -> Strings -> Model
update msg model strings =
    case msg of
        UpdateHeight height ->
            { model | height = height, result = Nothing, error = Nothing }

        UpdateWeight weight ->
            { model | weight = weight, result = Nothing, error = Nothing }

        Calculate ->
            case ( strToFloat model.height, strToFloat model.weight ) of
                ( Just height, Just weight ) ->
                    if height <= 0 || weight <= 0 then
                        { model | error = Just strings.zeroNotAccepted, result = Nothing }

                    else
                        { model
                            | result = Just (calculateBodySurfaceArea height weight)
                            , error = Nothing
                        }

                _ ->
                    { model | error = Just strings.invalidInputs, result = Nothing }

        Reset ->
            init



-- VIEW


{-| Two decimal places, always, so 2 m² is shown as 2.00.
-}
formatBsa : Float -> String
formatBsa bsa =
    let
        hundredths =
            round (bsa * 100)
    in
    String.fromInt (hundredths // 100)
        ++ "."
        ++ String.padLeft 2 '0' (String.fromInt (remainderBy 100 hundredths))


view : Strings -> Model -> Html Msg
view strings model =
    Card.view
        { title = strings.bodySurfaceArea
        , formula = strings.bsaFormula
        , calculateLabel = strings.calculate ++ ": " ++ strings.bodySurfaceArea
        , resetLabel = strings.reset ++ ": " ++ strings.bodySurfaceArea
        }
        [ numberField strings.height "bsa-height" model.height UpdateHeight
        , numberField strings.weight "bsa-weight" model.weight UpdateWeight
        ]
        { calculateMsg = Calculate
        , resetMsg = Reset
        , calculateText = strings.calculate
        , resetText = strings.reset
        }
        (case ( model.error, model.result ) of
            ( Just error, _ ) ->
                errorDisplay error

            ( Nothing, Just bsa ) ->
                Label.view strings.calculationResult
                    { title = strings.bodySurfaceArea
                    , value = formatBsa bsa
                    , unit = strings.bsaUnit
                    , extra = []
                    , working =
                        [ "√("
                            ++ model.height
                            ++ " "
                            ++ strings.cm
                            ++ " × "
                            ++ model.weight
                            ++ " "
                            ++ strings.kg
                            ++ " ÷ 3600)"
                        ]
                    }

            ( Nothing, Nothing ) ->
                Label.empty strings.resultHint
        )
