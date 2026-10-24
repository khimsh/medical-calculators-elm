module Calculators.Card exposing (view)

import Html exposing (Html, article, div, form, h2, header, p, text)
import Html.Attributes exposing (attribute, autocomplete, type_)
import Html.Events


type alias Config =
    { title : String
    , formula : String
    , calculateLabel : String
    , resetLabel : String
    }


type alias Buttons msg =
    { calculateMsg : msg
    , resetMsg : msg
    , calculateText : String
    , resetText : String
    }


view : Config -> List (Html msg) -> Buttons msg -> Html msg -> Html msg
view config fields buttons resultContent =
    article [ attribute "aria-label" config.title ]
        [ header []
            [ h2 [] [ text config.title ]
            , p [] [ text config.formula ]
            ]
        , form
            [ autocomplete False
            , attribute "data-form" "calculator"
            , attribute "data-lpignore" "true"
            ]
            (fields
                ++ [ div []
                        [ Html.button
                            [ type_ "button"
                            , attribute "aria-label" config.calculateLabel
                            , Html.Events.onClick buttons.calculateMsg
                            ]
                            [ text buttons.calculateText ]
                        , Html.button
                            [ type_ "reset"
                            , attribute "aria-label" config.resetLabel
                            , Html.Events.onClick buttons.resetMsg
                            ]
                            [ text buttons.resetText ]
                        ]
                   ]
            )
        , div [ attribute "aria-live" "polite" ] [ resultContent ]
        ]
