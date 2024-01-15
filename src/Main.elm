module Main exposing (main, update)

import Browser
import Functions exposing (..)
import Html exposing (button, div, form, h1, input, label, p, text)
import Html.Attributes exposing (placeholder, value)
import Html.Events exposing (onClick, onInput)


main : Program () Model Msg
main =
    Browser.sandbox { init = init, update = update, view = view }


type alias Model =
    { prescribed : String
    , tabletMg : String
    , result : String
    }


init : Model
init =
    { prescribed = ""
    , tabletMg = ""
    , result = "0.0"
    }


type Msg
    = ChangePrescribed String
    | ChangeTabletMg String
    | CalculateResult


update msg model =
    case msg of
        ChangePrescribed newPrescribed ->
            { model | prescribed = newPrescribed }

        ChangeTabletMg newTablet ->
            { model | tabletMg = newTablet }

        CalculateResult ->
            { model | result = floatToStr (strToFloat model.prescribed / strToFloat model.tabletMg) }


view model =
    div []
        [ h1 [] [ text "Medical Calculators implemented in Elm" ]
        , form []
            [ label [] [ text "Prescribed amount" ]
            , input [ placeholder "0.0", value model.prescribed, onInput ChangePrescribed ] []
            ]
        , div []
            [ label [] [ text "Pill Mg" ]
            , input [ placeholder "0.0", value model.tabletMg, onInput ChangeTabletMg ] []
            ]
        , div []
            [ button [ onClick CalculateResult ] [ text "Calculate" ]
            ]
        , div []
            [ p [] [ text "Result:" ]
            , p [] [ text model.result ]
            ]
        ]
