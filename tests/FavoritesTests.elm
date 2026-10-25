module FavoritesTests exposing (..)

import Expect
import Favorites exposing (Calculator(..))
import Json.Encode as Encode
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "Favorites"
        [ describe "toggle"
            [ test "adds a calculator that is not a favorite" <|
                \_ ->
                    Favorites.toggle Nutrition [ Pills ]
                        |> Expect.equal [ Pills, Nutrition ]
            , test "removes a calculator that is a favorite" <|
                \_ ->
                    Favorites.toggle Pills [ Pills, Nutrition ]
                        |> Expect.equal [ Nutrition ]
            ]
        , test "every calculator key round-trips" <|
            \_ ->
                List.map (Favorites.toKey >> Favorites.fromKey) Favorites.all
                    |> Expect.equal (List.map Just Favorites.all)
        , describe "decode"
            [ test "reads a valid list in canonical order" <|
                \_ ->
                    Encode.list Encode.string [ "free-water-deficit", "pills" ]
                        |> Favorites.decode
                        |> Expect.equal [ Pills, FreeWaterDeficit ]
            , test "round-trips through encode" <|
                \_ ->
                    Favorites.encode Favorites.all
                        |> Favorites.decode
                        |> Expect.equal Favorites.all
            , test "drops unknown keys and duplicates" <|
                \_ ->
                    Encode.list Encode.string [ "liquids", "unknown", "liquids" ]
                        |> Favorites.decode
                        |> Expect.equal [ Liquids ]
            , test "reads favorites stored before IV infusion rate existed" <|
                \_ ->
                    Encode.list Encode.string [ "pills", "nutrition" ]
                        |> Favorites.decode
                        |> Expect.equal [ Pills, Nutrition ]
            , test "reads the IV infusion rate key" <|
                \_ ->
                    Encode.list Encode.string [ "iv-infusion-rate" ]
                        |> Favorites.decode
                        |> Expect.equal [ IvInfusionRate ]
            , test "reads the body surface area key" <|
                \_ ->
                    Encode.list Encode.string [ "body-surface-area" ]
                        |> Favorites.decode
                        |> Expect.equal [ BodySurfaceArea ]
            , test "gives no favorites for a non-list value" <|
                \_ ->
                    Encode.string "garbage"
                        |> Favorites.decode
                        |> Expect.equal []
            , test "gives no favorites for null" <|
                \_ ->
                    Favorites.decode Encode.null
                        |> Expect.equal []
            ]
        ]
