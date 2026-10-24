module Calculators.Nutrition exposing (Model, Msg(..), init, update, view)

import Calculators.Card as Card
import Calculators.Label as Label
import FormFields exposing (checkboxField, numberField, optionButtonsField)
import Functions exposing (calculateBMI, calculateCalories, errorDisplay, floatToStr, formatToDecimals, roundToTwoDecimals, scoreCalculator, strToFloat)
import Html exposing (dd, div, dl, dt, text)
import Html.Attributes exposing (class)
import Translations exposing (Strings)


type alias Model =
    { weight : String
    , height : String
    , weightLoss : Int
    , critical : Bool
    , bmi : String
    , calories : String
    , proteins : String
    , fats : String
    , carbs : String
    , error : Maybe String
    , calculated : Bool
    }


init : Model
init =
    { weight = ""
    , height = ""
    , weightLoss = 0
    , critical = False
    , bmi = ""
    , calories = ""
    , proteins = ""
    , fats = ""
    , carbs = ""
    , error = Nothing
    , calculated = False
    }


type Msg
    = ChangeWeight String
    | ChangeHeight String
    | ChangeWeightLoss Int
    | ChangeCritical Bool
    | Calculate
    | Reset


update : Msg -> Model -> Strings -> Model
update msg model strings =
    case msg of
        ChangeWeight newWeight ->
            { model | weight = newWeight, calculated = False, error = Nothing }

        ChangeHeight newHeight ->
            { model | height = newHeight, calculated = False, error = Nothing }

        ChangeWeightLoss newWeightLoss ->
            { model | weightLoss = newWeightLoss, calculated = False, error = Nothing }

        ChangeCritical newCritical ->
            { model | critical = newCritical, calculated = False, error = Nothing }

        Calculate ->
            if String.isEmpty model.weight || String.isEmpty model.height then
                { model | error = Just strings.invalidInputs, calculated = True }

            else
                case ( strToFloat model.weight, strToFloat model.height ) of
                    ( Just weight, Just height ) ->
                        if weight <= 0 || height <= 0 then
                            { model | error = Just strings.zeroNotAccepted, calculated = True }

                        else
                            let
                                bmi =
                                    calculateBMI weight height

                                score =
                                    scoreCalculator bmi model.weightLoss model.critical

                                nutrition =
                                    calculateCalories weight bmi score
                            in
                            { model
                                | bmi = floatToStr (roundToTwoDecimals bmi)
                                , calories = floatToStr (roundToTwoDecimals nutrition.calories)
                                , proteins = formatToDecimals 0 nutrition.proteins
                                , fats = formatToDecimals 0 nutrition.fats
                                , carbs = formatToDecimals 0 nutrition.carbs
                                , error = Nothing
                                , calculated = True
                            }

                    _ ->
                        { model | error = Just strings.invalidInputs, calculated = True }

        Reset ->
            init


view : Strings -> Model -> Html.Html Msg
view strings model =
    Card.view
        { title = strings.nutrition
        , formula = strings.nutritionFormula
        , calculateLabel = strings.calculate ++ ": " ++ strings.nutrition
        , resetLabel = strings.reset ++ ": " ++ strings.nutrition
        }
        [ numberField strings.weight "nutrition-weight" "0.0" model.weight ChangeWeight
        , numberField strings.height "nutrition-height" "0.0" model.height ChangeHeight
        , optionButtonsField strings.weightLoss
            "nutrition-weight-loss"
            (String.fromInt model.weightLoss)
            [ { value = "0", label = strings.weightLossNone }
            , { value = "1", label = "1-5%" }
            , { value = "2", label = "5-10%" }
            , { value = "3", label = ">10%" }
            ]
            (\v -> ChangeWeightLoss (Maybe.withDefault 0 (String.toInt v)))
        , checkboxField strings.critical "nutrition-critical" model.critical ChangeCritical
        ]
        { calculateMsg = Calculate
        , resetMsg = Reset
        , calculateText = strings.calculate
        , resetText = strings.reset
        }
        (case model.error of
            Just error ->
                errorDisplay error

            Nothing ->
                if model.calculated then
                    let
                        perKg =
                            Maybe.map2 (/) (strToFloat model.calories) (strToFloat model.weight)
                                |> Maybe.map (roundToTwoDecimals >> floatToStr)
                                |> Maybe.withDefault ""

                        macro name grams =
                            div []
                                [ dt [] [ text name ]
                                , dd [] [ text (grams ++ " " ++ strings.grams) ]
                                ]
                    in
                    Label.view strings.nutritionResults
                        { title = strings.dailyCalories
                        , value = model.calories
                        , unit = strings.kcal
                        , extra =
                            [ dl [ class "macros" ]
                                [ macro strings.proteins model.proteins
                                , macro strings.fats model.fats
                                , macro strings.carbs model.carbs
                                ]
                            ]
                        , working =
                            [ strings.bmi ++ " " ++ model.bmi
                            , perKg ++ " " ++ strings.kcal ++ "/" ++ strings.kg ++ " × " ++ model.weight ++ " " ++ strings.kg
                            ]
                        }

                else
                    Label.empty strings.resultHint
        )
