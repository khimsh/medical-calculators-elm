module Calculators.Liquids exposing (Model, Msg(..), init, update, view)

import Calculators.Card as Card
import Calculators.InputError as InputError exposing (InputError(..))
import Calculators.Label as Label
import FormFields exposing (numberField)
import Functions exposing (floatToStr, roundToTwoDecimals, strToFloat)
import Html
import Translations exposing (Strings)


type alias Model =
    { prescribedLiquid : String
    , liquidDosageAthand : String
    , liquidVolumeAtHand : String
    , result : String
    , error : Maybe InputError
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
    | Reset


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangePrescribedLiquid newPrescribedLiquid ->
            { model | prescribedLiquid = newPrescribedLiquid, calculated = False, error = Nothing }

        ChangeLiquidDosageAthand newLiquidDosageAthand ->
            { model | liquidDosageAthand = newLiquidDosageAthand, calculated = False, error = Nothing }

        ChangeLiquidVolumeAtHand newLiquidVolumeAtHand ->
            { model | liquidVolumeAtHand = newLiquidVolumeAtHand, calculated = False, error = Nothing }

        Calculate ->
            if String.isEmpty model.prescribedLiquid || String.isEmpty model.liquidDosageAthand || String.isEmpty model.liquidVolumeAtHand then
                { model | error = Just InvalidInputs, result = "0.0", calculated = True }

            else
                case ( strToFloat model.prescribedLiquid, strToFloat model.liquidDosageAthand, strToFloat model.liquidVolumeAtHand ) of
                    ( Just prescribed, Just dosage, Just volume ) ->
                        if prescribed <= 0 || dosage <= 0 || volume <= 0 then
                            { model | error = Just NotPositive, result = "0.0", calculated = True }

                        else
                            { model | result = floatToStr (roundToTwoDecimals ((prescribed / dosage) * volume)), error = Nothing, calculated = True }

                    _ ->
                        { model | error = Just InvalidInputs, result = "0.0", calculated = True }

        Reset ->
            init


view : Strings -> Model -> Html.Html Msg
view strings model =
    Card.view
        { title = strings.peroralliquid
        , formula = strings.liquidFormula
        , calculateLabel = strings.calculate ++ ": " ++ strings.liquidDosage
        , resetLabel = strings.reset ++ ": " ++ strings.liquidDosage
        }
        [ numberField strings.prescribedAmount "liquid-prescribed-amount" model.prescribedLiquid ChangePrescribedLiquid
        , numberField strings.amountAtHand "liquid-available-amount" model.liquidDosageAthand ChangeLiquidDosageAthand
        , numberField strings.volumeAtHand "liquid-available-volume" model.liquidVolumeAtHand ChangeLiquidVolumeAtHand
        ]
        { calculateMsg = Calculate
        , resetMsg = Reset
        , calculateText = strings.calculate
        , resetText = strings.reset
        }
        (case model.error of
            Just error ->
                InputError.view strings error

            Nothing ->
                if model.calculated then
                    Label.view strings.calculationResult
                        { title = strings.drawUp
                        , value = model.result
                        , unit = strings.ml
                        , extra = []
                        , working =
                            [ model.prescribedLiquid
                                ++ " "
                                ++ strings.mg
                                ++ " ÷ "
                                ++ model.liquidDosageAthand
                                ++ " "
                                ++ strings.mg
                                ++ " × "
                                ++ model.liquidVolumeAtHand
                                ++ " "
                                ++ strings.ml
                            ]
                        }

                else
                    Label.empty strings.resultHint
        )
