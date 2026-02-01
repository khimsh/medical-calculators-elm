module Calculators.Nutrition exposing (Model, Msg(..), init, update, view)

import Calculators.Card as Card
import FormFields exposing (checkboxField, numberField, selectField)
import Functions exposing (calculateBMI, calculateCalories, errorDisplay, floatToStr, roundToTwoDecimals, scoreCalculator, strToFloat)
import Html exposing (div, p, text)
import Html.Attributes exposing (attribute, class)
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
                let
                    weight =
                        strToFloat model.weight

                    height =
                        strToFloat model.height

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
                    , proteins = floatToStr (roundToTwoDecimals nutrition.proteins)
                    , fats = floatToStr (roundToTwoDecimals nutrition.fats)
                    , carbs = floatToStr (roundToTwoDecimals nutrition.carbs)
                    , error = Nothing
                    , calculated = True
                }

        Reset ->
            init


view : { a | nutrition : String, weight : String, height : String, weightLoss : String, weightLossNone : String, critical : String, calculate : String, reset : String, dailyCalories : String, kcal : String, proteins : String, fats : String, carbs : String } -> { b | weight : String, height : String, weightLoss : Int, critical : Bool, error : Maybe String, calculated : Bool, bmi : String, calories : String, proteins : String, fats : String, carbs : String } -> Html.Html Msg
view strings model =
    Card.view
        { title = strings.nutrition
        , ariaLabel = strings.nutrition
        , calculateLabel = "Calculate " ++ strings.nutrition
        , resetLabel = "Reset " ++ strings.nutrition
        }
        [ numberField strings.weight "nutrition-weight" "0.0" model.weight ChangeWeight
        , numberField strings.height "nutrition-height" "0.0" model.height ChangeHeight
        , selectField strings.weightLoss
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
                if model.calculated && not (String.isEmpty model.weight || String.isEmpty model.height) then
                    div [ class "result-container", attribute "role" "region", attribute "aria-label" "Nutrition calculation results" ]
                        [ p [ class "result-label" ] [ text "BMI:" ]
                        , p [ class "result-value", attribute "aria-live" "polite" ] [ text model.bmi ]
                        , p [ class "result-label" ] [ text strings.dailyCalories ]
                        , p [ class "result-value" ] [ text model.calories ]
                        , p [ class "result-unit" ] [ text strings.kcal ]
                        , div [ class "nutrition-table" ]
                            [ p [ class "nutrition-row" ] [ text (strings.proteins ++ model.proteins ++ "g") ]
                            , p [ class "nutrition-row" ] [ text (strings.fats ++ model.fats ++ "g") ]
                            , p [ class "nutrition-row" ] [ text (strings.carbs ++ model.carbs ++ "g") ]
                            ]
                        ]

                else
                    text ""
        )
