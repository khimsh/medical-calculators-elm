module Calculators.Liquids exposing (Model, Msg(..), init, update, view)

import Functions exposing (..)
import Translations exposing (Language, Strings)
import Html exposing (button, div, form, h2, input, label, p, text)
import Html.Attributes exposing (attribute, class, for, id, placeholder, type_, value)
import Html.Events exposing (onClick, onInput)


type alias Model =
    { prescribedLiquid : String
    , liquidDosageAthand : String
    , liquidVolumeAtHand : String
    , result : String
    , error : Maybe String
    , calculated : Bool
    }


init : Model
init =
    { prescribedLiquid = ""
    , liquidDosageAthand = ""
    , liquidVolumeAtHand = ""
    , result = ""
    , error = Nothing
    , calculated = False
    }


type Msg
    = ChangePrescribedLiquid String
    | ChangeLiquidDosageAthand String
    | ChangeLiquidVolumeAtHand String
    | Calculate


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangePrescribedLiquid newPrescribedLiquid ->
            { model | prescribedLiquid = newPrescribedLiquid }

        ChangeLiquidDosageAthand newLiquidDosageAthand ->
            { model | liquidDosageAthand = newLiquidDosageAthand }

        ChangeLiquidVolumeAtHand newLiquidVolumeAtHand ->
            { model | liquidVolumeAtHand = newLiquidVolumeAtHand }

        Calculate ->
            let
                prescribed =
                    strToFloat model.prescribedLiquid

                dosage =
                    strToFloat model.liquidDosageAthand

                volume =
                    strToFloat model.liquidVolumeAtHand
            in
            if dosage == 0 then
                { model | error = Just "Cannot divide by zero", result = "0.0", calculated = True }

            else if prescribed == 0 || volume == 0 then
                { model | error = Just "Invalid input", result = "0.0", calculated = True }

            else
                { model | result = floatToStr ((prescribed / dosage) * volume), error = Nothing, calculated = True }


view : Language -> Strings -> Model -> Html.Html Msg
view language strings model =
    div [ class "calculator-card", attribute "aria-label" strings.peroralliquid ]
        [ h2 [ class "card-title" ] [ text strings.peroralliquid ]
        , form [ class "form" ]
            [ div [ class "field-group" ]
                [ label [ class "label", for "liquid-prescribed-amount" ] [ text strings.prescribedAmount ]
                , input
                    [ class "input"
                    , id "liquid-prescribed-amount"
                    , placeholder "0.0"
                    , value model.prescribedLiquid
                    , onInput ChangePrescribedLiquid
                    , type_ "number"
                    , attribute "min" "0"
                    ]
                    []
                ]
            , div [ class "field-group" ]
                [ label [ class "label", for "liquid-dosage-athand" ] [ text strings.amountAtHand ]
                , input
                    [ class "input"
                    , id "liquid-dosage-athand"
                    , placeholder "0.0"
                    , value model.liquidDosageAthand
                    , onInput ChangeLiquidDosageAthand
                    , type_ "number"
                    , attribute "min" "0"
                    ]
                    []
                ]
            , div [ class "field-group" ]
                [ label [ class "label", for "liquid-volume-athand" ] [ text strings.volumeAtHand ]
                , input
                    [ class "input"
                    , id "liquid-volume-athand"
                    , placeholder "0.0"
                    , value model.liquidVolumeAtHand
                    , onInput ChangeLiquidVolumeAtHand
                    , type_ "number"
                    , attribute "min" "0"
                    ]
                    []
                ]
            , div [ class "button-container" ]
                [ button [ class "button", type_ "button", onClick Calculate, attribute "aria-label" ("Calculate " ++ strings.liquidDosage) ] [ text strings.calculate ]
                ]
            , case model.error of
                Just error ->
                    div [ class "error-container", attribute "role" "alert" ]
                        [ p [ class "error-text" ] [ text error ]
                        ]

                Nothing ->
                    if model.calculated then
                        div [ class "result-container", attribute "role" "region", attribute "aria-label" "Calculation result" ]
                            [ p [ class "result-label" ] [ text strings.result ]
                            , p [ class "result-value", attribute "aria-live" "polite" ] [ text model.result ]
                            , p [ class "result-unit" ] [ text strings.ml ]
                            ]

                    else
                        text ""
            ]
        ]
