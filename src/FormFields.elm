module FormFields exposing (checkboxField, numberField, optionButtonsField)

import Html exposing (Html, div, fieldset, input, label, legend, text)
import Html.Attributes exposing (attribute, checked, class, for, id, name, type_, value)
import Html.Events exposing (onCheck, onInput)


{-| Number input field with label
-}
numberField : String -> String -> String -> (String -> msg) -> Html msg
numberField labelText inputId valueText onInputMsg =
    div [ class "field" ]
        [ label [ for inputId ] [ text labelText ]
        , input
            [ id inputId
            , type_ "number"
            , value valueText
            , onInput onInputMsg
            , attribute "min" "0"
            , attribute "autocomplete" "off"
            ]
            []
        ]


{-| Option in a single-choice field
-}
type alias SelectOption =
    { value : String
    , label : String
    }


{-| Single-choice field shown as a group of option buttons
-}
optionButtonsField : String -> String -> String -> List SelectOption -> (String -> msg) -> Html msg
optionButtonsField labelText groupId currentValue options onChangeMsg =
    fieldset [ class "field-options" ]
        [ legend [] [ text labelText ]
        , div [ class "field-options-list" ]
            (List.map
                (\opt ->
                    let
                        optionId =
                            groupId ++ "-" ++ opt.value
                    in
                    div [ class "field-option" ]
                        [ input
                            [ type_ "radio"
                            , name groupId
                            , id optionId
                            , value opt.value
                            , checked (opt.value == currentValue)
                            , onCheck (\_ -> onChangeMsg opt.value)
                            ]
                            []
                        , label [ for optionId ] [ text opt.label ]
                        ]
                )
                options
            )
        ]


{-| Checkbox field with label
-}
checkboxField : String -> String -> Bool -> (Bool -> msg) -> Html msg
checkboxField labelText checkboxId isChecked onChangeMsg =
    div [ class "field-check" ]
        [ input
            [ type_ "checkbox"
            , id checkboxId
            , checked isChecked
            , onCheck onChangeMsg
            ]
            []
        , label [ for checkboxId ] [ text labelText ]
        ]
