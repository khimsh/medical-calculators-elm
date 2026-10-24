module FunctionsTests exposing (..)

import Expect
import Functions exposing (calculateBMI, calculateCalories, scoreCalculator, strToFloat)
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "Functions module"
        [ describe "strToFloat"
            [ test "converts valid integer string to float" <|
                \_ ->
                    strToFloat "42"
                        |> Expect.equal (Just 42.0)
            , test "converts valid decimal string to float" <|
                \_ ->
                    strToFloat "3.14"
                        |> Maybe.withDefault 0
                        |> Expect.within (Expect.Absolute 0.0001) 3.14
            , test "returns Nothing for invalid string" <|
                \_ ->
                    strToFloat "invalid"
                        |> Expect.equal Nothing
            , test "returns Nothing for empty string" <|
                \_ ->
                    strToFloat ""
                        |> Expect.equal Nothing
            , test "returns Nothing for NaN" <|
                \_ ->
                    strToFloat "NaN"
                        |> Expect.equal Nothing
            , test "parses negative numbers so callers can reject them" <|
                \_ ->
                    strToFloat "-5"
                        |> Expect.equal (Just -5)
            ]
        , describe "calculateCalories"
            [ test "70 kg, low risk: 25 kcal/kg = 1750 kcal" <|
                \_ ->
                    (calculateCalories 70 22 0).calories
                        |> Expect.within (Expect.Absolute 0.0001) 1750
            , test "70 kg, low risk: protein is 25% of energy at 4 kcal/g" <|
                \_ ->
                    (calculateCalories 70 22 0).proteins
                        |> Expect.within (Expect.Absolute 0.0001) 109.375
            , test "70 kg, low risk: fat is 25% of energy at 9 kcal/g" <|
                \_ ->
                    (calculateCalories 70 22 0).fats
                        |> Expect.within (Expect.Absolute 0.0001) 48.6111
            , test "70 kg, low risk: carbs are 50% of energy at 4 kcal/g" <|
                \_ ->
                    (calculateCalories 70 22 0).carbs
                        |> Expect.within (Expect.Absolute 0.0001) 218.75
            , test "high risk with BMI 15 uses 10 kcal/kg" <|
                \_ ->
                    (calculateCalories 40 15 2).calories
                        |> Expect.within (Expect.Absolute 0.0001) 400
            , test "high risk with BMI 13 uses 5 kcal/kg" <|
                \_ ->
                    (calculateCalories 40 13 2).calories
                        |> Expect.within (Expect.Absolute 0.0001) 200
            , test "high risk with BMI 17 uses 30 kcal/kg" <|
                \_ ->
                    (calculateCalories 60 17 2).calories
                        |> Expect.within (Expect.Absolute 0.0001) 1800
            , test "score 1 is still low risk: 25 kcal/kg" <|
                \_ ->
                    (calculateCalories 60 19 1).calories
                        |> Expect.within (Expect.Absolute 0.0001) 1500
            , test "high risk with BMI exactly 16 uses 30 kcal/kg" <|
                \_ ->
                    (calculateCalories 60 16 2).calories
                        |> Expect.within (Expect.Absolute 0.0001) 1800
            , test "high risk with BMI exactly 14 uses 10 kcal/kg" <|
                \_ ->
                    (calculateCalories 60 14 2).calories
                        |> Expect.within (Expect.Absolute 0.0001) 600
            ]
        , describe "calculateBMI"
            [ test "70 kg at 175 cm" <|
                \_ ->
                    calculateBMI 70 175
                        |> Expect.within (Expect.Absolute 0.001) 22.857
            ]
        , describe "scoreCalculator"
            [ test "BMI above 20 scores 0" <|
                \_ ->
                    scoreCalculator 22 0 False
                        |> Expect.equal 0
            , test "BMI exactly 20 scores 1" <|
                \_ ->
                    scoreCalculator 20 0 False
                        |> Expect.equal 1
            , test "BMI exactly 18.5 scores 1" <|
                \_ ->
                    scoreCalculator 18.5 0 False
                        |> Expect.equal 1
            , test "BMI below 18.5 scores 2" <|
                \_ ->
                    scoreCalculator 18.4 0 False
                        |> Expect.equal 2
            , test "5-10% weight loss adds 1" <|
                \_ ->
                    scoreCalculator 22 2 False
                        |> Expect.equal 1
            , test "more than 10% weight loss adds 2" <|
                \_ ->
                    scoreCalculator 22 3 False
                        |> Expect.equal 2
            , test "critical illness adds 2" <|
                \_ ->
                    scoreCalculator 22 0 True
                        |> Expect.equal 2
            ]
        ]
