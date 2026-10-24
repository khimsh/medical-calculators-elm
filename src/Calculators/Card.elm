module Calculators.Card exposing (view)

import Html exposing (Html, article, div, form, h3, header, p, text)
import Html.Attributes exposing (attribute, autocomplete, class, type_)
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
    article [ class "card", attribute "aria-label" config.title ]
        [ header []
            [ h3 [] [ text config.title ]
            , p [ class "card-formula" ] [ text config.formula ]
            ]
        , form
            [ autocomplete False
            , attribute "data-form" "calculator"
            , attribute "data-lpignore" "true"
            ]
            (fields
                ++ [ div [ class "actions" ]
                        [ Html.button
                            [ class "button-primary"
                            , type_ "button"
                            , attribute "aria-label" config.calculateLabel
                            , Html.Events.onClick buttons.calculateMsg
                            ]
                            [ text buttons.calculateText ]
                        , Html.button
                            [ class "button-secondary"
                            , type_ "reset"
                            , attribute "aria-label" config.resetLabel
                            , Html.Events.onClick buttons.resetMsg
                            ]
                            [ text buttons.resetText ]
                        ]
                   ]
            )
        , div [ attribute "aria-live" "polite" ] [ resultContent ]
        ]
