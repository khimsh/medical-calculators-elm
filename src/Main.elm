port module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Calculators.BodySurfaceArea as BodySurfaceArea
import Calculators.FreeWaterDeficit as FreeWaterDeficit
import Calculators.IvInfusionRate as IvInfusionRate
import Calculators.Liquids as Liquids
import Calculators.Nutrition as Nutrition
import Calculators.Pills as Pills
import Categories exposing (Category(..))
import Favorites exposing (Calculator)
import Html exposing (Html, a, button, div, h2, header, li, main_, nav, p, section, text, ul)
import Html.Attributes exposing (attribute, class, href, id, type_)
import Html.Events exposing (onClick)
import Json.Decode as Decode
import Json.Encode as Encode
import Translations exposing (Language(..), Strings, getStrings)
import Url exposing (Url)


port setLangAttribute : String -> Cmd msg


port saveFavorites : Encode.Value -> Cmd msg


main : Program Decode.Value Model Msg
main =
    Browser.application
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        , onUrlRequest = LinkClicked
        , onUrlChange = UrlChanged
        }


type Page
    = AllPage
    | FavoritesPage


pageFromUrl : Url -> Page
pageFromUrl url =
    if url.fragment == Just "favorites" then
        FavoritesPage

    else
        AllPage


type alias Model =
    { key : Nav.Key
    , page : Page
    , favorites : List Calculator
    , language : Language
    , pills : Pills.Model
    , liquids : Liquids.Model
    , nutrition : Nutrition.Model
    , freeWaterDeficit : FreeWaterDeficit.Model
    , ivInfusionRate : IvInfusionRate.Model
    , bodySurfaceArea : BodySurfaceArea.Model
    }


init : Decode.Value -> Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    ( { key = key
      , page = pageFromUrl url
      , favorites = Favorites.decode flags
      , language = Georgian
      , pills = Pills.init
      , liquids = Liquids.init
      , nutrition = Nutrition.init
      , freeWaterDeficit = FreeWaterDeficit.init
      , ivInfusionRate = IvInfusionRate.init
      , bodySurfaceArea = BodySurfaceArea.init
      }
    , Cmd.none
    )


