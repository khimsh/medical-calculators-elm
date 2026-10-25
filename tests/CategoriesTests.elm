module CategoriesTests exposing (tests)

import Categories exposing (Category(..))
import Expect
import Favorites exposing (Calculator(..))
import Test exposing (Test, describe, test)
import Translations exposing (englishStrings)


tests : Test
tests =
    describe "Categories"
        [ test "every calculator is in exactly one category, in page order" <|
            \_ ->
                List.concatMap Categories.calculators Categories.all
                    |> Expect.equal Favorites.all
        , test "categories are in display order" <|
            \_ ->
                Categories.all
                    |> Expect.equal [ MedicationDosing, FluidsAndElectrolytes, NutritionCategory ]
        , test "each category holds its calculators" <|
            \_ ->
                List.map Categories.calculators Categories.all
                    |> Expect.equal [ [ Pills, Liquids, IvInfusionRate, BodySurfaceArea, WeightBasedDose ], [ FreeWaterDeficit ], [ Nutrition ] ]
        , test "English titles" <|
            \_ ->
                List.map (Categories.title englishStrings) Categories.all
                    |> Expect.equal [ "Medication dosing", "Fluids & electrolytes", "Nutrition" ]
        ]
