module WeightBasedDoseTests exposing (tests)

import Calculators.InputError as InputError exposing (InputError(..))
import Calculators.WeightBasedDose exposing (Model, Msg(..), init, update)
import Expect
import Functions exposing (formatToDecimals)
import Test exposing (Test, describe, test)



-- TESTS


calculate : Model -> Model
calculate model =
    update Calculate model


withInputs : String -> String -> Model
withInputs dosePerKg weight =
    calculate { init | dosePerKg = dosePerKg, weight = weight }


shownDose : Model -> Maybe String
shownDose model =
    Maybe.map (formatToDecimals 2) model.result


tests : Test
tests =
    describe "Weight-Based Dose Calculator"
        [ test "starts empty with no result and no error" <|
            \_ ->
                Expect.equal
                    ( ( init.dosePerKg, init.weight ), ( init.result, init.error ) )
                    ( ( "", "" ), ( Nothing, Nothing ) )
        , test "15 mg/kg and 70 kg shows 1050 mg" <|
            \_ ->
                shownDose (withInputs "15" "70")
                    |> Expect.equal (Just "1050")
        , test "2.5 mg/kg and 12.3 kg shows 30.75 mg" <|
            \_ ->
                shownDose (withInputs "2.5" "12.3")
                    |> Expect.equal (Just "30.75")
        , test "0.015 mg/kg and 4.2 kg shows 0.06 mg" <|
            \_ ->
                shownDose (withInputs "0.015" "4.2")
                    |> Expect.equal (Just "0.06")
        , test "100 mg/kg and 150 kg shows 15000 mg with no error" <|
            \_ ->
                let
                    model =
                        withInputs "100" "150"
                in
                Expect.equal ( shownDose model, model.error ) ( Just "15000", Nothing )
        , test "empty weight shows the invalid inputs error and no result" <|
            \_ ->
                let
                    model =
                        withInputs "15" ""
                in
                Expect.equal ( model.error, model.result ) ( Just InvalidInputs, Nothing )
        , test "non-numeric dose per kg shows the invalid inputs error" <|
            \_ ->
                let
                    model =
                        withInputs "abc" "70"
                in
                Expect.equal ( model.error, model.result ) ( Just InvalidInputs, Nothing )
        , test "zero dose per kg shows the values must be greater than zero error" <|
            \_ ->
                let
                    model =
                        withInputs "0" "70"
                in
                Expect.equal ( model.error, model.result ) ( Just NotPositive, Nothing )
        , test "negative weight shows the values must be greater than zero error" <|
            \_ ->
                let
                    model =
                        withInputs "15" "-70"
                in
                Expect.equal ( model.error, model.result ) ( Just NotPositive, Nothing )
        , test "changing the weight clears a shown result" <|
            \_ ->
                let
                    model =
                        update (UpdateWeight "71") (withInputs "15" "70")
                in
                Expect.equal ( model.result, model.error ) ( Nothing, Nothing )
        , test "changing the dose per kg clears a shown error" <|
            \_ ->
                let
                    model =
                        update (UpdateDosePerKg "16") (withInputs "15" "")
                in
                Expect.equal ( model.result, model.error ) ( Nothing, Nothing )
        , test "reset restores the empty state" <|
            \_ ->
                update Reset (withInputs "15" "70")
                    |> Expect.equal init
        ]
