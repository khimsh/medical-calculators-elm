module NutritionTests exposing (tests)

import Calculators.Nutrition exposing (Model, Msg(..), init, update)
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
    describe "Nutrition Calculator"
        [ test "70 kg at 175 cm with no risk factors needs 1750 kcal" <|
            \_ ->
                calculate { init | weight = "70", height = "175" }
                    |> (\model -> [ model.bmi, model.calories, model.proteins, model.fats, model.carbs ])
                    |> Expect.equal [ "22.86", "1750", "109", "49", "219" ]
        , test "critically ill 40 kg at 170 cm gets 5 kcal/kg (200 kcal)" <|
            \_ ->
                calculate { init | weight = "40", height = "170", critical = True }
                    |> .calories
                    |> Expect.equal "200"
        , test "Calculate with empty inputs results in error" <|
            \_ ->
                calculate init
                    |> .error
                    |> Expect.equal (Just testStrings.invalidInputs)
        , test "Zero height is rejected" <|
            \_ ->
                calculate { init | weight = "70", height = "0" }
                    |> .error
                    |> Expect.equal (Just testStrings.zeroNotAccepted)
        , test "Negative weight is rejected" <|
            \_ ->
                calculate { init | weight = "-70", height = "175" }
                    |> .error
                    |> Expect.equal (Just testStrings.zeroNotAccepted)
        , test "Unparseable input results in error" <|
            \_ ->
                calculate { init | weight = "abc", height = "175" }
                    |> .error
                    |> Expect.equal (Just testStrings.invalidInputs)
        , test "Editing an input hides the previous result" <|
            \_ ->
                let
                    calculated =
                        calculate { init | weight = "70", height = "175" }
                in
                update (ChangeWeight "80") calculated testStrings
                    |> .calculated
                    |> Expect.equal False
        ]
