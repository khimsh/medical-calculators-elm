module IvInfusionRateTests exposing (tests)

import Calculators.IvInfusionRate exposing (DurationUnit(..), Model, Msg(..), init, update)
import Expect
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
    describe "IV Infusion Rate Calculator"
        [ test "starts empty with Hours and 20 drops/mL" <|
            \_ ->
                Expect.equal
                    ( ( init.volume, init.duration ), ( init.durationUnit, init.dropFactor ), ( init.result, init.error ) )
                    ( ( "", "" ), ( Hours, 20 ), ( Nothing, Nothing ) )
        , test "1000 mL over 8 h at 20 drops/mL is 125 mL/h and 42 drops/min" <|
            \_ ->
                calculate { init | volume = "1000", duration = "8" }
                    |> .result
                    |> Expect.equal (Just { mlPerHour = 125, dropsPerMinute = 42 })
        , test "100 mL over 30 min is 200 mL/h" <|
            \_ ->
                calculate { init | volume = "100", duration = "30", durationUnit = Minutes }
                    |> .result
                    |> Maybe.map .mlPerHour
                    |> Expect.equal (Just 200)
        , test "1000 mL over 7 h rounds to 142.9 mL/h" <|
            \_ ->
                calculate { init | volume = "1000", duration = "7" }
                    |> .result
                    |> Maybe.map .mlPerHour
                    |> Expect.equal (Just 142.9)
        , test "500 mL over 4 h at 15 drops/mL is 31 drops/min" <|
            \_ ->
                calculate { init | volume = "500", duration = "4", dropFactor = 15 }
                    |> .result
                    |> Maybe.map .dropsPerMinute
                    |> Expect.equal (Just 31)
        , test "250 mL over 3 h at 60 drops/mL is 83 drops/min" <|
            \_ ->
                calculate { init | volume = "250", duration = "3", dropFactor = 60 }
                    |> .result
                    |> Maybe.map .dropsPerMinute
                    |> Expect.equal (Just 83)
        , test "a half drop rounds up (249 mL over 1 h at 10 drops/mL is 42 drops/min)" <|
            \_ ->
                calculate { init | volume = "249", duration = "1", dropFactor = 10 }
                    |> .result
                    |> Maybe.map .dropsPerMinute
                    |> Expect.equal (Just 42)
        , test "Empty duration is rejected" <|
            \_ ->
                let
                    updatedModel =
                        calculate { init | volume = "500" }
                in
                Expect.equal ( updatedModel.result, updatedModel.error ) ( Nothing, Just testStrings.invalidInputs )
        , test "Zero duration is rejected" <|
            \_ ->
                let
                    updatedModel =
                        calculate { init | volume = "500", duration = "0" }
                in
                Expect.equal ( updatedModel.result, updatedModel.error ) ( Nothing, Just testStrings.zeroNotAccepted )
        , test "Negative volume is rejected" <|
            \_ ->
                let
                    updatedModel =
                        calculate { init | volume = "-100", duration = "2" }
                in
                Expect.equal ( updatedModel.result, updatedModel.error ) ( Nothing, Just testStrings.zeroNotAccepted )
        , test "Changing the drop factor clears the result" <|
            \_ ->
                let
                    updatedModel =
                        update (UpdateDropFactor 60) (calculate { init | volume = "1000", duration = "8" }) testStrings
                in
                Expect.equal ( updatedModel.result, updatedModel.dropFactor ) ( Nothing, 60 )
        , test "Changing an input clears an error" <|
            \_ ->
                update (UpdateDuration "2") (calculate { init | volume = "500" }) testStrings
                    |> .error
                    |> Expect.equal Nothing
        , test "Reset restores the defaults" <|
            \_ ->
                calculate { init | volume = "1000", duration = "30", durationUnit = Minutes, dropFactor = 60 }
                    |> (\model -> update Reset model testStrings)
                    |> Expect.equal init
        ]
