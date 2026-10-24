module Favorites exposing (Calculator(..), all, decode, encode, fromKey, toKey, toggle)

import Json.Decode as Decode
import Json.Encode as Encode


type Calculator
    = Pills
    | Liquids
    | Nutrition
    | FreeWaterDeficit


all : List Calculator
all =
    [ Pills, Liquids, Nutrition, FreeWaterDeficit ]


toKey : Calculator -> String
toKey calculator =
    case calculator of
        Pills ->
            "pills"

        Liquids ->
            "liquids"

        Nutrition ->
            "nutrition"

        FreeWaterDeficit ->
            "free-water-deficit"


fromKey : String -> Maybe Calculator
fromKey key =
    List.filter (\calculator -> toKey calculator == key) all
        |> List.head


toggle : Calculator -> List Calculator -> List Calculator
toggle calculator favorites =
    if List.member calculator favorites then
        List.filter ((/=) calculator) favorites

    else
        favorites ++ [ calculator ]


encode : List Calculator -> Encode.Value
encode favorites =
    Encode.list (toKey >> Encode.string) favorites


{-| Never fails: unknown keys and duplicates are dropped, and anything that
is not a list of strings gives no favorites.
-}
decode : Decode.Value -> List Calculator
decode value =
    case Decode.decodeValue (Decode.list Decode.string) value of
        Ok keys ->
            List.filter (\calculator -> List.member (toKey calculator) keys) all

        Err _ ->
            []
