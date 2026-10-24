module Calculators.FreeWaterDeficit exposing (Model, Msg(..), init, update, view)

import Calculators.Card as Card
import Calculators.Label as Label
import FormFields exposing (checkboxField, numberField, optionButtonsField)
import Functions exposing (Sex(..), calculateFreeWaterDeficit, errorDisplay, floatToStr, roundToTwoDecimals, strToFloat, totalBodyWaterFactor)
import Html exposing (Html)
import Translations exposing (Strings)



-- MODEL


type alias Model =
    { weight : String
    , sodium : String
    , sex : Sex
    , elderly : Bool
    , result : Maybe Float
    , error : Maybe String
    }


init : Model
init =
    { weight = ""
    , sodium = ""
    , sex = Male
    , elderly = False
    , result = Nothing
    , error = Nothing
    }



-- UPDATE


type Msg
    = UpdateWeight String
    | UpdateSodium String
    | UpdateSex Sex
    | UpdateElderly Bool
    | Calculate
    | Reset


update : Msg -> Model -> Strings -> Model
update msg model strings =
    case msg of
        UpdateWeight weight ->
            { model | weight = weight, result = Nothing, error = Nothing }

        UpdateSodium sodium ->
            { model | sodium = sodium, result = Nothing, error = Nothing }

        UpdateSex sex ->
            { model | sex = sex, result = Nothing, error = Nothing }

        UpdateElderly elderly ->
            { model | elderly = elderly, result = Nothing, error = Nothing }

        Calculate ->
            case ( strToFloat model.weight, strToFloat model.sodium ) of
                ( Just weight, Just sodium ) ->
                    if weight <= 0 || sodium <= 0 then
                        { model | error = Just strings.zeroNotAccepted, result = Nothing }

                    else if sodium < 140 then
                        { model | error = Just strings.sodiumNotElevated, result = Nothing }

                    else
                        { model
                            | result = Just (roundToTwoDecimals (calculateFreeWaterDeficit model.sex model.elderly weight sodium))
                            , error = Nothing
                        }

                _ ->
                    { model | error = Just strings.invalidInputs, result = Nothing }

        Reset ->
            init



-- VIEW


view : Strings -> Model -> Html Msg
view strings model =
    Card.view
        { title = strings.freeWaterDeficit
        , formula = strings.freeWaterFormula
        , calculateLabel = strings.calculate ++ ": " ++ strings.freeWaterDeficit
        , resetLabel = strings.reset ++ ": " ++ strings.freeWaterDeficit
        }
        [ numberField strings.weight "weight" model.weight UpdateWeight
        , numberField strings.sodium "sodium" model.sodium UpdateSodium
        , optionButtonsField strings.sex
            "free-water-sex"
            (sexToValue model.sex)
            [ { value = "male", label = strings.male }
            , { value = "female", label = strings.female }
            ]
            (\v -> UpdateSex (sexFromValue v))
        , checkboxField strings.elderly "free-water-elderly" model.elderly UpdateElderly
        ]
        { calculateMsg = Calculate
        , resetMsg = Reset
        , calculateText = strings.calculate
        , resetText = strings.reset
        }
        (case ( model.error, model.result ) of
            ( Just error, _ ) ->
                if error == strings.sodiumNotElevated then
                    Label.notice error

                else
                    errorDisplay error

            ( Nothing, Just result ) ->
                Label.view strings.calculationResult
                    { title = strings.waterToReplace
                    , value = floatToStr result
                    , unit = strings.liters
                    , extra = []
                    , working =
                        [ floatToStr (totalBodyWaterFactor model.sex model.elderly)
                            ++ " × "
                            ++ model.weight
                            ++ " "
                            ++ strings.kg
                            ++ " × ("
                            ++ model.sodium
                            ++ " ÷ 140 − 1)"
                        ]
                    }

            ( Nothing, Nothing ) ->
                Label.empty strings.resultHint
        )


sexToValue : Sex -> String
sexToValue sex =
    case sex of
        Male ->
            "male"

        Female ->
            "female"


sexFromValue : String -> Sex
sexFromValue value =
    if value == "female" then
        Female

    else
        Male
