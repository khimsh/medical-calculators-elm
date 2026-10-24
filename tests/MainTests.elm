module MainTests exposing (..)

import Calculators.Liquids as Liquids
import Calculators.Pills as Pills
import Expect
import Test exposing (Test, describe, test)
import Translations exposing (englishStrings)


suite : Test
suite =
    describe "Calculator Modules Tests"
        [ describe "Pills Calculator"
            [ test "calculates correct number of tablets" <|
                \_ ->
                    let
                        initial =
                            Pills.init

                        model =
                            { initial | prescribed = "100", tabletMg = "50" }

                        updated =
                            Pills.update Pills.Calculate model englishStrings
                    in
                    updated.result
                        |> Expect.equal "2"
            , test "calculates decimal result" <|
                \_ ->
                    let
                        initial =
                            Pills.init

                        model =
                            { initial | prescribed = "75", tabletMg = "50" }

                        updated =
                            Pills.update Pills.Calculate model englishStrings
                    in
                    updated.result
                        |> Expect.equal "1.5"
            , test "handles division by zero" <|
                \_ ->
                    let
                        initial =
                            Pills.init

                        model =
                            { initial | prescribed = "100", tabletMg = "0" }

                        updated =
                            Pills.update Pills.Calculate model englishStrings
                    in
                    updated.error
                        |> Expect.equal (Just englishStrings.zeroNotAccepted)
            , test "rejects empty inputs" <|
                \_ ->
                    Pills.update Pills.Calculate Pills.init englishStrings
                        |> .error
                        |> Expect.equal (Just englishStrings.invalidInputs)
            , test "rounds to two decimals" <|
                \_ ->
                    let
                        initial =
                            Pills.init

                        model =
                            { initial | prescribed = "100", tabletMg = "30" }

                        updated =
                            Pills.update Pills.Calculate model englishStrings
                    in
                    updated.result
                        |> Expect.equal "3.33"
            , test "editing an input hides the previous result" <|
                \_ ->
                    let
                        initial =
                            Pills.init

                        calculated =
                            Pills.update Pills.Calculate { initial | prescribed = "100", tabletMg = "50" } englishStrings

                        edited =
                            Pills.update (Pills.ChangePrescribed "200") calculated englishStrings
                    in
                    edited.calculated
                        |> Expect.equal False
            ]
        , describe "Liquids Calculator"
            [ test "calculates correct liquid volume" <|
                \_ ->
                    let
                        initial =
                            Liquids.init

                        model =
                            { initial
                                | prescribedLiquid = "100"
                                , liquidDosageAthand = "50"
                                , liquidVolumeAtHand = "10"
                            }

                        updated =
                            Liquids.update Liquids.Calculate model englishStrings
                    in
                    updated.result
                        |> Expect.equal "20"
            , test "rejects a zero input" <|
                \_ ->
                    let
                        initial =
                            Liquids.init

                        model =
                            { initial
                                | prescribedLiquid = "100"
                                , liquidDosageAthand = "0"
                                , liquidVolumeAtHand = "10"
                            }

                        updated =
                            Liquids.update Liquids.Calculate model englishStrings
                    in
                    updated.error
                        |> Expect.equal (Just englishStrings.zeroNotAccepted)
            , test "rejects empty inputs" <|
                \_ ->
                    Liquids.update Liquids.Calculate Liquids.init englishStrings
                        |> .error
                        |> Expect.equal (Just englishStrings.invalidInputs)
            , test "rounds to two decimals" <|
                \_ ->
                    let
                        initial =
                            Liquids.init

                        model =
                            { initial
                                | prescribedLiquid = "10"
                                , liquidDosageAthand = "3"
                                , liquidVolumeAtHand = "1"
                            }

                        updated =
                            Liquids.update Liquids.Calculate model englishStrings
                    in
                    updated.result
                        |> Expect.equal "3.33"
            , test "editing an input hides the previous result" <|
                \_ ->
                    let
                        initial =
                            Liquids.init

                        calculated =
                            Liquids.update Liquids.Calculate
                                { initial
                                    | prescribedLiquid = "100"
                                    , liquidDosageAthand = "50"
                                    , liquidVolumeAtHand = "10"
                                }
                                englishStrings

                        edited =
                            Liquids.update (Liquids.ChangeLiquidVolumeAtHand "5") calculated englishStrings
                    in
                    edited.calculated
                        |> Expect.equal False
            ]
        ]
