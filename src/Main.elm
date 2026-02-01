port module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Calculators.FreeWaterDeficit as FreeWaterDeficit
import Calculators.Liquids as Liquids
import Calculators.Nutrition as Nutrition
import Calculators.Pills as Pills
import Html exposing (a, button, div, h1, h2, header, main_, p, span, text)
import Html.Attributes exposing (attribute, class, href, type_)
import Html.Events exposing (onClick)
import Translations exposing (Language(..), getStrings)
import Url
import Url.Parser exposing (..)


port setLangAttribute : String -> Cmd msg


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }


type Calculator
    = PillsCalc
    | LiquidsCalc
    | NutritionCalc
    | FreeWaterDeficitMsg


type View
    = IndexView
    | CalculatorView Calculator


type alias Model =
    { currentView : View
    , language : Language
    , pills : Pills.Model
    , liquids : Liquids.Model
    , nutrition : Nutrition.Model
    , freeWaterDeficit : FreeWaterDeficit.Model
    , sidebarOpen : Bool
    , navKey : Nav.Key
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url navKey =
    let
        initialView =
            parseUrl url
    in
    ( { currentView = initialView
      , language = Georgian
      , pills = Pills.init
      , liquids = Liquids.init
      , nutrition = Nutrition.init
      , freeWaterDeficit = FreeWaterDeficit.init
      , sidebarOpen = False
      , navKey = navKey
      }
    , Cmd.none
    )


type Msg
    = SelectCalculator Calculator
    | GoToIndex
    | ToggleSidebar
    | ToggleLanguage
    | PillsMsg Pills.Msg
    | LiquidsMsg Liquids.Msg
    | NutritionMsg Nutrition.Msg
    | HandleFreeWaterDeficitMsg FreeWaterDeficit.Msg
    | LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url


parseUrl : Url.Url -> View
parseUrl url =
    case url.fragment of
        Just "pills" ->
            CalculatorView PillsCalc

        Just "liquids" ->
            CalculatorView LiquidsCalc

        Just "nutrition" ->
            CalculatorView NutritionCalc

        Just "free-water-deficit" ->
            CalculatorView FreeWaterDeficitMsg

        _ ->
            IndexView


calculatorToFragment : Calculator -> String
calculatorToFragment calc =
    case calc of
        PillsCalc ->
            "pills"

        LiquidsCalc ->
            "liquids"

        NutritionCalc ->
            "nutrition"

        FreeWaterDeficitMsg ->
            "free-water-deficit"


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SelectCalculator calculator ->
            ( { model | currentView = CalculatorView calculator, sidebarOpen = False }
            , Nav.pushUrl model.navKey ("#" ++ calculatorToFragment calculator)
            )

        GoToIndex ->
            ( { model | currentView = IndexView, sidebarOpen = False }
            , Nav.pushUrl model.navKey "./"
            )

        ToggleLanguage ->
            let
                newLanguage =
                    if model.language == English then
                        Georgian

                    else
                        English

                langAttribute =
                    case newLanguage of
                        English ->
                            "en"

                        Georgian ->
                            "ka"
            in
            ( { model | language = newLanguage }
            , setLangAttribute langAttribute
            )

        ToggleSidebar ->
            ( { model | sidebarOpen = not model.sidebarOpen }
            , Cmd.none
            )

        PillsMsg subMsg ->
            let
                strings =
                    getStrings model.language
            in
            ( { model | pills = Pills.update subMsg model.pills strings }
            , Cmd.none
            )

        LiquidsMsg subMsg ->
            let
                strings =
                    getStrings model.language
            in
            ( { model | liquids = Liquids.update subMsg model.liquids strings }
            , Cmd.none
            )

        NutritionMsg subMsg ->
            let
                strings =
                    getStrings model.language
            in
            ( { model | nutrition = Nutrition.update subMsg model.nutrition strings }
            , Cmd.none
            )

        HandleFreeWaterDeficitMsg subMsg ->
            let
                strings =
                    getStrings model.language

                updatedFreeWaterDeficit =
                    FreeWaterDeficit.update subMsg model.freeWaterDeficit strings
            in
            ( { model | freeWaterDeficit = updatedFreeWaterDeficit }, Cmd.none )

        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.navKey (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            ( { model | currentView = parseUrl url }
            , Cmd.none
            )


navItem : View -> Calculator -> String -> String -> Html.Html Msg
navItem currentView calculator icon label =
    let
        isActive =
            currentView == CalculatorView calculator

        activeClass =
            if isActive then
                " active"

            else
                ""

        urlFragment =
            "#" ++ calculatorToFragment calculator
    in
    a
        [ class ("sidebar-nav-item" ++ activeClass)
        , href urlFragment
        , onClick (SelectCalculator calculator)
        , attribute "aria-label" label
        , attribute "aria-current"
            (if isActive then
                "page"

             else
                "false"
            )
        ]
        [ span [ class "sidebar-nav-item-icon" ] [ text icon ]
        , span [ class "sidebar-nav-item-text" ] [ text label ]
        ]


view : Model -> Browser.Document Msg
view model =
    let
        strings =
            getStrings model.language

        sidebarClass =
            if model.sidebarOpen then
                "sidebar-nav open"

            else
                "sidebar-nav"
    in
    { title = strings.title
    , body =
        [ div [ class "page-wrapper" ]
            [ button
                [ class "sidebar-toggle-button"
                , type_ "button"
                , onClick ToggleSidebar
                , attribute "aria-label" "Toggle menu"
                ]
                [ text "☰" ]
            , div [ class sidebarClass ]
                [ button
                    [ class "sidebar-nav-item"
                    , type_ "button"
                    , onClick ToggleLanguage
                    , attribute "aria-label"
                        (if model.language == English then
                            "Switch to Georgian"

                         else
                            "Switch to English"
                        )
                    , attribute "title"
                        (if model.language == English then
                            "ქართული"

                         else
                            "English"
                        )
                    ]
                    [ text
                        (if model.language == English then
                            "🇬🇪"

                         else
                            "🇬🇧"
                        )
                    ]
                , navItem model.currentView PillsCalc "💊" strings.pillDosage
                , navItem model.currentView LiquidsCalc "🧪" strings.liquidDosage
                , navItem model.currentView NutritionCalc "🥗" strings.nutrition
                , navItem model.currentView FreeWaterDeficitMsg "💧" strings.freeWaterDeficit
                ]
            , div [ class "content-wrapper" ]
                [ header [ class "header", attribute "aria-label" "Site header" ]
                    [ div [ class "container padding-block-md" ]
                        [ h1 [ class "title" ] [ text strings.title ]
                        ]
                    ]
                , div [ class "container" ]
                    [ p [ class "disclaimer-banner padding-block-md" ] [ text strings.disclaimer ]
                    ]
                , main_ [ class "main-content" ]
                    [ div [ class "container" ]
                        [ case model.currentView of
                            IndexView ->
                                viewIndex strings

                            CalculatorView calculator ->
                                viewCalculator model calculator strings
                        ]
                    ]
                ]
            ]
        ]
    }


viewIndex : Translations.Strings -> Html.Html Msg
viewIndex strings =
    div [ class "calculators-grid" ]
        [ calculatorCard PillsCalc strings.pillDosage strings.pillDescription "#ee5a52"
        , calculatorCard LiquidsCalc strings.liquidDosage strings.liquidDescription "#3498db"
        , calculatorCard NutritionCalc strings.nutrition strings.nutritionDescription "#2ecc71"
        , calculatorCard FreeWaterDeficitMsg strings.freeWaterDeficit strings.freeWaterDeficitDescription "#f39c12"
        ]


calculatorCard : Calculator -> String -> String -> String -> Html.Html Msg
calculatorCard calculator title description color =
    button
        [ class "calculator-card-button"
        , onClick (SelectCalculator calculator)
        , attribute "style" ("--accent-color: " ++ color)
        ]
        [ div [ class "card-header" ]
            [ div [ class "card-blob" ] [] ]
        , div [ class "card-content" ]
            [ h2 [ class "card-title" ] [ text title ]
            , p [ class "card-description" ] [ text description ]
            ]
        ]


viewCalculator : Model -> Calculator -> Translations.Strings -> Html.Html Msg
viewCalculator model calculator strings =
    div [ class "calculator-wrapper" ]
        [ div [ class "flex flex-align-start" ]
            [ button
                [ class "button-tertiary-outline button-with-icon"
                , type_ "button"
                , onClick GoToIndex
                , attribute "aria-label" "Back to index"
                ]
                [ text "← Back" ]
            ]
        , if calculator == PillsCalc then
            Html.map PillsMsg (Pills.view strings model.pills)

          else if calculator == LiquidsCalc then
            Html.map LiquidsMsg (Liquids.view strings model.liquids)

          else if calculator == NutritionCalc then
            Html.map NutritionMsg (Nutrition.view strings model.nutrition)

          else
            Html.map HandleFreeWaterDeficitMsg (FreeWaterDeficit.view strings model.freeWaterDeficit)
        ]
