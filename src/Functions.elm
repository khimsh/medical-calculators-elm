module Functions exposing (..)


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
