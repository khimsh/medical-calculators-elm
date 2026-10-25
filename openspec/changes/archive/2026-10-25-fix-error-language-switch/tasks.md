# Tasks

## 1. Shared error type

- [x] 1.1 Create `src/Calculators/InputError.elm` with `type InputError = InvalidInputs | NotPositive`, `text : Strings -> InputError -> String` (mapping to `invalidInputs` and `zeroNotAccepted`), and `view : Strings -> InputError -> Html msg`, which renders the same markup as `Functions.errorDisplay`. Verify `npm run build` succeeds.

## 2. Calculators, one at a time

For each task: change the model's `error` to `Maybe InputError`, drop the `Strings` argument from `update`, render errors with `InputError.view strings`, update its call in `src/Main.elm`, and update its tests to compare variants. Verify `npm test` and `npm run build` pass after each.

- [x] 2.1 Pills: `src/Calculators/Pills.elm` and its tests in `tests/MainTests.elm`.
- [x] 2.2 Liquids: `src/Calculators/Liquids.elm` and its tests in `tests/MainTests.elm`.
- [x] 2.3 Nutrition: `src/Calculators/Nutrition.elm` and `tests/NutritionTests.elm`.
- [x] 2.4 IV infusion rate: `src/Calculators/IvInfusionRate.elm` and `tests/IvInfusionRateTests.elm`.
- [x] 2.5 Body surface area: `src/Calculators/BodySurfaceArea.elm` and `tests/BodySurfaceAreaTests.elm`.
- [x] 2.6 Weight-based dose: `src/Calculators/WeightBasedDose.elm` and `tests/WeightBasedDoseTests.elm`.
- [x] 2.7 Free water deficit: in `src/Calculators/FreeWaterDeficit.elm`, add `type Problem = InputProblem InputError | SodiumNotElevated`, store `Maybe Problem`, and choose `Label.notice` or `InputError.view` by variant instead of comparing text. Update `tests/FreeWaterDeficitTests.elm`, including a test that 130 mmol/L gives `Just SodiumNotElevated` (the notice is for sodium below 140; exactly 140 gives a deficit of 0).

## 3. Clean-up and language tests

- [x] 3.1 Remove `errorDisplay` from `src/Functions.elm` and its export, and drop the `Html` imports there if nothing else uses them. Verify `npm run build` succeeds and `grep -rn errorDisplay src` finds nothing.
- [x] 3.2 Add a test (in a new `tests/InputErrorTests.elm`) that `InputError.text` gives different text for `englishStrings` and `georgianStrings`, for both variants. Verify `npm test` passes.
- [x] 3.3 Confirm no calculator `update` takes `Strings`: `grep -n "^update :" src/Calculators/*.elm` shows `Msg -> Model -> Model` for all seven. Verify the output.

## 4. Body surface area display and unit

- [x] 4.1 Expose `formatBsa` from `Calculators.BodySurfaceArea` and add tests to `tests/BodySurfaceAreaTests.elm`: 2 gives "2.00", 1.8181 gives "1.82", 0.05 gives "0.05". Verify `npm test` passes.
- [x] 4.2 Change the Georgian `bsaUnit` in `src/Translations.elm` to "მ²", keeping English "m²". Add a test that the two records give "m²" and "მ²". Verify `npm test` passes.

## 5. Final checks

- [x] 5.1 Run `npm test` and `npm run build`. Verify both pass, as CI requires.
- [x] 5.2 Run `openspec validate fix-error-language-switch --strict` and verify it passes.

## Workflow follow-up

- The user checks in the browser: in Georgian, press Calculate on an empty card, then switch to English, and the error is in English. In free water deficit, enter 70 kg and 130 mmol/L, calculate, switch language, and the notice is translated and still styled as a notice. The BSA result shows "მ²" in Georgian.
- Archive the change with `/opsx:archive` once it is merged.
