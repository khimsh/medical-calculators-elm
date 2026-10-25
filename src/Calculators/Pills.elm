module Calculators.Pills exposing (Model, Msg(..), init, update, view)

import Calculators.Card as Card
import Calculators.InputError as InputError exposing (InputError(..))
import Calculators.Label as Label
import FormFields exposing (numberField)
import Functions exposing (floatToStr, roundToTwoDecimals, strToFloat)
import Html
import Translations exposing (Strings)


type alias Model =
    { prescribed : String
    , tabletMg : String
    , result : String
    , error : Maybe InputError
    , calculated : Bool
    }


init : Model
init =
    { prescribed = ""
    , tabletMg = ""
    , result = "0.0"
    , error = Nothing
    , calculated = False
    }


type Msg
    = ChangePrescribed String
    | ChangeTabletMg String
    | Calculate
    | Reset


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangePrescribed newPrescribed ->
            { model | prescribed = newPrescribed, calculated = False, error = Nothing }

        ChangeTabletMg newTablet ->
            { model | tabletMg = newTablet, calculated = False, error = Nothing }

        Calculate ->
            if String.isEmpty model.prescribed || String.isEmpty model.tabletMg then
                { model | error = Just InvalidInputs, result = "0.0", calculated = True }

            else
                case ( strToFloat model.prescribed, strToFloat model.tabletMg ) of
                    ( Just prescribed, Just tablet ) ->
                        if prescribed <= 0 || tablet <= 0 then
                            { model | error = Just NotPositive, result = "0.0", calculated = True }

                        else
                            { model | result = floatToStr (roundToTwoDecimals (prescribed / tablet)), error = Nothing, calculated = True }

                    _ ->
                        { model | error = Just InvalidInputs, result = "0.0", calculated = True }

        Reset ->
            init


view : Strings -> Model -> Html.Html Msg
view strings model =
    Card.view
        { title = strings.pillDosage
        , formula = strings.pillFormula
        , calculateLabel = strings.calculate ++ ": " ++ strings.pillDosage
        , resetLabel = strings.reset ++ ": " ++ strings.pillDosage
        }
        [ numberField strings.prescribedAmount "pills-prescribed-amount" model.prescribed ChangePrescribed
        , numberField strings.pillStrength "pills-tablet-mg" model.tabletMg ChangeTabletMg
        ]
        { calculateMsg = Calculate
        , resetMsg = Reset
        , calculateText = strings.calculate
        , resetText = strings.reset
        }
        (case model.error of
            Just error ->
                InputError.view strings error

            Nothing ->
                if model.calculated then
                    Label.view strings.calculationResult
                        { title = strings.give
                        , value = model.result
                        , unit = strings.tablets
                        , extra = []
                        , working = [ model.prescribed ++ " " ++ strings.mg ++ " ÷ " ++ model.tabletMg ++ " " ++ strings.mg ]
                        }

                else
                    Label.empty strings.resultHint
        )
