# Design

## Context

The calculators follow one pattern: a pure function in `src/Functions.elm`, a module in `src/Calculators/` with `Model`, `Msg`, `init`, `update` and `view`, a `Card.view` wrapper, `numberField` inputs, and `Label.view` for results. The Body surface area change is the closest precedent and this change copies its shape: a two-field card, the same validation, a favorites variant, a place in the Medication dosing list, and strings in both languages. See proposal.md for motivation.

## Goals / Non-Goals

**Goals:**
- A weight-based dose card that follows the existing calculator pattern exactly.
- The formula and its textbook source recorded in `FORMULAS.md`.
- The page-level specs that list calculators stay accurate.

**Non-Goals:**
- Dose caps, warnings, or unit choice.
- Changes to the existing calculators' logic, layout or favorites storage.

## Decisions

**Formula in `Functions.elm`, with a pure function.** `calculateWeightBasedDose : Float -> Float -> Float` takes the dose per kg in mg/kg and the weight in kg and returns their product. It does no rounding, so it stays testable on its own. The alternative, inlining the multiplication in the module, would break the pattern every other calculator follows.

**Rounding at display time with `formatToDecimals 2`.** The model keeps the unrounded `Maybe Float`, and the view formats it with the existing `formatToDecimals 2`, which drops trailing zeros (1050, 30.75, 0.06). BSA instead pads to two places with its own `formatBsa`, because BSA is always reported as x.xx m². A dose in mg is not, and "1050.00 mg" reads worse than "1050 mg". `formatToDecimals` also absorbs float noise such as 2.5 × 12.3 = 30.750000000000004.

**Validation follows BSA.** The module parses both fields, then checks in this order: a parse failure shows "Enter valid inputs", and a value of zero or less shows "All values must be greater than zero". Every input message clears the result and the error.

**Working uses the user's numbers.** The working line is `15 mg/kg × 70 kg`, built from the raw field strings and the localized unit strings, as BSA does.

**No cap or warning.** A maximum dose depends on the drug and would be patient-facing guidance, which the project context forbids. The spec states this with a large-dose scenario, so a later change cannot add a warning without changing the spec.

**Category placement.** The calculator is last in Medication dosing, after Body surface area, as the other additions were. Existing favorites and positions within categories stay stable.

**Favorites key `weight-based-dose`.** The `WeightBasedDose` variant goes after `BodySurfaceArea` in `Favorites.all`. Stored favorites with the old keys still decode, because decoding filters known keys.

**Strings.** New `Strings` fields: `weightBasedDose` (card title), `dosePerKg` (field label, "Dose per kg (mg/kg)"), `mgPerKg` (unit, "mg/kg" / "მგ/კგ"), `dose` (result title), and `weightBasedDoseFormula` ("dose per kg × weight"). The existing `weight`, `kg`, `mg`, `invalidInputs`, `zeroNotAccepted`, `calculate`, `reset` and `resultHint` fields are reused. The Georgian text for the new fields is a first draft and needs review before merging.

## Risks / Trade-offs

- **[Precision for tiny doses]** Two decimal places turn 0.063 mg into 0.06 mg, a 5 % difference. → Mitigation: the precision matches the other calculators and is pinned by a spec scenario; mcg units are out of scope and can come later.
- **[Georgian wording]** The new Georgian labels have not been reviewed by a native speaker. → Mitigation: a review task before merging, as earlier calculator changes had.
- **[Source edition]** Chapter numbers in *Calculate with Confidence* vary by edition. → Mitigation: `FORMULAS.md` names the 8th edition and its ISBN, taken from the publisher's table of contents, and adds an independent worked example as a cross-check.

## Migration Plan

No stored data changes. Favorites saved before this change still load. Steps:
1. Add the formula, its tests, and the source in `FORMULAS.md`.
2. Add the strings, the module and its tests.
3. Wire the calculator into favorites, categories and the page.
4. Tick the checklist item, then run `npm test` and `npm run build` as the gate.

Rollback is a revert of the change's commit. Favorites keep the new key, which the old code ignores.
