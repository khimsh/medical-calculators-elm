module Calculators.Label exposing (Reading, empty, notice, view)

import Html exposing (Html, div, p, span, text)
import Html.Attributes exposing (attribute)


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
    div [ attribute "role" "region", attribute "aria-label" ariaLabel ]
        ([ p [] [ text reading.title ]
         , p []
            [ span [] [ text reading.value ]
            , text " "
            , span [] [ text reading.unit ]
            ]
         ]
            ++ reading.extra
            ++ [ div [] (List.map (\line -> p [] [ text line ]) reading.working) ]
        )


{-| Placeholder shown before anything has been calculated.
-}
empty : String -> Html msg
empty hint =
    div [] [ p [] [ text hint ] ]


{-| A clinical message that is not an input error, such as "no deficit".
-}
notice : String -> Html msg
notice message =
    div [ attribute "role" "status" ] [ p [] [ text message ] ]
