port module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Calculators.Pills as Pills
import Calculators.Liquids as Liquids
import Calculators.Nutrition as Nutrition
import Calculators.FreeWaterDeficit as FreeWaterDeficit
import Translations exposing (Language(..), getStrings)
import Html exposing (button, div, h1, h2, header, main_, p, text)
import Html.Attributes exposing (attribute, class, type_)
import Html.Events exposing (onClick)
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
                updatedFreeWaterDeficit = FreeWaterDeficit.update subMsg model.freeWaterDeficit
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


view : Model -> Browser.Document Msg
view model =
    let
        strings =
            getStrings model.language
    in
    { title = strings.title
    , body =
        [ div [ class "page-wrapper" ]
            [ div [ class "sidebar-nav" ]
                [ button
                    [ class "sidebar-nav-item"
                    , type_ "button"
                    , onClick ToggleLanguage
                    , attribute "aria-label" (if model.language == English then "Switch to Georgian" else "Switch to English")
                    , attribute "title" (if model.language == English then "ქართული" else "English")
                    ]
                    [ text (if model.language == English then "🇬🇪" else "🇬🇧") ]
                , button
                    [ class ("sidebar-nav-item" ++ if model.currentView == CalculatorView PillsCalc then " active" else "")
                    , type_ "button"
                    , onClick (SelectCalculator PillsCalc)
                    , attribute "aria-label" "Pills"
                    , attribute "title" strings.pillDosage
                    ]
                    [ text "💊" ]
                , button
                    [ class ("sidebar-nav-item" ++ if model.currentView == CalculatorView LiquidsCalc then " active" else "")
                    , type_ "button"
                    , onClick (SelectCalculator LiquidsCalc)
                    , attribute "aria-label" "Liquids"
                    , attribute "title" strings.liquidDosage
                    ]
                    [ text "🧪" ]
                , button
                    [ class ("sidebar-nav-item" ++ if model.currentView == CalculatorView NutritionCalc then " active" else "")
                    , type_ "button"
                    , onClick (SelectCalculator NutritionCalc)
                    , attribute "aria-label" "Nutrition"
                    , attribute "title" strings.nutrition
                    ]
                    [ text "🥗" ]
                , button
                    [ class ("sidebar-nav-item" ++ if model.currentView == CalculatorView FreeWaterDeficitMsg then " active" else "")
                    , type_ "button"
                    , onClick (SelectCalculator FreeWaterDeficitMsg)
                    , attribute "aria-label" "Free Water Deficit"
                    , attribute "title" strings.freeWaterDeficit
                    ]
                    [ text "💧" ]
                ]
            , div [ class "main-wrapper" ]
                [ div [ class "disclaimer-banner" ] [ text strings.disclaimer ]
                , header [ class "header", attribute "aria-label" "Site header" ]
                    [ div [ class "header-left" ]
                        [ h1 [ class "title" ] [ text strings.title ]
                        ]
                    ]
                , main_ [ class "main-content" ]
                    [ case model.currentView of
                        IndexView ->
                            viewIndex strings

                        CalculatorView calculator ->
                            viewCalculator model calculator strings
                    ]
                ]
            ]
        ]
    }


viewIndex : Translations.Strings -> Html.Html Msg
viewIndex strings =
    div [ class "index-container" ]
        [ div [ class "calculators-grid" ]
            [ calculatorCard PillsCalc strings.pillDosage strings.pillDescription "#ee5a52"
            , calculatorCard LiquidsCalc strings.liquidDosage strings.liquidDescription "#3498db"
            , calculatorCard NutritionCalc strings.nutrition strings.nutritionDescription "#2ecc71"
            , calculatorCard FreeWaterDeficitMsg strings.freeWaterDeficit strings.freeWaterDeficitDescription "#f39c12"
            ]
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
    case calculator of
        FreeWaterDeficitMsg ->
            Html.map HandleFreeWaterDeficitMsg (FreeWaterDeficit.view strings model.freeWaterDeficit)

        _ ->
            div [ class "calculator-wrapper" ]
                [ button
                    [ class "back-button"
                    , type_ "button"
                    , onClick GoToIndex
                    , attribute "aria-label" "Back to index"
                    ]
                    [ text "← Back" ]
                , if calculator == PillsCalc then
                    Html.map PillsMsg (Pills.view model.language strings model.pills)

                  else if calculator == LiquidsCalc then
                    Html.map LiquidsMsg (Liquids.view model.language strings model.liquids)

                  else
                    Html.map NutritionMsg (Nutrition.view model.language strings model.nutrition)
                ]
