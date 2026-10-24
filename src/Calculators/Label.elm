module Calculators.Label exposing (Reading, empty, notice, view)

import Html exposing (Html, div, p, span, text)
import Html.Attributes exposing (attribute, class)


{-| A calculated result, printed like a dispensing label: what to do, the
number and its unit, and the working with the user's own numbers.
-}
type alias Reading msg =
    { title : String
    , value : String
    , unit : String
    , extra : List (Html msg)
    , working : List String
    }


view : String -> Reading msg -> Html msg
view ariaLabel reading =
    div [ class "result", attribute "role" "region", attribute "aria-label" ariaLabel ]
        ([ p [ class "result-title" ] [ text reading.title ]
         , p []
            [ span [ class "result-value" ] [ text reading.value ]
            , text " "
            , span [ class "result-unit" ] [ text reading.unit ]
            ]
         ]
            ++ reading.extra
            ++ [ div [ class "result-working" ] (List.map (\line -> p [] [ text line ]) reading.working) ]
        )


{-| Placeholder shown before anything has been calculated.
-}
empty : String -> Html msg
empty hint =
    div [ class "result-empty" ] [ p [] [ text hint ] ]


{-| A clinical message that is not an input error, such as "no deficit".
-}
notice : String -> Html msg
notice message =
    div [ class "notice", attribute "role" "status" ] [ p [] [ text message ] ]
