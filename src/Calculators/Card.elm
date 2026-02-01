module Calculators.Card exposing (view)

import Html exposing (Html, div, form, h2, text)
import Html.Attributes exposing (attribute, autocomplete, class, type_)
import Html.Events


type alias Config =
    { title : String
    , ariaLabel : String
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
    div [ class "calculator-card", attribute "aria-label" config.ariaLabel ]
        [ h2 [ class "card-title" ] [ text config.title ]
        , div [ class "calculator-content" ]
            [ form
                [ class "form"
                , autocomplete False
                , attribute "data-form" "calculator"
                , attribute "data-lpignore" "true"
                ]
                (fields
                    ++ [ div [ class "flex flex-gap-sm" ]
                            [ Html.button
                                [ class "button-primary"
                                , type_ "button"
                                , attribute "aria-label" config.calculateLabel
                                , Html.Events.onClick buttons.calculateMsg
                                ]
                                [ text buttons.calculateText ]
                            , Html.button
                                [ class "button-secondary-outline"
                                , type_ "reset"
                                , attribute "aria-label" config.resetLabel
                                , Html.Events.onClick buttons.resetMsg
                                ]
                                [ text buttons.resetText ]
                            ]
                       ]
                )
            , resultContent
            ]
        ]
