# Proposal

## Why

Many drug orders, especially in paediatrics, are written as a dose per kilogram of body weight. Weight-based dose is the next unchecked item on `CALCULATOR_CHECKLIST.md`. Staff currently multiply it out by hand. A weight-based dose card lets the same page do it, next to the other medication dosing calculators.

## What Changes

- Add a **Weight-based dose** calculator card in the Medication dosing category. It takes the dose per kg (mg/kg) and the weight (kg), both as number fields.
- The result is the total dose in mg, rounded to at most two decimal places, with its working underneath using the user's own numbers, for example 15 mg/kg × 70 kg.
- Inputs are checked the same way as in the other calculators: empty or non-numeric input shows "Enter valid inputs", and zero or negative values show "All values must be greater than zero".
- The calculator appears after Body surface area, so the Medication dosing category reads Pills, Liquids, IV infusion rate, Body surface area, Weight-based dose. **BREAKING (display order):** Free water deficit and Nutrition move down one place on the All calculators page.
- The calculator can be marked as a favorite, with the favorites key `weight-based-dose`.
- Add all new labels to `src/Translations.elm` in Georgian and English.
- Add the formula and its source to `FORMULAS.md`, where the Pediatric Dosing entry currently says only "mg/kg formulas".
- Tick item 2 on `CALCULATOR_CHECKLIST.md` and move it to Done.

**Formula source:** D. C. Morris, *Calculate with Confidence*, 8th ed. (Elsevier, 2022; ISBN 9780323696968), chapter 24, "Pediatric and Adult Dosage Calculation Based on Weight". Dose (mg) = dose per kg (mg/kg) × weight (kg). This is the same textbook the IV infusion rate calculator cites, whose earlier editions credit the author as Gray Morris. The checklist only proposed "standard mg/kg dosing", so this change confirms the textbook as the source. The chapter title and number come from the publisher's table of contents. The formula is cross-checked against the worked examples on RMIT University's Learning Lab page on dosage by body weight.

### Assumptions

- The result is rounded to at most two decimal places and shown without trailing zeros, as `formatToDecimals 2` does (1050 mg, 30.75 mg). Very small doses, such as 0.015 mg/kg × 4.2 kg = 0.063 mg, show as 0.06 mg. This matches the precision of the other calculators.
- The units are fixed at mg/kg and mg. Orders in mcg/kg or units/kg are not covered.
- The result is a single total dose. It is not split into doses per day or per administration.

### Out of scope

- A maximum-dose cap or any warning when a dose is high, which would be patient-facing guidance.
- Unit choice (mcg, g, units), daily-dose splitting, and doses per m² (BSA-based dosing).
- Volume conversion, for example turning the mg dose into mL of a liquid. The Liquids calculator already does that.
- Changing the behaviour of the existing calculators.

## Capabilities

### New Capabilities
- `weight-based-dose`: inputs, validation, calculation, rounding, working, and result display of the weight-based dose calculator.

### Modified Capabilities
- `calculator-page`: the All calculators page lists seven calculators in the new order. Medication dosing gains the weight-based dose calculator. The weight-based dose calculator can be a favorite.

## Impact

**Elm modules:**
- New: `src/Calculators/WeightBasedDose.elm`
- Changed: `src/Functions.elm` (pure dose function), `src/Favorites.elm` (new `WeightBasedDose` variant and key), `src/Categories.elm` (Medication dosing list), `src/Main.elm` (model, messages, card), `src/Translations.elm` (new strings in both languages)

**Tests:**
- New: `tests/WeightBasedDoseTests.elm`
- Changed: `tests/FunctionsTests.elm` (dose function), `tests/FavoritesTests.elm` (new key and order), `tests/CategoriesTests.elm` (Medication dosing list)

**Other files:**
- `FORMULAS.md` (formula and source)
- `CALCULATOR_CHECKLIST.md` (item 2 ticked)
- `styles.css` is not expected to change. The card reuses the existing `.card`, `.field` and `.result` styles.

No new dependencies. Favorites stored under the old keys stay valid.
