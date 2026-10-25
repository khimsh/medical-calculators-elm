# Proposal

## Why

Body surface area (BSA) is the basis for many chemotherapy and medication doses, and it is the next unchecked item on `CALCULATOR_CHECKLIST.md`. Staff currently work it out by hand or with a separate tool. A BSA card lets the same page calculate it from height and weight.

## What Changes

- Add a **Body surface area** calculator card in the Medication dosing category. It takes height (cm) and weight (kg), both as number fields.
- The result is the BSA in m², rounded to two decimal places, with its working underneath using the user's own numbers.
- Inputs are checked the same way as in the other calculators: empty or non-numeric input shows "Enter valid inputs", and zero or negative values show "All values must be greater than zero".
- The calculator appears after IV infusion rate, so the Medication dosing category reads Pills, Liquids, IV infusion rate, Body surface area. **BREAKING (display order):** Free water deficit and Nutrition move down one place on the All calculators page.
- The calculator can be marked as a favorite, with the favorites key `body-surface-area`.
- Add all new labels to `src/Translations.elm` in Georgian and English.
- Confirm the formula source in `FORMULAS.md`, which currently has the formula without a citation.
- Fix the "Grid within a category" scenario in the Calculator categories requirement. It still says two columns, which the refine-visual-hierarchy change replaced with one centred column.

**Formula source:** Mosteller RD. Simplified calculation of body-surface area. *N Engl J Med* 1987;317:1098 (PubMed 3657876). BSA (m²) = √(height cm × weight kg ÷ 3600). This confirms the checklist's proposed source. The citation is a one-page letter to the editor, and secondary sources agree with the formula it gives.

### Assumptions

- The result is rounded to two decimal places, the usual precision for reporting BSA. The inputs are whole centimetres and kilograms.
- The calculator reports BSA only. It does not show a dose, since a dose would be patient-facing guidance, which the project context forbids.
- The formula is Mosteller's. The Du Bois formula is more widely cited but older and was derived from nine subjects. Choosing between them is out of scope for this change.

### Out of scope

- Dose calculation from BSA, such as mg/m² dosing, and any maximum-dose cap.
- Other BSA formulas (Du Bois, Haycock, Gehan and George).
- Unit switching, for example inches and pounds.
- Clinical notices or warnings about BSA use.
- Changing the behaviour of the existing calculators.

## Capabilities

### New Capabilities
- `body-surface-area`: inputs, validation, calculation, rounding, working, and result display of the BSA calculator.

### Modified Capabilities
- `calculator-page`: the All calculators page lists six calculators in the new order. Medication dosing gains the BSA calculator. The "Calculator categories" grid scenario is corrected to one column. BSA can be a favorite.

## Impact

**Elm modules:**
- New: `src/Calculators/BodySurfaceArea.elm`
- Changed: `src/Functions.elm` (pure BSA function), `src/Favorites.elm` (new `BodySurfaceArea` variant and key), `src/Categories.elm` (Medication dosing list), `src/Main.elm` (model, messages, card), `src/Translations.elm` (new strings in both languages)

**Tests:**
- New: `tests/BodySurfaceAreaTests.elm`
- Changed: `tests/FunctionsTests.elm` (BSA function), `tests/FavoritesTests.elm` (new key and order), `tests/CategoriesTests.elm` (Medication dosing list)

**Other files:**
- `FORMULAS.md` (formula source)
- `styles.css` only if the working line needs styling. It should reuse the existing `.result` styles.

No new dependencies. Favorites stored under the old keys stay valid.
