module Calculators.WeightBasedDose exposing (Model, Msg(..), init, update, view)

import Calculators.Card as Card
import Calculators.InputError as InputError exposing (InputError(..))
import Calculators.Label as Label
import FormFields exposing (numberField)
import Functions exposing (calculateWeightBasedDose, formatToDecimals, strToFloat)
import Html exposing (Html)
import Translations exposing (Strings)



-- MODEL


type alias Model =
    { dosePerKg : String
    , weight : String
    , result : Maybe Float
    , error : Maybe InputError
    }


init : Model
init =
    { dosePerKg = ""
    , weight = ""
    , result = Nothing
    , error = Nothing
    }



-- UPDATE


type Msg
    = UpdateDosePerKg String
    | UpdateWeight String
    | Calculate
    | Reset


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateDosePerKg dosePerKg ->
            { model | dosePerKg = dosePerKg, result = Nothing, error = Nothing }

        UpdateWeight weight ->
            { model | weight = weight, result = Nothing, error = Nothing }

        Calculate ->
            case ( strToFloat model.dosePerKg, strToFloat model.weight ) of
                ( Just dosePerKg, Just weight ) ->
                    if dosePerKg <= 0 || weight <= 0 then
                        { model | error = Just NotPositive, result = Nothing }

                    else
                        { model
                            | result = Just (calculateWeightBasedDose dosePerKg weight)
                            , error = Nothing
                        }

                _ ->
                    { model | error = Just InvalidInputs, result = Nothing }

        Reset ->
            init



-- VIEW


view : Strings -> Model -> Html Msg
view strings model =
    Card.view
        { title = strings.weightBasedDose
        , formula = strings.weightBasedDoseFormula
        , calculateLabel = strings.calculate ++ ": " ++ strings.weightBasedDose
        , resetLabel = strings.reset ++ ": " ++ strings.weightBasedDose
        }
        [ numberField strings.dosePerKg "wbd-dose-per-kg" model.dosePerKg UpdateDosePerKg
        , numberField strings.weight "wbd-weight" model.weight UpdateWeight
        ]
        { calculateMsg = Calculate
        , resetMsg = Reset
        , calculateText = strings.calculate
        , resetText = strings.reset
        }
        (case ( model.error, model.result ) of
            ( Just error, _ ) ->
                InputError.view strings error

            ( Nothing, Just dose ) ->
                Label.view strings.calculationResult
                    { title = strings.dose
                    , value = formatToDecimals 2 dose
                    , unit = strings.mg
                    , extra = []
                    , working =
                        [ model.dosePerKg
                            ++ " "
                            ++ strings.mgPerKg
                            ++ " × "
                            ++ model.weight
                            ++ " "
                            ++ strings.kg
                        ]
                    }

            ( Nothing, Nothing ) ->
                Label.empty strings.resultHint
        )
