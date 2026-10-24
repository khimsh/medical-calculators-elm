port module Main exposing (main)

import Browser
import Calculators.FreeWaterDeficit as FreeWaterDeficit
import Calculators.Liquids as Liquids
import Calculators.Nutrition as Nutrition
import Calculators.Pills as Pills
import Html exposing (button, main_, text)
import Html.Attributes exposing (attribute, type_)
import Html.Events exposing (onClick)
import Translations exposing (Language(..), getStrings)


port setLangAttribute : String -> Cmd msg


main : Program () Model Msg
main =
    Browser.document
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }


type alias Model =
    { language : Language
    , pills : Pills.Model
    , liquids : Liquids.Model
    , nutrition : Nutrition.Model
    , freeWaterDeficit : FreeWaterDeficit.Model
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { language = Georgian
      , pills = Pills.init
      , liquids = Liquids.init
      , nutrition = Nutrition.init
      , freeWaterDeficit = FreeWaterDeficit.init
      }
    , Cmd.none
    )


type Msg
    = ToggleLanguage
    | PillsMsg Pills.Msg
    | LiquidsMsg Liquids.Msg
    | NutritionMsg Nutrition.Msg
    | HandleFreeWaterDeficitMsg FreeWaterDeficit.Msg


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


view : Model -> Browser.Document Msg
view model =
    let
        strings =
            getStrings model.language
    in
    { title = strings.title
    , body =
        [ main_ []
            [ button
                [ type_ "button"
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
            , Html.map PillsMsg (Pills.view strings model.pills)
            , Html.map LiquidsMsg (Liquids.view strings model.liquids)
            , Html.map NutritionMsg (Nutrition.view strings model.nutrition)
            , Html.map HandleFreeWaterDeficitMsg (FreeWaterDeficit.view strings model.freeWaterDeficit)
            ]
        ]
    }