type Msg
    = ToggleLanguage
    | LinkClicked Browser.UrlRequest
    | UrlChanged Url
    | ToggleFavorite Calculator
    | PillsMsg Pills.Msg
    | LiquidsMsg Liquids.Msg
    | NutritionMsg Nutrition.Msg
    | HandleFreeWaterDeficitMsg FreeWaterDeficit.Msg
    | IvInfusionRateMsg IvInfusionRate.Msg
    | BodySurfaceAreaMsg BodySurfaceArea.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
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

        LinkClicked (Browser.Internal url) ->
            ( model, Nav.pushUrl model.key (Url.toString url) )

        LinkClicked (Browser.External url) ->
            ( model, Nav.load url )

        UrlChanged url ->
            ( { model | page = pageFromUrl url }, Cmd.none )

        ToggleFavorite calculator ->
            let
                favorites =
                    Favorites.toggle calculator model.favorites
            in
            ( { model | favorites = favorites }
            , saveFavorites (Favorites.encode favorites)
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

        IvInfusionRateMsg subMsg ->
            let
                strings =
                    getStrings model.language
            in
            ( { model | ivInfusionRate = IvInfusionRate.update subMsg model.ivInfusionRate strings }
            , Cmd.none
            )

        BodySurfaceAreaMsg subMsg ->
            let
                strings =
                    getStrings model.language
            in
            ( { model | bodySurfaceArea = BodySurfaceArea.update subMsg model.bodySurfaceArea strings }
            , Cmd.none
            )


view : Model -> Browser.Document Msg
view model =
    let
        strings =
            getStrings model.language

        visibleCalculators =
            case model.page of
                AllPage ->
                    Favorites.all

                FavoritesPage ->
                    List.filter (\calculator -> List.member calculator model.favorites) Favorites.all
    in
    { title = strings.title
    , body =
        [ header [ class "topbar" ]
            [ nav [ class "page-nav" ]
                [ ul []
                    [ navLink (model.page == AllPage) "#" strings.allCalculators
                    , navLink (model.page == FavoritesPage) "#favorites" strings.favorites
                    ]
                ]
            , button
                [ class "lang-toggle"
                , type_ "button"
                , onClick ToggleLanguage
                , attribute "aria-label" strings.switchLanguage
                , attribute "lang"
                    (if model.language == English then
                        "ka"

                     else
                        "en"
                    )
                ]
                [ text strings.otherLanguage ]
            ]
        , main_ []
            [ p [ class "testing-banner" ] [ text strings.testingBanner ]
            , if List.isEmpty visibleCalculators then
                p [ class "empty-state" ] [ text strings.noFavorites ]

              else
                div [ class "categories" ]
                    (List.filterMap (viewCategory strings model visibleCalculators) Categories.all)
            ]
        ]
    }


navLink : Bool -> String -> String -> Html Msg
navLink isCurrent url label =
    li []
        [ a
            (href url
                :: (if isCurrent then
                        [ attribute "aria-current" "page" ]

                    else
                        []
                   )
            )
            [ text label ]
        ]


{-| Nothing when none of the category's calculators are visible.
-}
viewCategory : Strings -> Model -> List Calculator -> Category -> Maybe (Html Msg)
viewCategory strings model visibleCalculators category =
    let
        headingId =
            categoryId category

        calculators =
            List.filter (\calculator -> List.member calculator visibleCalculators) (Categories.calculators category)
    in
    if List.isEmpty calculators then
        Nothing

    else
        Just
            (section [ class "category", attribute "aria-labelledby" headingId ]
                [ h2 [ id headingId ] [ text (Categories.title strings category) ]
                , div [ class "calculators" ]
                    (List.map (viewCalculator strings model) calculators)
                ]
            )


categoryId : Category -> String
categoryId category =
    case category of
        MedicationDosing ->
            "category-medication-dosing"

        FluidsAndElectrolytes ->
            "category-fluids-and-electrolytes"

        NutritionCategory ->
            "category-nutrition"


viewCalculator : Strings -> Model -> Calculator -> Html Msg
viewCalculator strings model calculator =
    let
        ( title, card ) =
            case calculator of
                Favorites.Pills ->
                    ( strings.pillDosage, Html.map PillsMsg (Pills.view strings model.pills) )

                Favorites.Liquids ->
                    ( strings.peroralliquid, Html.map LiquidsMsg (Liquids.view strings model.liquids) )

                Favorites.Nutrition ->
                    ( strings.nutrition, Html.map NutritionMsg (Nutrition.view strings model.nutrition) )

                Favorites.FreeWaterDeficit ->
                    ( strings.freeWaterDeficit, Html.map HandleFreeWaterDeficitMsg (FreeWaterDeficit.view strings model.freeWaterDeficit) )

                Favorites.IvInfusionRate ->
                    ( strings.ivInfusionRate, Html.map IvInfusionRateMsg (IvInfusionRate.view strings model.ivInfusionRate) )

                Favorites.BodySurfaceArea ->
                    ( strings.bodySurfaceArea, Html.map BodySurfaceAreaMsg (BodySurfaceArea.view strings model.bodySurfaceArea) )

        isFavorite =
            List.member calculator model.favorites
    in
    div [ class "card-slot" ]
        [ button
            [ class "favorite-toggle"
            , type_ "button"
            , onClick (ToggleFavorite calculator)
            , attribute "aria-pressed"
                (if isFavorite then
                    "true"

                 else
                    "false"
                )
            , attribute "aria-label" (strings.markFavorite title)
            ]
            [ text
                (if isFavorite then
                    "★"

                 else
                    "☆"
                )
            ]
        , card
        ]
