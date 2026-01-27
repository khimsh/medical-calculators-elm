module Main exposing (main, update, Model, Msg(..), init)

import Browser
import Calculators.Pills as Pills
import Calculators.Liquids as Liquids
import Calculators.Nutrition as Nutrition
import Translations exposing (Language(..), getStrings)
import Html exposing (button, div, h1, header, main_, nav, text)
import Html.Attributes exposing (attribute, class, type_)
import Html.Events exposing (onClick)


main : Program () Model Msg
main =
    Browser.sandbox { init = init, update = update, view = view }


type Calculator
    = PillsCalc
    | LiquidsCalc
    | NutritionCalc


type alias Model =
    { selectedCalculator : Calculator
    , language : Language
    , pills : Pills.Model
    , liquids : Liquids.Model
    , nutrition : Nutrition.Model
    , sidebarOpen : Bool
    }


init : Model
init =
    { selectedCalculator = PillsCalc
    , language = Georgian
    , pills = Pills.init
    , liquids = Liquids.init
    , nutrition = Nutrition.init
    , sidebarOpen = False
    }


type Msg
    = SelectCalculator Calculator
    | ToggleSidebar
    | ToggleLanguage
    | PillsMsg Pills.Msg
    | LiquidsMsg Liquids.Msg
    | NutritionMsg Nutrition.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        SelectCalculator calculator ->
            { model | selectedCalculator = calculator, sidebarOpen = False }

        ToggleLanguage ->
            { model | language = if model.language == English then Georgian else English }

        ToggleSidebar ->
            { model | sidebarOpen = not model.sidebarOpen }

        PillsMsg subMsg ->
            let
                strings =
                    getStrings model.language
            in
            { model | pills = Pills.update subMsg model.pills strings }

        LiquidsMsg subMsg ->
            let
                strings =
                    getStrings model.language
            in
            { model | liquids = Liquids.update subMsg model.liquids strings }

        NutritionMsg subMsg ->
            let
                strings =
                    getStrings model.language
            in
            { model | nutrition = Nutrition.update subMsg model.nutrition strings }


view : Model -> Html.Html Msg
view model =
    let
        strings =
            getStrings model.language
    in
    div [ class "page-wrapper" ]
        [ div [ class "disclaimer-banner" ] [ text strings.disclaimer ]
        , header [ class "header", attribute "aria-label" "Site header" ]
            [ div [ class "header-left" ]
                [ h1 [ class "title" ] [ text strings.title ]
                , div [ class "subtitle" ] [ text strings.subtitle ]
                ]
            , div [ class "header-right" ]
                [ button
                    [ class "menu-toggle"
                    , type_ "button"
                    , onClick ToggleSidebar
                    , attribute "aria-label" (if model.sidebarOpen then "Close menu" else "Open menu")
                    ]
                    [ text (if model.sidebarOpen then "✕" else "☰") ]
                , button
                    [ class "language-button"
                    , type_ "button"
                    , onClick ToggleLanguage
                    , attribute "aria-label" (if model.language == English then "Switch to Georgian" else "Switch to English")
                    , attribute "title" (if model.language == English then "ქართული" else "English")
                    ]
                    [ text (if model.language == English then "ქართული" else "English") ]
                ]
            ]
        , div [ class "main-wrapper" ]
            [ nav [ class "sidebar", classList [ ( "open", model.sidebarOpen ) ], attribute "aria-label" "Calculator selection" ]
                [ button
                    [ class "sidebar-button"
                    , classList [ ( "active", model.selectedCalculator == PillsCalc ) ]
                    , type_ "button"
                    , onClick (SelectCalculator PillsCalc)
                    , attribute "aria-current" (if model.selectedCalculator == PillsCalc then "page" else "false")
                    ]
                    [ text strings.pillDosage ]
                , button
                    [ class "sidebar-button"
                    , classList [ ( "active", model.selectedCalculator == LiquidsCalc ) ]
                    , type_ "button"
                    , onClick (SelectCalculator LiquidsCalc)
                    , attribute "aria-current" (if model.selectedCalculator == LiquidsCalc then "page" else "false")
                    ]
                    [ text strings.liquidDosage ]
                , button
                    [ class "sidebar-button"
                    , classList [ ( "active", model.selectedCalculator == NutritionCalc ) ]
                    , type_ "button"
                    , onClick (SelectCalculator NutritionCalc)
                    , attribute "aria-current" (if model.selectedCalculator == NutritionCalc then "page" else "false")
                    ]
                    [ text strings.nutrition ]
                ]
            , main_ [ class "content-area" ]
                [ if model.selectedCalculator == PillsCalc then
                    Html.map PillsMsg (Pills.view model.language strings model.pills)

                  else if model.selectedCalculator == LiquidsCalc then
                    Html.map LiquidsMsg (Liquids.view model.language strings model.liquids)

                  else
                    Html.map NutritionMsg (Nutrition.view model.language strings model.nutrition)
                ]
            ]
        ]


classList : List ( String, Bool ) -> Html.Attribute Msg
classList classes =
    class (String.join " " (List.map Tuple.first (List.filter Tuple.second classes)))
