module Calculators.FreeWaterDeficit exposing (Model, Msg(..), init, update, view)

import Functions exposing (fieldGroup)
import Html exposing (Html, button, div, h2, p, text)
import Html.Attributes exposing (attribute, class, type_)
import Html.Events exposing (onClick)
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
                        ( Just w, Just s ) ->
                            Just (roundToTwoDecimals (0.6 * w * ((s / 140) - 1)))

                        _ ->
                            Nothing
            in
            { model | result = result }


roundToTwoDecimals : Float -> Float
roundToTwoDecimals number =
    toFloat (round (number * 100)) / 100



-- VIEW


view : Strings -> Model -> Html Msg
view strings model =
    div [ class "calculator-card", attribute "aria-label" strings.freeWaterDeficit ]
        [ h2 [ class "card-title" ] [ text strings.freeWaterDeficit ]
        , div [ class "form" ]
            [ fieldGroup strings.weight "weight" "0.0" model.weight UpdateWeight
            , fieldGroup strings.sodium "sodium" "0.0" model.sodium UpdateSodium
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
