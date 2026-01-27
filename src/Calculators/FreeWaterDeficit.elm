module Calculators.FreeWaterDeficit exposing (Model, Msg(..), init, update, view)

import Html exposing (Html, div, text, input, button, label, h2, p)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import Html.Attributes exposing (class)
import Html.Attributes exposing (attribute, for, id, placeholder, type_, value)
import Translations exposing (Strings)

-- MODEL

type alias Model =
    { weight : String
    , sodium : String
    , result : Maybe Float
    }

init : Model
init =
    { weight = ""
    , sodium = ""
    , result = Nothing
    }

-- UPDATE

type Msg
    = UpdateWeight String
    | UpdateSodium String
    | Calculate

update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateWeight weight ->
            { model | weight = weight, result = Nothing }

        UpdateSodium sodium ->
            { model | sodium = sodium, result = Nothing }

        Calculate ->
            let
                weightValue =
                    String.toFloat model.weight

                sodiumValue =
                    String.toFloat model.sodium

                result =
                    case ( weightValue, sodiumValue ) of
                        (Just w, Just s) ->
                            Just (0.6 * w * ((s / 140) - 1))

                        _ ->
                            Nothing
            in
            { model | result = result }

-- VIEW

view : Strings -> Model -> Html Msg
view strings model =
    div [ class "calculator-card", attribute "aria-label" strings.freeWaterDeficit ]
        [ h2 [ class "card-title" ] [ text strings.freeWaterDeficit ]
        , div [ class "form" ]
            [ div [ class "field-group" ]
                [ label [ class "label", for "weight" ] [ text strings.weight ]
                , input
                    [ class "input"
                    , id "weight"
                    , placeholder "0.0"
                    , value model.weight
                    , onInput UpdateWeight
                    , type_ "number"
                    , attribute "min" "0"
                    ]
                    []
                ]
            , div [ class "field-group" ]
                [ label [ class "label", for "sodium" ] [ text strings.sodium ]
                , input
                    [ class "input"
                    , id "sodium"
                    , placeholder "0.0"
                    , value model.sodium
                    , onInput UpdateSodium
                    , type_ "number"
                    , attribute "min" "0"
                    ]
                    []
                ]
            , div [ class "button-container" ]
                [ button [ class "button", type_ "button", onClick Calculate, attribute "aria-label" strings.freeWaterDeficit ] [ text strings.calculate ]
                ]
            , case model.result of
                Just r ->
                    div [ class "result-container", attribute "role" "region", attribute "aria-label" "Calculation result" ]
                        [ p [ class "result-label" ] [ text strings.result ]
                        , p [ class "result-value", attribute "aria-live" "polite" ] [ text (String.fromFloat r ++ " L") ]
                        ]

                Nothing ->
                    if model.weight == "0" || model.sodium == "0" then
                        div [ class "error-container", attribute "role" "alert" ]
                            [ p [ class "error-text" ] [ text strings.zeroNotAccepted ]
                            ]

                    else if model.weight /= "" && model.sodium /= "" && model.result == Nothing then
                        div [ class "error-container", attribute "role" "alert" ]
                            [ p [ class "error-text" ] [ text strings.invalidInputs ]
                            ]

                    else
                        text ""
            ]
        ]