module Categories exposing (Category(..), all, calculators, title)

import Favorites exposing (Calculator(..))
import Translations exposing (Strings)


type Category
    = MedicationDosing
    | FluidsAndElectrolytes
    | NutritionCategory


all : List Category
all =
    [ MedicationDosing, FluidsAndElectrolytes, NutritionCategory ]


{-| Concatenated over `all`, this must equal `Favorites.all`.
-}
calculators : Category -> List Calculator
calculators category =
    case category of
        MedicationDosing ->
            [ Pills, Liquids, IvInfusionRate, BodySurfaceArea ]

        FluidsAndElectrolytes ->
            [ FreeWaterDeficit ]

        NutritionCategory ->
            [ Nutrition ]


title : Strings -> Category -> String
title strings category =
    case category of
        MedicationDosing ->
            strings.medicationDosing

        FluidsAndElectrolytes ->
            strings.fluidsAndElectrolytes

        NutritionCategory ->
            strings.nutritionCategory
