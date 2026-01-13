module MainTests exposing (..)

import Expect
import Main exposing (Msg(..), init, update)
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "Main module - Calculator Tests"
        [ describe "Pill Dosage Calculator"
            [ test "calculates correct number of tablets for simple case" <|
                \_ ->
                    let
                        model =
                            { init | prescribed = "100", tabletMg = "50" }

                        updatedModel =
                            update CalculateResult model
                    in
                    updatedModel.result
                        |> Expect.equal "2"
            , test "calculates correct number of tablets for decimal result" <|
                \_ ->
                    let
                        model =
                            { init | prescribed = "75", tabletMg = "50" }

                        updatedModel =
                            update CalculateResult model
                    in
                    updatedModel.result
                        |> Expect.equal "1.5"
            , test "handles division by zero gracefully" <|
                \_ ->
                    let
                        model =
                            { init | prescribed = "100", tabletMg = "0" }

                        updatedModel =
                            update CalculateResult model
                    in
                    -- Division by zero results in Infinity, which becomes "Infinity" as string
                    updatedModel.result
                        |> Expect.equal "Infinity"
            , test "handles empty input fields" <|
                \_ ->
                    let
                        model =
                            { init | prescribed = "", tabletMg = "" }

                        updatedModel =
                            update CalculateResult model
                    in
                    -- 0 / 0 = NaN, which becomes "NaN" as string
                    updatedModel.result
                        |> Expect.equal "NaN"
            , test "calculates for large numbers" <|
                \_ ->
                    let
                        model =
                            { init | prescribed = "1000", tabletMg = "250" }

                        updatedModel =
                            update CalculateResult model
                    in
                    updatedModel.result
                        |> Expect.equal "4"
            , test "calculates for small decimal numbers" <|
                \_ ->
                    let
                        model =
                            { init | prescribed = "0.5", tabletMg = "0.25" }

                        updatedModel =
                            update CalculateResult model
                    in
                    updatedModel.result
                        |> Expect.equal "2"
            ]
        , describe "Liquid Dosage Calculator"
            [ test "calculates correct liquid volume for simple case" <|
                \_ ->
                    let
                        model =
                            { init
                                | prescribedLiquid = "100"
                                , liquidDosageAthand = "50"
                                , liquidVolumeAtHand = "10"
                            }

                        updatedModel =
                            update CalculateLiquidDosage model
                    in
                    updatedModel.liquidResult
                        |> Expect.equal "20"
            , test "calculates correct liquid volume for decimal result" <|
                \_ ->
                    let
                        model =
                            { init
                                | prescribedLiquid = "75"
                                , liquidDosageAthand = "50"
                                , liquidVolumeAtHand = "10"
                            }

                        updatedModel =
                            update CalculateLiquidDosage model
                    in
                    updatedModel.liquidResult
                        |> Expect.equal "15"
            , test "handles division by zero in liquid calculator" <|
                \_ ->
                    let
                        model =
                            { init
                                | prescribedLiquid = "100"
                                , liquidDosageAthand = "0"
                                , liquidVolumeAtHand = "10"
                            }

                        updatedModel =
                            update CalculateLiquidDosage model
                    in
                    updatedModel.liquidResult
                        |> Expect.equal "Infinity"
            , test "calculates for complex medical scenario" <|
                \_ ->
                    let
                        -- Example: Need 200mg, have 100mg per 5mL, need 10mL
                        model =
                            { init
                                | prescribedLiquid = "200"
                                , liquidDosageAthand = "100"
                                , liquidVolumeAtHand = "5"
                            }

                        updatedModel =
                            update CalculateLiquidDosage model
                    in
                    updatedModel.liquidResult
                        |> Expect.equal "10"
            , test "handles empty input fields in liquid calculator" <|
                \_ ->
                    let
                        model =
                            { init
                                | prescribedLiquid = ""
                                , liquidDosageAthand = ""
                                , liquidVolumeAtHand = ""
                            }

                        updatedModel =
                            update CalculateLiquidDosage model
                    in
                    updatedModel.liquidResult
                        |> Expect.equal "NaN"
            , test "calculates for fractional dosages" <|
                \_ ->
                    let
                        model =
                            { init
                                | prescribedLiquid = "12.5"
                                , liquidDosageAthand = "25"
                                , liquidVolumeAtHand = "5"
                            }

                        updatedModel =
                            update CalculateLiquidDosage model
                    in
                    updatedModel.liquidResult
                        |> Expect.equal "2.5"
            ]
        , describe "Model Updates"
            [ test "updates prescribed amount correctly" <|
                \_ ->
                    let
                        updatedModel =
                            update (ChangePrescribed "150") init
                    in
                    updatedModel.prescribed
                        |> Expect.equal "150"
            , test "updates tabletMg correctly" <|
                \_ ->
                    let
                        updatedModel =
                            update (ChangeTabletMg "25") init
                    in
                    updatedModel.tabletMg
                        |> Expect.equal "25"
            , test "updates prescribedLiquid correctly" <|
                \_ ->
                    let
                        updatedModel =
                            update (ChangePrescribedLiquid "200") init
                    in
                    updatedModel.prescribedLiquid
                        |> Expect.equal "200"
            ]
        , describe "Edge Cases"
            [ test "handles very small numbers" <|
                \_ ->
                    let
                        model =
                            { init | prescribed = "0.001", tabletMg = "0.0005" }

                        updatedModel =
                            update CalculateResult model
                    in
                    updatedModel.result
                        |> Expect.equal "2"
            , test "handles very large numbers" <|
                \_ ->
                    let
                        model =
                            { init | prescribed = "1000000", tabletMg = "500000" }

                        updatedModel =
                            update CalculateResult model
                    in
                    updatedModel.result
                        |> Expect.equal "2"
            ]
        ]
