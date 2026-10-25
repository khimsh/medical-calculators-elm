# Proposal

## Why

Every calculator stores its error as finished text in the language that was active when the user pressed Calculate. Switching language afterwards re-renders the labels but not the error, so a Georgian error stays on an English page. This breaks the Language toggle requirement that all visible text switches. The free water deficit card has a second symptom: it tells its sodium notice from an error by comparing the stored text with the current language's text. After a switch the comparison fails, and the notice is shown as an error with `role="alert"`.

## What Changes

- Each calculator stores which error happened, not its text. The text is looked up in the current language when the card is drawn. This covers Pills, Liquids, Nutrition, Free water deficit, IV infusion rate, Body surface area and Weight-based dose.
- Calculator `update` functions no longer take the translated strings. Errors were their only use of them, so the compiler stops this bug from coming back.
- The free water deficit sodium notice is chosen by its kind, not by comparing text, so it stays a notice after a language switch.
- The Language toggle requirement gains a scenario for a shown error, and one for the free water deficit notice, surviving a language switch.
- The Georgian body surface area unit becomes "მ²", in line with the other translated units ("მგ", "კგ", "სმ"). English stays "m²".
- Add a test for how the body surface area result is displayed, so the "2.00" padding is covered and not only the unrounded number.

No formula, validation rule, error wording, or layout changes. The same errors appear for the same inputs.

### Assumptions

- One shared error type covers "Enter valid inputs" and "All values must be greater than zero", since all calculators use those two. The free water deficit sodium notice stays local to that calculator.
- Removing the strings argument from `update` is worth the churn in tests. It is a mechanical change at each call site.

### Out of scope

- New error messages or changed wording.
- Translating results that are already numbers, which already follow the language.
- Any other unit or label wording changes.
- Changing which formulas or inputs each calculator uses.

## Capabilities

### New Capabilities

<!-- None. -->

### Modified Capabilities
- `calculator-page`: the Language toggle requirement adds scenarios for an error and for the free water deficit notice switching language.
- `body-surface-area`: the bilingual texts requirement adds a scenario for the Georgian unit "მ²".

## Impact

**Elm modules:**
- New: `src/Calculators/InputError.elm` (shared error type and its view)
- Changed: `src/Calculators/Pills.elm`, `src/Calculators/Liquids.elm`, `src/Calculators/Nutrition.elm`, `src/Calculators/FreeWaterDeficit.elm`, `src/Calculators/IvInfusionRate.elm`, `src/Calculators/BodySurfaceArea.elm`, `src/Calculators/WeightBasedDose.elm`, `src/Main.elm` (update calls), `src/Translations.elm` (Georgian `bsaUnit`), and `src/Functions.elm` if `errorDisplay` moves into the new module

**Tests:**
- Changed: `tests/MainTests.elm` (Pills and Liquids), `tests/NutritionTests.elm`, `tests/FreeWaterDeficitTests.elm`, `tests/IvInfusionRateTests.elm`, `tests/BodySurfaceAreaTests.elm` (also the new display test), `tests/WeightBasedDoseTests.elm`

No new dependencies. No stored data changes.
