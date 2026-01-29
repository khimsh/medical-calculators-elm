module Calculators.Liquids exposing (Model, Msg(..), init, update, view)

import Functions exposing (..)
import Html exposing (div, form, h2, text)
import Html.Attributes exposing (attribute, class)
import Translations exposing (Strings)


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


update : Msg -> Model -> Strings -> Model
update msg model strings =
    case msg of
        ChangePrescribedLiquid newPrescribedLiquid ->
            { model | prescribedLiquid = newPrescribedLiquid, calculated = False, error = Nothing }

        ChangeLiquidDosageAthand newLiquidDosageAthand ->
            { model | liquidDosageAthand = newLiquidDosageAthand, calculated = False, error = Nothing }

        ChangeLiquidVolumeAtHand newLiquidVolumeAtHand ->
            { model | liquidVolumeAtHand = newLiquidVolumeAtHand, calculated = False, error = Nothing }

        Calculate ->
            if String.isEmpty model.prescribedLiquid || String.isEmpty model.liquidDosageAthand || String.isEmpty model.liquidVolumeAtHand then
                { model | error = Just strings.invalidInputs, result = "0.0", calculated = True }

            else
                let
                    prescribed =
                        strToFloat model.prescribedLiquid

                    dosage =
                        strToFloat model.liquidDosageAthand

                    volume =
                        strToFloat model.liquidVolumeAtHand
                in
                if prescribed == 0 || dosage == 0 || volume == 0 then
                    { model | error = Just strings.zeroNotAccepted, result = "0.0", calculated = True }

                else
                    { model | result = floatToStr (roundToTwoDecimals ((prescribed / dosage) * volume)), error = Nothing, calculated = True }


view : Strings -> Model -> Html.Html Msg
view strings model =
    div [ class "calculator-card", attribute "aria-label" strings.peroralliquid ]
        [ h2 [ class "card-title" ] [ text strings.peroralliquid ]
        , form [ class "form" ]
            [ fieldGroup strings.prescribedAmount "liquid-prescribed-amount" "0.0" model.prescribedLiquid ChangePrescribedLiquid
            , fieldGroup strings.amountAtHand "liquid-dosage-athand" "0.0" model.liquidDosageAthand ChangeLiquidDosageAthand
            , fieldGroup strings.volumeAtHand "liquid-volume-athand" "0.0" model.liquidVolumeAtHand ChangeLiquidVolumeAtHand
            , div [ class "button-container" ]
                [ calculateButton strings.calculate ("Calculate " ++ strings.liquidDosage) Calculate ]
            , case model.error of
                Just error ->
                    errorDisplay error

                Nothing ->
                    if model.calculated && not (String.isEmpty model.prescribedLiquid || String.isEmpty model.liquidDosageAthand || String.isEmpty model.liquidVolumeAtHand) then
                        resultDisplay strings.result model.result strings.ml

                    else
                        text ""
            ]
        ]
