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
            , test "calculates decimal result" <|
                \_ ->
                    let
                        initial =
                            Liquids.init

                        model =
                            { initial
                                | prescribedLiquid = "75"
                                , liquidDosageAthand = "50"
                                , liquidVolumeAtHand = "10"
                            }

                        updated =
                            Liquids.update Liquids.Calculate model englishStrings
                    in
                    updated.result
                        |> Expect.equal "15"
            ]
        ]
