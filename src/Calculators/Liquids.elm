module Calculators.Liquids exposing (Model, Msg(..), init, update, view)

import Functions exposing (..)
import Html exposing (button, div, form, h2, p, text)
import Html.Attributes exposing (attribute, class, type_)
import Html.Events exposing (onClick)
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


roundToTwoDecimals : Float -> Float
roundToTwoDecimals number =
    toFloat (round (number * 100)) / 100
