module Main exposing (main, update, Model, Msg(..), init)

import Browser
import Functions exposing (..)
import Translations exposing (Language(..), Strings, getStrings)
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
    , language : Language
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
    , language = English
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
    | ToggleLanguage
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

        ToggleLanguage ->
            { model | language = if model.language == English then Georgian else English }

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
    let
        strings =
            getStrings model.language
    in
    div [ class "container" ]
        [ h1 [ class "title" ] [ text strings.title ]
        , div [ class "subtitle" ] [ text strings.subtitle ]
        , div [ class "language-toggle" ]
            [ button
                [ class "language-button"
                , type_ "button"
                , onClick ToggleLanguage
                ]
                [ text (if model.language == English then "ქართული" else "English") ]
            ]
        , div [ class "menu-container" ]
            [ button
                [ class "menu-button"
                , classList [ ( "active", model.selectedCalculator == Pills ) ]
                , type_ "button"
                , onClick (SelectCalculator Pills)
                ]
                [ text strings.pillDosage ]
            , button
                [ class "menu-button"
                , classList [ ( "active", model.selectedCalculator == Liquids ) ]
                , type_ "button"
                , onClick (SelectCalculator Liquids)
                ]
                [ text strings.liquidDosage ]
            , button
                [ class "menu-button"
                , classList [ ( "active", model.selectedCalculator == Nutrition ) ]
                , type_ "button"
                , onClick (SelectCalculator Nutrition)
                ]
                [ text strings.nutrition ]
            ]
        , div [ class "calculators-container" ]
            [ case model.selectedCalculator of
                Pills ->
                    div [ class "calculator-card" ]
                        [ h2 [ class "card-title" ] [ text strings.peroralpill ]
                        , form [ class "form" ]
                            [ div [ class "field-group" ]
                                [ label [ class "label" ] [ text strings.prescribedAmount ]
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
                                [ label [ class "label" ] [ text strings.pillStrength ]
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
                                [ button [ class "button", type_ "button", onClick CalculateResult ] [ text strings.calculate ]
                                ]
                            , div [ class "result-container" ]
                                [ p [ class "result-label" ] [ text strings.result ]
                                , p [ class "result-value" ] [ text model.result ]
                                , p [ class "result-unit" ] [ text strings.tablets ]
                                ]
                            ]
                        ]

                Liquids ->
                    div [ class "calculator-card" ]
                        [ h2 [ class "card-title" ] [ text strings.peroralliquid ]
                        , form [ class "form" ]
                            [ div [ class "field-group" ]
                                [ label [ class "label" ] [ text strings.prescribedAmount ]
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
                                [ label [ class "label" ] [ text strings.amountAtHand ]
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
                                [ label [ class "label" ] [ text strings.volumeAtHand ]
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
                                [ button [ class "button", type_ "button", onClick CalculateLiquidDosage ] [ text strings.calculate ]
                                ]
                            , div [ class "result-container" ]
                                [ p [ class "result-label" ] [ text strings.result ]
                                , p [ class "result-value" ] [ text model.liquidResult ]
                                , p [ class "result-unit" ] [ text strings.ml ]
                                ]
                            ]
                        ]

                Nutrition ->
                    div [ class "calculator-card" ]
                        [ h2 [ class "card-title" ] [ text strings.nutritionCalc ]
                        , form [ class "form" ]
                            [ div [ class "field-group" ]
                                [ label [ class "label" ] [ text strings.weight ]
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
                                [ label [ class "label" ] [ text strings.height ]
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
                                [ label [ class "label" ] [ text strings.weightLoss ]
                                , select
                                    [ class "input"
                                    , onInput (\v -> ChangeNutritionWeightLoss (Maybe.withDefault 0 (String.toInt v)))
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
                                    , checked model.nutritionCritical
                                    , onCheck ChangeNutritionCritical
                                    , class "checkbox-input"
                                    ]
                                    []
                                , label [ class "checkbox-label" ] [ text strings.critical ]
                                ]
                            , div [ class "button-container" ]
                                [ button [ class "button", type_ "button", onClick CalculateNutrition ] [ text strings.calculate ]
                                ]
                            , if model.nutritionBMI /= "" then
                                div [ class "result-container" ]
                                    [ p [ class "result-label" ] [ text "BMI:" ]
                                    , p [ class "result-value" ] [ text model.nutritionBMI ]
                                    , p [ class "result-label" ] [ text strings.dailyCalories ]
                                    , p [ class "result-value" ] [ text model.nutritionCalories ]
                                    , p [ class "result-unit" ] [ text strings.kcal ]
                                    , div [ class "nutrition-table" ]
                                        [ p [ class "nutrition-row" ] [ text (strings.proteins ++ model.nutritionProteins ++ "g") ]
                                        , p [ class "nutrition-row" ] [ text (strings.fats ++ model.nutritionFats ++ "g") ]
                                        , p [ class "nutrition-row" ] [ text (strings.carbs ++ model.nutritionCarbs ++ "g") ]
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
