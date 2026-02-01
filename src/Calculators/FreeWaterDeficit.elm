module Calculators.FreeWaterDeficit exposing (Model, Msg(..), init, update, view)

import Calculators.Card as Card
import FormFields exposing (numberField)
import Functions exposing (errorDisplay, floatToStr, resultDisplay, roundToTwoDecimals, strToFloat)
import Html exposing (Html, text)
import Translations exposing (Strings)



-- MODEL


type alias Model =
    { weight : String
    , sodium : String
    , result : Maybe Float
    , error : Maybe String
    }


init : Model
init =
    { weight = ""
    , sodium = ""
    , result = Nothing
    , error = Nothing
    }



-- UPDATE


type Msg
    = UpdateWeight String
    | UpdateSodium String
    | Calculate
    | Reset


update : Msg -> Model -> Strings -> Model
update msg model strings =
    case msg of
        UpdateWeight weight ->
            { model | weight = weight, result = Nothing, error = Nothing }

        UpdateSodium sodium ->
            { model | sodium = sodium, result = Nothing, error = Nothing }

        Calculate ->
            if String.isEmpty model.weight || String.isEmpty model.sodium then
                { model | error = Just strings.invalidInputs, result = Nothing }

            else
                let
                    weightValue =
                        strToFloat model.weight

                    sodiumValue =
                        strToFloat model.sodium

                    result =
                        weightValue * (sodiumValue - 140) / 140
                in
                { model | result = Just (roundToTwoDecimals result), error = Nothing }

        Reset ->
            init



-- VIEW


view : Strings -> Model -> Html Msg
view strings model =
    Card.view
        { title = strings.freeWaterDeficit
        , ariaLabel = strings.freeWaterDeficit
        , calculateLabel = "Calculate " ++ strings.freeWaterDeficit
        , resetLabel = "Reset " ++ strings.freeWaterDeficit
        }
        [ numberField strings.weight "weight" "0.0" model.weight UpdateWeight
        , numberField strings.sodium "sodium" "0.0" model.sodium UpdateSodium
        ]
        { calculateMsg = Calculate
        , resetMsg = Reset
        , calculateText = strings.calculate
        , resetText = strings.reset
        }
        (case model.error of
            Just error ->
                errorDisplay error

            Nothing ->
                case model.result of
                    Just result ->
                        if String.isEmpty model.weight || String.isEmpty model.sodium then
                            text ""

                        else
                            resultDisplay strings.result (floatToStr result) strings.ml

                    Nothing ->
                        text ""
        )
