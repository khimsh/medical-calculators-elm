module Calculators.InputError exposing (InputError(..), text, view)

import Html exposing (Html, div, p)
import Html.Attributes exposing (attribute, class)
import Translations exposing (Strings)


{-| Which input problem stopped a calculation. The model stores this, not the
translated message, so the message follows the current language.
-}
type InputError
    = InvalidInputs
    | NotPositive


text : Strings -> InputError -> String
text strings error =
    case error of
        InvalidInputs ->
            strings.invalidInputs

        NotPositive ->
            strings.zeroNotAccepted


view : Strings -> InputError -> Html msg
view strings error =
    div [ class "error", attribute "role" "alert" ]
        [ p [] [ Html.text (text strings error) ]
        ]
