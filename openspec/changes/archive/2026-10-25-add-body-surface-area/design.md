# Design

## Context

The calculators follow one pattern: a pure function in `src/Functions.elm`, a module in `src/Calculators/` with `Model`, `Msg`, `init`, `update` and `view`, a `Card.view` wrapper, `numberField` inputs, and `Label.view` for results. The IV infusion rate change is the closest precedent. It added a calculator to the category list, a favorites variant, and strings in both languages. `calculator-inputs` forbids placeholders on number fields. See proposal.md for motivation.

## Goals / Non-Goals

**Goals:**
- A BSA card that follows the existing calculator pattern exactly.
- The Mosteller formula, with its citation confirmed in `FORMULAS.md`.
- The page-level specs that list calculators stay accurate, including the stale grid scenario.

**Non-Goals:**
- Dose output, dosing advice, or any clinical notice.
- Other BSA formulas or unit conversion.
- Changes to the existing calculators' logic, layout or favorites storage.

## Decisions

**Formula in `Functions.elm`, with a pure function.** `calculateBodySurfaceArea : Float -> Float -> Float` takes height in cm and weight in kg and returns √(height × weight ÷ 3600). The module rounds the result with the existing `roundToTwoDecimals`, as the nutrition calculator does, so the function stays testable on its own.

**Validation follows the IV calculator.** The module parses both fields, then checks in this order: a parse failure shows "Enter valid inputs", and a value of zero or less shows "All values must be greater than zero". This keeps the two errors the same across calculators.

**Working uses the user's numbers.** The working line is √(170 cm × 70 kg ÷ 3600), so a user can check the result by hand. This is the same approach the IV calculator takes.

**Single result, no dose.** The result is the BSA alone. Showing a dose would be patient-facing guidance, which the project context forbids, so a dose is left for a separate change.

**Mosteller over Du Bois.** Du Bois is more widely cited, but it was derived from nine subjects. Mosteller's formula is simpler to check by hand and matches the checklist's proposed source. The two formulas agree closely for typical adult values, but they do not give identical numbers, so the formula line names the one used.

**Category placement.** The calculator is last in Medication dosing, after IV infusion rate, as the other additions were. This keeps existing favorites and positions stable within their categories.

**Grid scenario corrected.** The "Grid within a category" scenario still said two columns. The refine-visual-hierarchy change replaced that layout but did not update this scenario. This change's calculator-page delta fixes it, so the spec agrees with the page.

**Favorites key `body-surface-area`.** The key is added to the favorites list. Stored favorites with the old keys still decode, as the IV infusion change showed.

**Strings.** New `Strings` fields are `bodySurfaceArea`, `bsaFormula`, `bsaUnit` (m², the same in both languages), and `cm`. The existing `height`, `weight`, `kg` and `invalidInputs` fields are reused. The Georgian text for the new fields is a first draft and needs review before merging.

## Risks / Trade-offs

- **[Georgian wording]** The new Georgian labels, especially "ზედაპირის ფართობი" and the formula line, have not been reviewed by a native speaker. → Mitigation: a review task before merging, as the IV change had.
- **[Formula choice]** Users who expect Du Bois will see a different number. → Mitigation: the formula line names the Mosteller formula, and the working shows the calculation.
- **[Page length]** Adding a calculator makes the All page longer by one card. → Mitigation: the single centred column from the refine change already accepts a longer page.

## Migration Plan

No stored data changes. Favorites saved before this change still load. Steps:
1. Add the formula, its tests, and the citation in `FORMULAS.md`.
2. Add the strings, the module and its tests.
3. Wire the calculator into favorites, categories and the page, and update the page-level specs.
4. Run `npm test` and `npm run build` as the gate.

Rollback is a revert of the change's commit. Favorites keep the new key, which the old code ignores.
