module Main exposing (main, update, Model, Msg(..), init)

import Browser
import Functions exposing (..)
import Html exposing (button, div, form, h1, h2, input, label, p, text)
import Html.Attributes exposing (class, placeholder, type_, value)
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


update : Msg -> Model -> Model
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


view : Model -> Html.Html Msg
view model =
    div [ class "container" ]
        [ h1 [ class "title" ] [ text "Medical Calculators" ]
        , div [ class "subtitle" ] [ text "Implemented in Elm" ]
        , div [ class "calculators-container" ]
            [ div [ class "calculator-card" ]
                [ h2 [ class "card-title" ] [ text "Peroral Pill Dosage" ]
                , form [ class "form" ]
                    [ div [ class "field-group" ]
                        [ label [ class "label" ] [ text "Prescribed amount (mg)" ]
                        , input
                            [ class "input"
                            , placeholder "0.0"
                            , value model.prescribed
                            , onInput ChangePrescribed
                            , type_ "number"
                            ]
                            []
                        ]
                    , div [ class "field-group" ]
                        [ label [ class "label" ] [ text "Pill strength (mg)" ]
                        , input
                            [ class "input"
                            , placeholder "0.0"
                            , value model.tabletMg
                            , onInput ChangeTabletMg
                            , type_ "number"
                            ]
                            []
                        ]
                    , div [ class "button-container" ]
                        [ button [ class "button", onClick CalculateResult ] [ text "Calculate" ]
                        ]
                    , div [ class "result-container" ]
                        [ p [ class "result-label" ] [ text "Result:" ]
                        , p [ class "result-value" ] [ text model.result ]
                        , p [ class "result-unit" ] [ text "tablets" ]
                        ]
                    ]
                ]
            , div [ class "calculator-card" ]
                [ h2 [ class "card-title" ] [ text "Peroral Liquids Dosage" ]
                , form [ class "form" ]
                    [ div [ class "field-group" ]
                        [ label [ class "label" ] [ text "Prescribed amount (mg)" ]
                        , input
                            [ class "input"
                            , placeholder "0.0"
                            , value model.prescribedLiquid
                            , onInput ChangePrescribedLiquid
                            , type_ "number"
                            ]
                            []
                        ]
                    , div [ class "field-group" ]
                        [ label [ class "label" ] [ text "Amount at hand (mg)" ]
                        , input
                            [ class "input"
                            , placeholder "0.0"
                            , value model.liquidDosageAthand
                            , onInput ChangeLiquidDosageAthand
                            , type_ "number"
                            ]
                            []
                        ]
                    , div [ class "field-group" ]
                        [ label [ class "label" ] [ text "Volume at hand (mL)" ]
                        , input
                            [ class "input"
                            , placeholder "0.0"
                            , value model.liquidVolumeAtHand
                            , onInput ChangeLiquidVolumeAtHand
                            , type_ "number"
                            ]
                            []
                        ]
                    , div [ class "button-container" ]
                        [ button [ class "button", onClick CalculateLiquidDosage ] [ text "Calculate" ]
                        ]
                    , div [ class "result-container" ]
                        [ p [ class "result-label" ] [ text "Result:" ]
                        , p [ class "result-value" ] [ text model.liquidResult ]
                        , p [ class "result-unit" ] [ text "mL" ]
                        ]
                    ]
                ]
            ]
        ]
