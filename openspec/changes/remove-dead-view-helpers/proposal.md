# Proposal

## Why

`src/Functions.elm` holds three view helpers that nothing calls: `fieldGroup`, `calculateButton` and `resetButton`. They were replaced by `FormFields.numberField` and `Calculators.Card`. `src/FormFields.elm` also exports `textField`, which no calculator uses. `module Functions exposing (..)` keeps the compiler and reviewers from noticing exports that go unused, so the code can come back or be copied by mistake.

## What Changes

- Delete `fieldGroup`, `calculateButton` and `resetButton` from `src/Functions.elm`, along with the `Html` imports that only they used.
- Delete `textField` from `src/FormFields.elm` and from its export list.
- Replace `module Functions exposing (..)` with an explicit list of what `src/` and `tests/` import: `strToFloat`, `floatToStr`, `formatToDecimals`, `roundToTwoDecimals`, `calculateBMI`, `scoreCalculator`, `NutritionResult`, `calculateCalories`, `Sex(..)`, `totalBodyWaterFactor`, `calculateFreeWaterDeficit`, `errorDisplay`.
- No change to rendered HTML, styling, calculations or translations.

**Out of scope**
- New shared components, such as a generic list helper or new field types.
- Moving `errorDisplay` out of `Functions.elm` or reorganizing modules.
- Restyling or changes to `styles.css`.
- Changes to calculator logic or formulas.

## Capabilities

### New Capabilities
None.

### Modified Capabilities
None. This is a refactor with no change in behavior, so the change sets `skip_specs: true`.

## Impact

- Elm modules that change: `src/Functions.elm`, `src/FormFields.elm`.
- Test files: none. Existing imports in `tests/FunctionsTests.elm` and `tests/FreeWaterDeficitTests.elm` stay valid because everything they import remains exported.
- Importers in `src/Calculators/*.elm` need no edits.
- No dependency or build changes. `npm test` and `npm run build` must still pass.
