module Functions exposing (..)

import Html exposing (button, div, input, label, text)
import Html.Attributes exposing (attribute, class, for, id, type_, value)
import Html.Events exposing (onClick, onInput)


strToFloat : String -> Float
strToFloat string =
    Maybe.withDefault 0 (String.toFloat string)


floatToStr : Float -> String
floatToStr float =
    String.fromFloat float


formatToDecimals : Int -> Float -> String
formatToDecimals decimals value =
    let
        multiplier =
            toFloat (10 ^ decimals)

        rounded =
            (value * multiplier) |> round |> toFloat
    in
    String.fromFloat (rounded / multiplier)


roundToTwoDecimals : Float -> Float
roundToTwoDecimals number =
    toFloat (round (number * 100)) / 100


calculateBMI : Float -> Float -> Float
calculateBMI weight height =
    let
        heightInMeters =
            height / 100
    in
    weight / (heightInMeters ^ 2)


scoreCalculator : Float -> Int -> Bool -> Int
scoreCalculator bmi weightLoss criticalStatus =
    let
        bmiScore =
            if bmi > 20 then
                0

            else if bmi < 18.5 then
                2

            else
                1

        weightLossScore =
            case weightLoss of
                0 ->
                    0

                1 ->
                    0

                2 ->
                    1

                3 ->
                    2

                _ ->
                    0

        criticalScore =
            if criticalStatus then
                2

            else
                0
    in
    bmiScore + weightLossScore + criticalScore


type alias NutritionResult =
    { calories : Float
    , proteins : Float
    , fats : Float
    , carbs : Float
    }


calculateCalories : Float -> Float -> Int -> NutritionResult
calculateCalories weight bmi score =
    if score <= 1 then
        let
            tee =
                25 * weight

            proteins =
                tee / 4

            fats =
                tee / 4

            carbs =
                tee / 2
        in
        NutritionResult tee proteins fats carbs

    else
        let
            ree =
                if bmi < 14 then
                    5 * weight

                else if bmi < 16 then
                    10 * weight

                else
                    30 * weight

            proteins =
                ree / 4

            fats =
                ree / 4

            carbs =
                ree / 2
        in
        NutritionResult ree proteins fats carbs


fieldGroup : String -> String -> String -> String -> (String -> msg) -> Html.Html msg
fieldGroup labelText inputId placeholderText valueText onInputMsg =
    div [ class "field-group" ]
        [ label [ class "label", for inputId ] [ text labelText ]
        , input
            [ class "input"
            , id inputId
            , Html.Attributes.attribute "placeholder" placeholderText
            , Html.Attributes.value valueText
            , onInput onInputMsg
            , type_ "number"
            , attribute "min" "0"
            ]
            []
        ]


resultDisplay : String -> String -> String -> Html.Html msg
resultDisplay resultLabel resultValue resultUnit =
    div [ class "result-container", attribute "role" "region", attribute "aria-label" "Calculation result" ]
        [ Html.p [ class "result-label" ] [ text resultLabel ]
        , Html.p [ class "result-value", attribute "aria-live" "polite" ] [ text resultValue ]
        , Html.p [ class "result-unit" ] [ text resultUnit ]
        ]


errorDisplay : String -> Html.Html msg
errorDisplay errorMessage =
    div [ class "error-container", attribute "role" "alert" ]
        [ Html.p [ class "error-text" ] [ text errorMessage ]
        ]


calculateButton : String -> String -> msg -> Html.Html msg
calculateButton buttonText ariaLabel onClickMsg =
    button
        [ class "button"
        , type_ "button"
        , onClick onClickMsg
        , attribute "aria-label" ariaLabel
        ]
        [ text buttonText ]


resetButton : String -> String -> msg -> Html.Html msg
resetButton buttonText ariaLabel onClickMsg =
    button
        [ class "button button-secondary"
        , type_ "button"
        , onClick onClickMsg
        , attribute "aria-label" ariaLabel
        ]
        [ text buttonText ]
