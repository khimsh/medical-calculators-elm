module Functions exposing (..)

import Html exposing (button, div, input, label, text)
import Html.Attributes exposing (attribute, class, for, id, type_, value)
import Html.Events exposing (onClick, onInput)


{-| Parses a user-entered number. Returns Nothing for empty or unparseable
input (and NaN/Infinity) so callers can show an error instead of using 0.
-}
strToFloat : String -> Maybe Float
strToFloat string =
    String.toFloat (String.trim string)
        |> Maybe.andThen
            (\float ->
                if isNaN float || isInfinite float then
                    Nothing

                else
                    Just float
            )


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


{-| Daily energy (kcal) split 25% protein, 25% fat, 50% carbohydrate.
Macros are returned in grams: 4 kcal/g for protein and carbohydrate, 9 kcal/g for fat.
-}
calculateCalories : Float -> Float -> Int -> NutritionResult
calculateCalories weight bmi score =
    let
        energy =
            if score <= 1 then
                25 * weight

            else if bmi < 14 then
                5 * weight

            else if bmi < 16 then
                10 * weight

            else
                30 * weight
    in
    NutritionResult energy (energy * 0.25 / 4) (energy * 0.25 / 9) (energy * 0.5 / 4)


type Sex
    = Male
    | Female


{-| Fraction of body weight that is total body water.
Elderly means 65 years or older.
-}
totalBodyWaterFactor : Sex -> Bool -> Float
totalBodyWaterFactor sex elderly =
    case ( sex, elderly ) of
        ( Male, False ) ->
            0.6

        ( Male, True ) ->
            0.5

        ( Female, False ) ->
            0.5

        ( Female, True ) ->
            0.45


{-| Free water deficit in liters: TBW factor × weight (kg) × (Na / 140 − 1).
-}
calculateFreeWaterDeficit : Sex -> Bool -> Float -> Float -> Float
calculateFreeWaterDeficit sex elderly weight sodium =
    totalBodyWaterFactor sex elderly * weight * (sodium / 140 - 1)


fieldGroup : String -> String -> String -> String -> (String -> msg) -> Html.Html msg
fieldGroup labelText inputId placeholderText valueText onInputMsg =
    div []
        [ label [ for inputId ] [ text labelText ]
        , input
            [ id inputId
            , Html.Attributes.attribute "placeholder" placeholderText
            , Html.Attributes.value valueText
            , onInput onInputMsg
            , type_ "number"
            , attribute "min" "0"
            , Html.Attributes.autocomplete False
            ]
            []
        ]


errorDisplay : String -> Html.Html msg
errorDisplay errorMessage =
    div [ class "error", attribute "role" "alert" ]
        [ Html.p [] [ text errorMessage ]
        ]


calculateButton : String -> String -> msg -> Html.Html msg
calculateButton buttonText ariaLabel onClickMsg =
    button
        [ type_ "button"
        , onClick onClickMsg
        , attribute "aria-label" ariaLabel
        ]
        [ text buttonText ]


resetButton : String -> String -> msg -> Html.Html msg
resetButton buttonText ariaLabel onClickMsg =
    button
        [ type_ "reset"
        , onClick onClickMsg
        , attribute "aria-label" ariaLabel
        ]
        [ text buttonText ]
