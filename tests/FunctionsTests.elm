module FunctionsTests exposing (..)

import Expect
import Functions exposing (floatToStr, strToFloat)
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "Functions module"
        [ describe "strToFloat"
            [ test "converts valid integer string to float" <|
                \_ ->
                    strToFloat "42"
                        |> Expect.equal 42.0
            , test "converts valid decimal string to float" <|
                \_ ->
                    strToFloat "3.14"
                        |> Expect.within (Expect.Absolute 0.0001) 3.14
            , test "returns 0 for invalid string" <|
                \_ ->
                    strToFloat "invalid"
                        |> Expect.equal 0.0
            , test "returns 0 for empty string" <|
                \_ ->
                    strToFloat ""
                        |> Expect.equal 0.0
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
