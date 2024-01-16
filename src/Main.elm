module Main exposing (main, update)

import Browser
import Functions exposing (..)
import Html exposing (button, div, form, h1, h2, input, label, p, text)
import Html.Attributes exposing (placeholder, value)
import Html.Events exposing (onClick, onInput)


main : Program () Model Msg
main =
    Browser.sandbox { init = init, update = update, view = view }


type alias Model =
    { prescribed : String
    , tabletMg : String
    , result : String
    , prescribedLiquid : String
    , liquidDosageAthand : String
    , liquidVolumeAtHand : String
    , liquidResult : String
    }


init : Model
init =
    { prescribed = ""
    , tabletMg = ""
    , result = "0.0"
    , prescribedLiquid = ""
    , liquidDosageAthand = ""
    , liquidVolumeAtHand = ""
    , liquidResult = ""
    }


type Msg
    = ChangePrescribed String
    | ChangeTabletMg String
    | CalculateResult
    | ChangePrescribedLiquid String
    | ChangeLiquidDosageAthand String
    | ChangeLiquidVolumeAtHand String
    | CalculateLiquidDosage


update msg model =
    case msg of
        ChangePrescribed newPrescribed ->
            { model | prescribed = newPrescribed }

        ChangeTabletMg newTablet ->
            { model | tabletMg = newTablet }

        CalculateResult ->
            { model | result = floatToStr (strToFloat model.prescribed / strToFloat model.tabletMg) }

        ChangePrescribedLiquid newPrescribedLiquid ->
            { model | prescribedLiquid = newPrescribedLiquid }

        ChangeLiquidDosageAthand newLiquidDosageAthand ->
            { model | liquidDosageAthand = newLiquidDosageAthand }

        ChangeLiquidVolumeAtHand newLiquidVolumeAtHand ->
            { model | liquidVolumeAtHand = newLiquidVolumeAtHand }

        CalculateLiquidDosage ->
            { model | liquidResult = floatToStr ((strToFloat model.prescribedLiquid / strToFloat model.liquidDosageAthand) * strToFloat model.liquidVolumeAtHand) }


view model =
    div []
        [ h1 [] [ text "Medical Calculators implemented in Elm" ]
        , div []
            [ h2 [] [ text "Peroral Pill Dosage" ]
            , form []
                [ label [] [ text "Prescribed amount" ]
                , input [ placeholder "0.0", value model.prescribed, onInput ChangePrescribed ] []
                ]
            , div []
                [ label [] [ text "Pill Mg" ]
                , input [ placeholder "0.0", value model.tabletMg, onInput ChangeTabletMg ] []
                ]
            , div []
                [ button [ onClick CalculateResult ] [ text "Calculate" ]
                ]
            , div []
                [ p [] [ text "Result:" ]
                , p [] [ text model.result ]
                ]
            ]
        , div []
            [ h2 [] [ text "Peroral Liquids Dosage" ]
            , form []
                [ label [] [ text "Prescribed amount" ]
                , input [ placeholder "0.0", value model.prescribedLiquid, onInput ChangePrescribedLiquid ] []
                ]
            , div []
                [ label [] [ text "Amount at hand" ]
                , input [ placeholder "0.0", value model.liquidDosageAthand, onInput ChangeLiquidDosageAthand ] []
                ]
            , div []
                [ label [] [ text "Volume at hand" ]
                , input [ placeholder "0.0", value model.liquidVolumeAtHand, onInput ChangeLiquidVolumeAtHand ] []
                ]
            , div []
                [ button [ onClick CalculateLiquidDosage ] [ text "Calculate" ]
                ]
            , div []
                [ p [] [ text "Result:" ]
                , p [] [ text model.liquidResult ]
                ]
            ]
        ]
