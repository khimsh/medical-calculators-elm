module Main exposing (main, update, Model, Msg(..), init)

import Browser
import Functions exposing (..)
import Html exposing (button, div, form, h1, h2, input, label, option, p, select, text)
import Html.Attributes exposing (checked, class, placeholder, type_, value)
import Html.Events exposing (onClick, onInput, onCheck)


main : Program () Model Msg
main =
    Browser.sandbox { init = init, update = update, view = view }


type Calculator
    = Pills
    | Liquids
    | Nutrition


type alias Model =
    { selectedCalculator : Calculator
    , prescribed : String
    , tabletMg : String
    , result : String
    , prescribedLiquid : String
    , liquidDosageAthand : String
    , liquidVolumeAtHand : String
    , liquidResult : String
    , nutritionWeight : String
    , nutritionHeight : String
    , nutritionWeightLoss : Int
    , nutritionCritical : Bool
    , nutritionBMI : String
    , nutritionCalories : String
    , nutritionProteins : String
    , nutritionFats : String
    , nutritionCarbs : String
    }


init : Model
init =
    { selectedCalculator = Pills
    , prescribed = ""
    , tabletMg = ""
    , result = "0.0"
    , prescribedLiquid = ""
    , liquidDosageAthand = ""
    , liquidVolumeAtHand = ""
    , liquidResult = ""
    , nutritionWeight = ""
    , nutritionHeight = ""
    , nutritionWeightLoss = 0
    , nutritionCritical = False
    , nutritionBMI = ""
    , nutritionCalories = ""
    , nutritionProteins = ""
    , nutritionFats = ""
    , nutritionCarbs = ""
    }


type Msg
    = SelectCalculator Calculator
    | ChangePrescribed String
    | ChangeTabletMg String
    | CalculateResult
    | ChangePrescribedLiquid String
    | ChangeLiquidDosageAthand String
    | ChangeLiquidVolumeAtHand String
    | CalculateLiquidDosage
    | ChangeNutritionWeight String
    | ChangeNutritionHeight String
    | ChangeNutritionWeightLoss Int
    | ChangeNutritionCritical Bool
    | CalculateNutrition


update : Msg -> Model -> Model
update msg model =
    case msg of
        SelectCalculator calculator ->
            { model | selectedCalculator = calculator }

        ChangePrescribed newPrescribed ->
            { model | prescribed = newPrescribed }

        ChangeTabletMg newTablet ->
            { model | tabletMg = newTablet }

        CalculateResult ->
            { model | result = floatToStr (strToFloat model.prescribed / strToFloat model.tabletMg) }

        ChangePrescribedLiquid newPrescribedLiquid ->
            { model | prescribedLiquid = newPrescribedLiquid }

        ChangeLiquidDosageAthand newLiquidDosageAthand ->
            { model | liquidDosageAthand = newLiquidDosageAthand }

        ChangeLiquidVolumeAtHand newLiquidVolumeAtHand ->
            { model | liquidVolumeAtHand = newLiquidVolumeAtHand }

        CalculateLiquidDosage ->
            { model | liquidResult = floatToStr ((strToFloat model.prescribedLiquid / strToFloat model.liquidDosageAthand) * strToFloat model.liquidVolumeAtHand) }

        ChangeNutritionWeight newWeight ->
            { model | nutritionWeight = newWeight }

        ChangeNutritionHeight newHeight ->
            { model | nutritionHeight = newHeight }

        ChangeNutritionWeightLoss newWeightLoss ->
            { model | nutritionWeightLoss = newWeightLoss }

        ChangeNutritionCritical newCritical ->
            { model | nutritionCritical = newCritical }

        CalculateNutrition ->
            let
                weight =
                    strToFloat model.nutritionWeight

                height =
                    strToFloat model.nutritionHeight

                bmi =
                    calculateBMI weight height

                score =
                    scoreCalculator bmi model.nutritionWeightLoss model.nutritionCritical

                result =
                    calculateCalories weight bmi score
            in
            { model
                | nutritionBMI = formatToDecimals 2 bmi
                , nutritionCalories = formatToDecimals 1 result.calories
                , nutritionProteins = formatToDecimals 1 result.proteins
                , nutritionFats = formatToDecimals 1 result.fats
                , nutritionCarbs = formatToDecimals 1 result.carbs
            }


