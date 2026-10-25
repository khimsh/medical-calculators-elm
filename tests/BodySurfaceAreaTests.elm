module BodySurfaceAreaTests exposing (tests)

import Calculators.BodySurfaceArea exposing (Model, Msg(..), formatBsa, init, update)
import Calculators.InputError as InputError exposing (InputError(..))
import Expect
import Test exposing (Test, describe, test)
import Translations exposing (englishStrings, georgianStrings)



-- TESTS


calculate : Model -> Model
calculate model =
    update Calculate model


withInputs : String -> String -> Model
withInputs height weight =
    calculate { init | height = height, weight = weight }


tests : Test
tests =
    describe "Body Surface Area Calculator"
        [ test "starts empty with no result and no error" <|
            \_ ->
                Expect.equal
                    ( ( init.height, init.weight ), ( init.result, init.error ) )
                    ( ( "", "" ), ( Nothing, Nothing ) )
        , test "170 cm and 70 kg is about 1.82 m²" <|
            \_ ->
                (withInputs "170" "70").result
                    |> Maybe.map (\bsa -> abs (bsa - 1.8181) < 0.0001)
                    |> Expect.equal (Just True)
        , test "180 cm and 80 kg is 2 m²" <|
            \_ ->
                (withInputs "180" "80").result
                    |> Expect.equal (Just 2)
        , test "160 cm and 50 kg is about 1.49 m²" <|
            \_ ->
                (withInputs "160" "50").result
                    |> Maybe.map (\bsa -> abs (bsa - 1.4907) < 0.0001)
                    |> Expect.equal (Just True)
        , test "empty weight shows the invalid inputs error and no result" <|
            \_ ->
                let
                    model =
                        withInputs "170" ""
                in
                Expect.equal ( model.error, model.result ) ( Just InvalidInputs, Nothing )
        , test "non-numeric height shows the invalid inputs error" <|
            \_ ->
                let
                    model =
                        withInputs "tall" "70"
                in
                Expect.equal ( model.error, model.result ) ( Just InvalidInputs, Nothing )
        , test "zero height shows the values must be greater than zero error" <|
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
                        withInputs "170" "-70"
                in
                Expect.equal ( model.error, model.result ) ( Just NotPositive, Nothing )
        , test "changing the height clears a shown result" <|
            \_ ->
                let
                    model =
                        update (UpdateHeight "171") (withInputs "170" "70")
                in
                Expect.equal ( model.result, model.error ) ( Nothing, Nothing )
        , test "changing the weight clears a shown error" <|
            \_ ->
                let
                    model =
                        update (UpdateWeight "71") (withInputs "170" "")
                in
                Expect.equal ( model.result, model.error ) ( Nothing, Nothing )
        , test "reset restores the empty state" <|
            \_ ->
                update Reset (withInputs "170" "70")
                    |> Expect.equal init
        , test "2 m² is shown with two decimal places" <|
            \_ ->
                formatBsa 2
                    |> Expect.equal "2.00"
        , test "1.8181 m² is shown as 1.82" <|
            \_ ->
                formatBsa 1.8181
                    |> Expect.equal "1.82"
        , test "0.05 m² keeps its leading zero" <|
            \_ ->
                formatBsa 0.05
                    |> Expect.equal "0.05"
        , test "the unit is m² in English and მ² in Georgian" <|
            \_ ->
                Expect.equal ( englishStrings.bsaUnit, georgianStrings.bsaUnit ) ( "m²", "მ²" )
        ]
