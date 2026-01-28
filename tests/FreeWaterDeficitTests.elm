module FreeWaterDeficitTests exposing (tests)

import Calculators.FreeWaterDeficit exposing (Msg(..), init, update)
import Expect exposing (..)
import Test exposing (Test, describe, test)



-- TESTS


tests : Test
tests =
    describe "Free Water Deficit Calculator"
        [ test "Initial model has empty fields and no result" <|
            \_ ->
                let
                    model =
                        init
                in
                Expect.equal model { weight = "", sodium = "", result = Nothing }
        , test "Update weight updates the model" <|
            \_ ->
                let
                    model =
                        update (UpdateWeight "70") init
                in
                Expect.equal model.weight "70"
        , test "Update sodium updates the model" <|
            \_ ->
                let
                    model =
                        update (UpdateSodium "150") init
                in
                Expect.equal model.sodium "150"
        , test "Calculate computes the correct result" <|
            \_ ->
                let
                    model =
                        { init | weight = "70", sodium = "150" }

                    updatedModel =
                        update Calculate model
                in
                Expect.equal updatedModel.result (Just 3.0)
        , test "Calculate with invalid inputs results in Nothing" <|
            \_ ->
                let
                    model =
                        { init | weight = "abc", sodium = "150" }

                    updatedModel =
                        update Calculate model
                in
                Expect.equal updatedModel.result Nothing
        ]