view : Model -> Html.Html Msg
view model =
    div [ class "container" ]
        [ h1 [ class "title" ] [ text "Medical Calculators" ]
        , div [ class "subtitle" ] [ text "Implemented in Elm" ]
        , div [ class "menu-container" ]
            [ button
                [ class "menu-button"
                , classList [ ( "active", model.selectedCalculator == Pills ) ]
                , type_ "button"
                , onClick (SelectCalculator Pills)
                ]
                [ text "Pill Dosage" ]
            , button
                [ class "menu-button"
                , classList [ ( "active", model.selectedCalculator == Liquids ) ]
                , type_ "button"
                , onClick (SelectCalculator Liquids)
                ]
                [ text "Liquid Dosage" ]
            , button
                [ class "menu-button"
                , classList [ ( "active", model.selectedCalculator == Nutrition ) ]
                , type_ "button"
                , onClick (SelectCalculator Nutrition)
                ]
                [ text "Nutrition" ]
            ]
        , div [ class "calculators-container" ]
            [ case model.selectedCalculator of
                Pills ->
                    div [ class "calculator-card" ]
                        [ h2 [ class "card-title" ] [ text "Peroral Pill Dosage" ]
                        , form [ class "form" ]
                            [ div [ class "field-group" ]
                                [ label [ class "label" ] [ text "Prescribed amount (mg)" ]
                                , input
                                    [ class "input"
                                    , placeholder "0.0"
                                    , value model.prescribed
                                    , onInput ChangePrescribed
                                    , type_ "number"
                                    , Html.Attributes.min "0"
                                    ]
                                    []
                                ]
                            , div [ class "field-group" ]
                                [ label [ class "label" ] [ text "Pill strength (mg)" ]
                                , input
                                    [ class "input"
                                    , placeholder "0.0"
                                    , value model.tabletMg
                                    , onInput ChangeTabletMg
                                    , type_ "number"
                                    , Html.Attributes.min "0"
                                    ]
                                    []
                                ]
                            , div [ class "button-container" ]
                                [ button [ class "button", type_ "button", onClick CalculateResult ] [ text "Calculate" ]
                                ]
                            , div [ class "result-container" ]
                                [ p [ class "result-label" ] [ text "Result:" ]
                                , p [ class "result-value" ] [ text model.result ]
                                , p [ class "result-unit" ] [ text "tablets" ]
                                ]
                            ]
                        ]

                Liquids ->
                    div [ class "calculator-card" ]
                        [ h2 [ class "card-title" ] [ text "Peroral Liquids Dosage" ]
                        , form [ class "form" ]
                            [ div [ class "field-group" ]
                                [ label [ class "label" ] [ text "Prescribed amount (mg)" ]
                                , input
                                    [ class "input"
                                    , placeholder "0.0"
                                    , value model.prescribedLiquid
                                    , onInput ChangePrescribedLiquid
                                    , type_ "number"
                                    , Html.Attributes.min "0"
                                    ]
                                    []
                                ]
                            , div [ class "field-group" ]
                                [ label [ class "label" ] [ text "Amount at hand (mg)" ]
                                , input
                                    [ class "input"
                                    , placeholder "0.0"
                                    , value model.liquidDosageAthand
                                    , onInput ChangeLiquidDosageAthand
                                    , type_ "number"
                                    , Html.Attributes.min "0"
                                    ]
                                    []
                                ]
                            , div [ class "field-group" ]
                                [ label [ class "label" ] [ text "Volume at hand (mL)" ]
                                , input
                                    [ class "input"
                                    , placeholder "0.0"
                                    , value model.liquidVolumeAtHand
                                    , onInput ChangeLiquidVolumeAtHand
                                    , type_ "number"
                                    , Html.Attributes.min "0"
                                    ]
                                    []
                                ]
                            , div [ class "button-container" ]
                                [ button [ class "button", type_ "button", onClick CalculateLiquidDosage ] [ text "Calculate" ]
                                ]
                            , div [ class "result-container" ]
                                [ p [ class "result-label" ] [ text "Result:" ]
                                , p [ class "result-value" ] [ text model.liquidResult ]
                                , p [ class "result-unit" ] [ text "mL" ]
                                ]
                            ]
                        ]

                Nutrition ->
                    div [ class "calculator-card" ]
                        [ h2 [ class "card-title" ] [ text "Nutrition Calculator" ]
                        , form [ class "form" ]
                            [ div [ class "field-group" ]
                                [ label [ class "label" ] [ text "Weight (kg)" ]
                                , input
                                    [ class "input"
                                    , placeholder "0.0"
                                    , value model.nutritionWeight
                                    , onInput ChangeNutritionWeight
                                    , type_ "number"
                                    , Html.Attributes.min "0"
                                    ]
                                    []
                                ]
                            , div [ class "field-group" ]
                                [ label [ class "label" ] [ text "Height (cm)" ]
                                , input
                                    [ class "input"
                                    , placeholder "0.0"
                                    , value model.nutritionHeight
                                    , onInput ChangeNutritionHeight
                                    , type_ "number"
                                    , Html.Attributes.min "0"
                                    ]
                                    []
                                ]
                            , div [ class "field-group" ]
                                [ label [ class "label" ] [ text "Weight Loss (%)" ]
                                , select
                                    [ class "input"
                                    , onInput (\v -> ChangeNutritionWeightLoss (Maybe.withDefault 0 (String.toInt v)))
                                    ]
                                    [ option [ value "0" ] [ text "None" ]
                                    , option [ value "1" ] [ text "1-5%" ]
                                    , option [ value "2" ] [ text "5-10%" ]
                                    , option [ value "3" ] [ text ">10%" ]
                                    ]
                                ]
                            , div [ class "field-group checkbox-group" ]
                                [ input
                                    [ type_ "checkbox"
                                    , checked model.nutritionCritical
                                    , onCheck ChangeNutritionCritical
                                    , class "checkbox-input"
                                    ]
                                    []
                                , label [ class "checkbox-label" ] [ text "Critical condition?" ]
                                ]
                            , div [ class "button-container" ]
                                [ button [ class "button", type_ "button", onClick CalculateNutrition ] [ text "Calculate" ]
                                ]
                            , if model.nutritionBMI /= "" then
                                div [ class "result-container" ]
                                    [ p [ class "result-label" ] [ text "BMI:" ]
                                    , p [ class "result-value" ] [ text model.nutritionBMI ]
                                    , p [ class "result-label" ] [ text "Daily Calories:" ]
                                    , p [ class "result-value" ] [ text model.nutritionCalories ]
                                    , p [ class "result-unit" ] [ text "kcal" ]
                                    , div [ class "nutrition-table" ]
                                        [ p [ class "nutrition-row" ] [ text ("Proteins: " ++ model.nutritionProteins ++ "g") ]
                                        , p [ class "nutrition-row" ] [ text ("Fats: " ++ model.nutritionFats ++ "g") ]
                                        , p [ class "nutrition-row" ] [ text ("Carbs: " ++ model.nutritionCarbs ++ "g") ]
                                        ]
                                    ]

                              else
                                text ""
                            ]
                        ]
            ]
        ]


classList : List ( String, Bool ) -> Html.Attribute Msg
classList classes =
    class (String.join " " (List.map Tuple.first (List.filter Tuple.second classes)))
