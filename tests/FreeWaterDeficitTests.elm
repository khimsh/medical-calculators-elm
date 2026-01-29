module FreeWaterDeficitTests exposing (tests)

import Calculators.FreeWaterDeficit exposing (Msg(..), init, update)
import Expect exposing (..)
import Test exposing (Test, describe, test)
import Translations exposing (Strings, englishStrings)



-- TESTS


testStrings : Strings
testStrings =
    englishStrings


tests : Test
tests =
    describe "Free Water Deficit Calculator"
        [ test "Initial model has empty fields and no result" <|
            \_ ->
                let
                    model =
                        init
                in
                Expect.equal model { weight = "", sodium = "", result = Nothing, error = Nothing }
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
        , test "Calculate computes the correct result" <|
            \_ ->
                let
                    model =
                        { init | weight = "70", sodium = "150" }

                    updatedModel =
                        update Calculate model testStrings
                in
                Expect.equal updatedModel.result (Just 5.0)
        , test "Calculate with empty inputs results in error" <|
            \_ ->
                let
                    model =
                        init

                    updatedModel =
                        update Calculate model testStrings
                in
                Expect.equal updatedModel.error (Just testStrings.invalidInputs)
        ]
