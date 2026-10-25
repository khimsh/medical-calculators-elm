module Calculators.IvInfusionRate exposing (DurationUnit(..), Model, Msg(..), Rates, init, update, view)

import Calculators.Card as Card
import Calculators.InputError as InputError exposing (InputError(..))
import Calculators.Label as Label
import FormFields exposing (numberField, optionButtonsField)
import Functions exposing (calculateDripRate, calculatePumpRate, floatToStr, formatToDecimals, strToFloat)
import Html exposing (Html, dd, div, dl, dt, text)
import Html.Attributes exposing (class)
import Translations exposing (Strings)



-- MODEL


type DurationUnit
    = Hours
    | Minutes


{-| Pump rate rounded to one decimal, drip rate rounded to whole drops.
-}
type alias Rates =
    { mlPerHour : Float
    , dropsPerMinute : Int
    }


type alias Model =
    { volume : String
    , duration : String
    , durationUnit : DurationUnit
    , dropFactor : Int
    , result : Maybe Rates
    , error : Maybe InputError
    }


init : Model
init =
    { volume = ""
    , duration = ""
    , durationUnit = Hours
    , dropFactor = 20
    , result = Nothing
    , error = Nothing
    }


dropFactors : List Int
dropFactors =
    [ 10, 15, 20, 60 ]



-- UPDATE


type Msg
    = UpdateVolume String
    | UpdateDuration String
    | UpdateDurationUnit DurationUnit
    | UpdateDropFactor Int
    | Calculate
    | Reset


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateVolume volume ->
            { model | volume = volume, result = Nothing, error = Nothing }

        UpdateDuration duration ->
            { model | duration = duration, result = Nothing, error = Nothing }

        UpdateDurationUnit durationUnit ->
            { model | durationUnit = durationUnit, result = Nothing, error = Nothing }

        UpdateDropFactor dropFactor ->
            { model | dropFactor = dropFactor, result = Nothing, error = Nothing }

        Calculate ->
            case ( strToFloat model.volume, strToFloat model.duration ) of
                ( Just volume, Just duration ) ->
                    if volume <= 0 || duration <= 0 then
                        { model | error = Just NotPositive, result = Nothing }

                    else
                        { model
                            | result =
                                Just
                                    { mlPerHour = roundToOneDecimal (calculatePumpRate volume (durationInHours model.durationUnit duration))
                                    , dropsPerMinute = round (calculateDripRate volume model.dropFactor (durationInMinutes model.durationUnit duration))
                                    }
                            , error = Nothing
                        }

                _ ->
                    { model | error = Just InvalidInputs, result = Nothing }

        Reset ->
            init


durationInHours : DurationUnit -> Float -> Float
durationInHours unit duration =
    case unit of
        Hours ->
            duration

        Minutes ->
            duration / 60


durationInMinutes : DurationUnit -> Float -> Float
durationInMinutes unit duration =
    case unit of
        Hours ->
            duration * 60

        Minutes ->
            duration


roundToOneDecimal : Float -> Float
roundToOneDecimal number =
    toFloat (round (number * 10)) / 10



-- VIEW


view : Strings -> Model -> Html Msg
view strings model =
    Card.view
        { title = strings.ivInfusionRate
        , formula = strings.ivInfusionFormula
        , calculateLabel = strings.calculate ++ ": " ++ strings.ivInfusionRate
        , resetLabel = strings.reset ++ ": " ++ strings.ivInfusionRate
        }
        [ numberField strings.infusionVolume "infusion-volume" model.volume UpdateVolume
        , div [ class "field-row" ]
            [ numberField strings.infusionDuration "infusion-duration" model.duration UpdateDuration
            , optionButtonsField strings.durationUnit
                "infusion-duration-unit"
                (durationUnitToValue model.durationUnit)
                [ { value = "hours", label = strings.hours }
                , { value = "minutes", label = strings.minutes }
                ]
                (\v -> UpdateDurationUnit (durationUnitFromValue v))
            ]
        , optionButtonsField strings.dropFactor
            "infusion-drop-factor"
            (String.fromInt model.dropFactor)
            (List.map
                (\factor -> { value = String.fromInt factor, label = String.fromInt factor ++ " " ++ strings.dropsPerMl })
                dropFactors
            )
            (\v -> UpdateDropFactor (String.toInt v |> Maybe.withDefault init.dropFactor))
        ]
        { calculateMsg = Calculate
        , resetMsg = Reset
        , calculateText = strings.calculate
        , resetText = strings.reset
        }
        (case ( model.error, model.result ) of
            ( Just error, _ ) ->
                InputError.view strings error

            ( Nothing, Just rates ) ->
                let
                    duration =
                        Maybe.withDefault 0 (strToFloat model.duration)
                in
                Label.view strings.calculationResult
                    { title = strings.pumpRate
                    , value = floatToStr rates.mlPerHour
                    , unit = strings.mlPerHour
                    , extra =
                        [ dl [ class "macros" ]
                            [ div []
                                [ dt [] [ text strings.dripRate ]
                                , dd [] [ text (String.fromInt rates.dropsPerMinute ++ " " ++ strings.dropsPerMinute) ]
                                ]
                            ]
                        ]
                    , working =
                        [ model.volume
                            ++ " "
                            ++ strings.ml
                            ++ " ÷ "
                            ++ formatToDecimals 2 (durationInHours model.durationUnit duration)
                            ++ " "
                            ++ strings.hoursShort
                        , model.volume
                            ++ " "
                            ++ strings.ml
                            ++ " × "
                            ++ String.fromInt model.dropFactor
                            ++ " ÷ "
                            ++ formatToDecimals 2 (durationInMinutes model.durationUnit duration)
                            ++ " "
                            ++ strings.minutesShort
                        ]
                    }

            ( Nothing, Nothing ) ->
                Label.empty strings.resultHint
        )


durationUnitToValue : DurationUnit -> String
durationUnitToValue unit =
    case unit of
        Hours ->
            "hours"

        Minutes ->
            "minutes"


durationUnitFromValue : String -> DurationUnit
durationUnitFromValue value =
    if value == "minutes" then
        Minutes

    else
        Hours
