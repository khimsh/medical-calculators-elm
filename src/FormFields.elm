module FormFields exposing (checkboxField, numberField, radioButtonField, selectField, textField)

import Html exposing (Html, div, input, label, option, select, text)
import Html.Attributes exposing (attribute, checked, class, for, id, name, placeholder, type_, value)
import Html.Events exposing (onCheck, onInput)


{-| Number input field with label
-}
numberField : String -> String -> String -> String -> (String -> msg) -> Html msg
numberField labelText inputId placeholderText valueText onInputMsg =
    div [ class "field-group" ]
        [ label [ class "label", for inputId ] [ text labelText ]
        , input
            [ class "input"
            , id inputId
            , type_ "number"
            , placeholder placeholderText
            , value valueText
            , onInput onInputMsg
            , attribute "min" "0"
            , attribute "autocomplete" "off"
            ]
            []
        ]


{-| Text input field with label
-}
textField : String -> String -> String -> String -> (String -> msg) -> Html msg
textField labelText inputId placeholderText valueText onInputMsg =
    div [ class "field-group" ]
        [ label [ class "label", for inputId ] [ text labelText ]
        , input
            [ class "input"
            , id inputId
            , type_ "text"
            , placeholder placeholderText
            , value valueText
            , onInput onInputMsg
            , attribute "autocomplete" "off"
            ]
            []
        ]


{-| Select option type
-}
type alias SelectOption =
    { value : String
    , label : String
    }


{-| Select dropdown field with label
-}
selectField : String -> String -> String -> List SelectOption -> (String -> msg) -> Html msg
selectField labelText selectId currentValue options onChangeMsg =
    div [ class "field-group" ]
        [ label [ class "label", for selectId ] [ text labelText ]
        , select
            [ class "input"
            , id selectId
            , onInput onChangeMsg
            , value currentValue
            ]
            (List.map
                (\opt ->
                    option [ value opt.value ] [ text opt.label ]
                )
                options
            )
        ]


{-| Checkbox field with label
-}
checkboxField : String -> String -> Bool -> (Bool -> msg) -> Html msg
checkboxField labelText checkboxId isChecked onChangeMsg =
    div [ class "field-group checkbox-group" ]
        [ input
            [ type_ "checkbox"
            , id checkboxId
            , checked isChecked
            , onCheck onChangeMsg
            , class "checkbox-input"
            ]
            []
        , label [ class "checkbox-label", for checkboxId ] [ text labelText ]
        ]


{-| Radio button field with label
-}
radioButtonField : String -> String -> String -> Bool -> (String -> msg) -> Html msg
radioButtonField groupName radioId labelText isChecked onChangeMsg =
    div [ class "field-group radio-group" ]
        [ input
            [ type_ "radio"
            , name groupName
            , id radioId
            , checked isChecked
            , onInput (\_ -> onChangeMsg radioId)
            , class "radio-input"
            ]
            []
        , label [ class "radio-label", for radioId ] [ text labelText ]
        ]
