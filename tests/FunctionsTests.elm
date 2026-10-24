module FunctionsTests exposing (..)

import Expect
import Functions exposing (calculateCalories, floatToStr, strToFloat)
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
            ]
        , describe "floatToStr"
            [ test "converts integer to string" <|
                \_ ->
                    floatToStr 42
                        |> Expect.equal "42"
            , test "converts decimal float to string" <|
                \_ ->
                    floatToStr 3.14
                        |> Expect.equal "3.14"
            , test "converts zero to string" <|
                \_ ->
                    floatToStr 0.0
                        |> Expect.equal "0"
            ]
        ]
