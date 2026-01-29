module Calculators.Pills exposing (Model, Msg(..), init, update, view)

import Functions exposing (calculateButton, errorDisplay, fieldGroup, floatToStr, resultDisplay, roundToTwoDecimals, strToFloat)
import Html exposing (div, form, h2, text)
import Html.Attributes exposing (attribute, class)
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
            { model | prescribed = newPrescribed, calculated = False, error = Nothing }

        ChangeTabletMg newTablet ->
            { model | tabletMg = newTablet, calculated = False, error = Nothing }

        Calculate ->
            if String.isEmpty model.prescribed || String.isEmpty model.tabletMg then
                { model | error = Just strings.invalidInputs, result = "0.0", calculated = True }

            else
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
    div [ class "calculator-card", attribute "aria-label" strings.pillDosage ]
        [ h2 [ class "card-title" ] [ text strings.pillDosage ]
        , form [ class "form" ]
            [ fieldGroup strings.prescribedAmount "pills-prescribed-amount" "0.0" model.prescribed ChangePrescribed
            , fieldGroup strings.pillStrength "pills-tablet-mg" "0.0" model.tabletMg ChangeTabletMg
            , div [ class "button-container" ]
                [ calculateButton strings.calculate ("Calculate " ++ strings.pillDosage) Calculate ]
            , case model.error of
                Just error ->
                    errorDisplay error

                Nothing ->
                    if model.calculated && not (String.isEmpty model.prescribed || String.isEmpty model.tabletMg) then
                        resultDisplay strings.result model.result strings.tablets

                    else
                        text ""
            ]
        ]
