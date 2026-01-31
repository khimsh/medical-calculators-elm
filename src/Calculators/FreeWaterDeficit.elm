module Calculators.FreeWaterDeficit exposing (Model, Msg(..), init, update, view)

import Functions exposing (calculateButton, errorDisplay, fieldGroup, floatToStr, resetButton, resultDisplay, roundToTwoDecimals, strToFloat)
import Html exposing (Html, div, h2, text)
import Html.Attributes exposing (attribute, class)
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
    div [ class "calculator-card", attribute "aria-label" strings.freeWaterDeficit ]
        [ h2 [ class "card-title" ] [ text strings.freeWaterDeficit ]
        , div [ class "form" ]
            [ fieldGroup strings.weight "weight" "0.0" model.weight UpdateWeight
            , fieldGroup strings.sodium "sodium" "0.0" model.sodium UpdateSodium
            , div [ class "button-container" ]
                [ calculateButton strings.calculate ("Calculate " ++ strings.freeWaterDeficit) Calculate
                , resetButton strings.reset ("Reset " ++ strings.freeWaterDeficit) Reset
                ]
            , case model.error of
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
            ]
        ]
