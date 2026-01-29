module Calculators.Nutrition exposing (Model, Msg(..), init, update, view)

import Functions exposing (..)
import Html exposing (button, div, form, h2, input, label, option, p, select, text)
import Html.Attributes exposing (attribute, checked, class, for, id, type_, value)
import Html.Events exposing (onCheck, onClick, onInput)
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


update : Msg -> Model -> Strings -> Model
update msg model strings =
    case msg of
        ChangeWeight newWeight ->
            { model | weight = newWeight }

        ChangeHeight newHeight ->
            { model | height = newHeight }

        ChangeWeightLoss newWeightLoss ->
            { model | weightLoss = newWeightLoss }

        ChangeCritical newCritical ->
            { model | critical = newCritical }

        Calculate ->
            let
                weight =
                    strToFloat model.weight

                height =
                    strToFloat model.height
            in
            if weight == 0 || height == 0 then
                { model | error = Just strings.zeroNotAccepted, calculated = True }

            else
                let
                    bmi =
                        calculateBMI weight height

                    score =
                        scoreCalculator bmi model.weightLoss model.critical

                    result =
                        calculateCalories weight bmi score
                in
                { model
                    | bmi = formatToDecimals 2 bmi
                    , calories = formatToDecimals 2 result.calories
                    , proteins = formatToDecimals 2 result.proteins
                    , fats = formatToDecimals 2 result.fats
                    , carbs = formatToDecimals 2 result.carbs
                    , error = Nothing
                    , calculated = True
                }


view : Strings -> Model -> Html.Html Msg
view strings model =
    div [ class "calculator-card", attribute "aria-label" strings.nutritionCalc ]
        [ h2 [ class "card-title" ] [ text strings.nutritionCalc ]
        , form [ class "form" ]
            [ fieldGroup strings.weight "nutrition-weight" "0.0" model.weight ChangeWeight
            , fieldGroup strings.height "nutrition-height" "0.0" model.height ChangeHeight
            , div [ class "field-group" ]
                [ label [ class "label", for "nutrition-weight-loss" ] [ text strings.weightLoss ]
                , select
                    [ class "input"
                    , id "nutrition-weight-loss"
                    , onInput (\v -> ChangeWeightLoss (Maybe.withDefault 0 (String.toInt v)))
                    ]
                    [ option [ value "0" ] [ text strings.weightLossNone ]
                    , option [ value "1" ] [ text "1-5%" ]
                    , option [ value "2" ] [ text "5-10%" ]
                    , option [ value "3" ] [ text ">10%" ]
                    ]
                ]
            , div [ class "field-group checkbox-group" ]
                [ input
                    [ type_ "checkbox"
                    , id "nutrition-critical"
                    , checked model.critical
                    , onCheck ChangeCritical
                    , class "checkbox-input"
                    ]
                    []
                , label [ class "checkbox-label", for "nutrition-critical" ] [ text strings.critical ]
                ]
            , div [ class "button-container" ]
                [ button [ class "button", type_ "button", onClick Calculate, attribute "aria-label" ("Calculate " ++ strings.nutritionCalc) ] [ text strings.calculate ]
                ]
            , case model.error of
                Just error ->
                    div [ class "error-container", attribute "role" "alert" ]
                        [ p [ class "error-text" ] [ text error ]
                        ]

                Nothing ->
                    if model.calculated then
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
            ]
        ]
