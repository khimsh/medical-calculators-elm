# Tasks

## 1. Functions module

- [x] 1.1 Delete `fieldGroup`, `calculateButton` and `resetButton` from `src/Functions.elm`, and drop the imports only they used (`button`, `input`, `label`, `for`, `id`, `type_`, `value`, `onClick`, `onInput`, and the `Html.Events` import). Verify with `grep -rn -E 'fieldGroup|calculateButton|resetButton' src tests` returning nothing and `npm run build` succeeding.
- [x] 1.2 Replace `module Functions exposing (..)` with `module Functions exposing (NutritionResult, Sex(..), calculateBMI, calculateCalories, calculateFreeWaterDeficit, errorDisplay, floatToStr, formatToDecimals, roundToTwoDecimals, scoreCalculator, strToFloat, totalBodyWaterFactor)`. Verify that `npm run build` and `npm test` both pass.

## 2. FormFields module

- [x] 2.1 Delete `textField` from `src/FormFields.elm` and remove it from the module's export list. Verify with `grep -rn textField src tests` returning nothing and `npm run build` succeeding.

## 3. Integration check

- [x] 3.1 Run `npm test` and `npm run build`, and confirm both pass with the same test count as before the change.
