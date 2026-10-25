module FreeWaterDeficitTests exposing (tests)

import Calculators.FreeWaterDeficit exposing (Model, Msg(..), Problem(..), init, update)
import Calculators.InputError exposing (InputError(..))
import Expect
import Functions exposing (Sex(..))
import Test exposing (Test, describe, test)



-- TESTS


calculate : Model -> Model
calculate model =
    update Calculate model


tests : Test
tests =
    describe "Free Water Deficit Calculator"
        [ test "70 kg man with Na 150 has a deficit of 3.0 L" <|
            \_ ->
                calculate { init | weight = "70", sodium = "150" }
                    |> .result
                    |> Expect.equal (Just 3.0)
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
                Expect.equal ( updatedModel.result, updatedModel.error ) ( Nothing, Just SodiumNotElevated )
        , test "Zero weight is rejected" <|
            \_ ->
                calculate { init | weight = "0", sodium = "150" }
                    |> .error
                    |> Expect.equal (Just (InputProblem NotPositive))
        , test "Negative weight is rejected" <|
            \_ ->
                calculate { init | weight = "-70", sodium = "150" }
                    |> .error
                    |> Expect.equal (Just (InputProblem NotPositive))
        , test "Zero sodium is rejected" <|
            \_ ->
                calculate { init | weight = "70", sodium = "0" }
                    |> .error
                    |> Expect.equal (Just (InputProblem NotPositive))
        , test "Unparseable input results in error" <|
            \_ ->
                calculate { init | weight = "abc", sodium = "150" }
                    |> .error
                    |> Expect.equal (Just (InputProblem InvalidInputs))
        , test "Calculate with empty inputs results in error" <|
            \_ ->
                calculate init
                    |> .error
                    |> Expect.equal (Just (InputProblem InvalidInputs))
        , test "Editing sodium clears the previous result" <|
            \_ ->
                let
                    calculated =
                        calculate { init | weight = "70", sodium = "150" }
                in
                update (UpdateSodium "160") calculated
                    |> .result
                    |> Expect.equal Nothing
        ]
