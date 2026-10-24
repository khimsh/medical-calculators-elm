module FreeWaterDeficitTests exposing (tests)

import Calculators.FreeWaterDeficit exposing (Model, Msg(..), init, update)
import Expect exposing (..)
import Functions exposing (Sex(..), calculateFreeWaterDeficit, totalBodyWaterFactor)
import Test exposing (Test, describe, test)
import Translations exposing (Strings, englishStrings)



-- TESTS


testStrings : Strings
testStrings =
    englishStrings


calculate : Model -> Model
calculate model =
    update Calculate model testStrings


tests : Test
tests =
    describe "Free Water Deficit Calculator"
        [ test "Initial model has empty fields and no result" <|
            \_ ->
                let
                    model =
                        init
                in
                Expect.equal model { weight = "", sodium = "", sex = Male, elderly = False, result = Nothing, error = Nothing }
        , test "Update weight updates the model" <|
            \_ ->
                let
                    model =
                        update (UpdateWeight "70") init testStrings
                in
                Expect.equal model.weight "70"
        , test "Update sodium updates the model" <|
            \_ ->
                let
                    model =
                        update (UpdateSodium "150") init testStrings
                in
                Expect.equal model.sodium "150"
        , test "70 kg man with Na 150 has a deficit of 3.0 L" <|
            \_ ->
                calculate { init | weight = "70", sodium = "150" }
                    |> .result
                    |> Expect.equal (Just 3.0)
        , test "70 kg man with Na 160 has a deficit of 6.0 L" <|
            \_ ->
                calculate { init | weight = "70", sodium = "160" }
                    |> .result
                    |> Expect.equal (Just 6.0)
        , test "60 kg woman with Na 154 uses factor 0.5 (3.0 L)" <|
            \_ ->
                calculate { init | weight = "60", sodium = "154", sex = Female }
                    |> .result
                    |> Expect.equal (Just 3.0)
        , test "80 kg elderly man with Na 161 uses factor 0.5 (6.0 L)" <|
            \_ ->
                calculate { init | weight = "80", sodium = "161", elderly = True }
                    |> .result
                    |> Expect.equal (Just 6.0)
        , test "50 kg elderly woman with Na 154 uses factor 0.45 (2.25 L)" <|
            \_ ->
                calculate { init | weight = "50", sodium = "154", sex = Female, elderly = True }
                    |> .result
                    |> Expect.equal (Just 2.25)
        , test "Na of exactly 140 gives zero deficit" <|
            \_ ->
                calculate { init | weight = "70", sodium = "140" }
                    |> .result
                    |> Expect.equal (Just 0)
        , test "Na below 140 shows a message instead of a negative deficit" <|
            \_ ->
                let
                    updatedModel =
                        calculate { init | weight = "70", sodium = "130" }
                in
                Expect.equal ( updatedModel.result, updatedModel.error ) ( Nothing, Just testStrings.sodiumNotElevated )
        , test "Zero weight is rejected" <|
            \_ ->
                calculate { init | weight = "0", sodium = "150" }
                    |> .error
                    |> Expect.equal (Just testStrings.zeroNotAccepted)
        , test "Negative weight is rejected" <|
            \_ ->
                calculate { init | weight = "-70", sodium = "150" }
                    |> .error
                    |> Expect.equal (Just testStrings.zeroNotAccepted)
        , test "Zero sodium is rejected" <|
            \_ ->
                calculate { init | weight = "70", sodium = "0" }
                    |> .error
                    |> Expect.equal (Just testStrings.zeroNotAccepted)
        , test "Unparseable input results in error" <|
            \_ ->
                calculate { init | weight = "abc", sodium = "150" }
                    |> .error
                    |> Expect.equal (Just testStrings.invalidInputs)
        , test "Calculate with empty inputs results in error" <|
            \_ ->
                calculate init
                    |> .error
                    |> Expect.equal (Just testStrings.invalidInputs)
        , describe "totalBodyWaterFactor"
            [ test "adult man" <| \_ -> totalBodyWaterFactor Male False |> Expect.within (Expect.Absolute 0.0001) 0.6
            , test "elderly man" <| \_ -> totalBodyWaterFactor Male True |> Expect.within (Expect.Absolute 0.0001) 0.5
            , test "adult woman" <| \_ -> totalBodyWaterFactor Female False |> Expect.within (Expect.Absolute 0.0001) 0.5
            , test "elderly woman" <| \_ -> totalBodyWaterFactor Female True |> Expect.within (Expect.Absolute 0.0001) 0.45
            ]
        , test "calculateFreeWaterDeficit returns liters" <|
            \_ ->
                calculateFreeWaterDeficit Male False 70 150
                    |> Expect.within (Expect.Absolute 0.0001) 3.0
        ]
