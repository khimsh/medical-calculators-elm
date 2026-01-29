module Calculators.Pills exposing (Model, Msg(..), init, update, view)

import Functions exposing (..)
import Html exposing (button, div, form, h2, p, text)
import Html.Attributes exposing (attribute, class, type_)
import Html.Events exposing (onClick)
import Translations exposing (Strings)


type alias Model =
    { prescribed : String
    , tabletMg : String
    , result : String
    , error : Maybe String
    , calculated : Bool
    }


init : Model
init =
    { prescribed = ""
    , tabletMg = ""
    , result = "0.0"
    , error = Nothing
    , calculated = False
    }


type Msg
    = ChangePrescribed String
    | ChangeTabletMg String
    | Calculate


update : Msg -> Model -> Strings -> Model
update msg model strings =
    case msg of
        ChangePrescribed newPrescribed ->
            { model | prescribed = newPrescribed }

        ChangeTabletMg newTablet ->
            { model | tabletMg = newTablet }

        Calculate ->
            let
                prescribed =
                    strToFloat model.prescribed

                tablet =
                    strToFloat model.tabletMg
            in
            if prescribed == 0 || tablet == 0 then
                { model | error = Just strings.zeroNotAccepted, result = "0.0", calculated = True }

            else
                { model | result = floatToStr (roundToTwoDecimals (prescribed / tablet)), error = Nothing, calculated = True }


view : Strings -> Model -> Html.Html Msg
view strings model =
    div [ class "calculator-card", attribute "aria-label" strings.peroralpill ]
        [ h2 [ class "card-title" ] [ text strings.peroralpill ]
        , form [ class "form" ]
            [ fieldGroup strings.prescribedAmount "prescribed-amount" "0.0" model.prescribed ChangePrescribed
            , fieldGroup strings.pillStrength "pill-strength" "0.0" model.tabletMg ChangeTabletMg
            , div [ class "button-container" ]
                [ button [ class "button", type_ "button", onClick Calculate, attribute "aria-label" ("Calculate " ++ strings.pillDosage) ] [ text strings.calculate ]
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
                            , p [ class "result-unit" ] [ text strings.tablets ]
                            ]

                    else
                        text ""
            ]
        ]


roundToTwoDecimals : Float -> Float
roundToTwoDecimals number =
    toFloat (round (number * 100)) / 100
