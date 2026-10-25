# Tasks

## 1. Formula

- [x] 1.1 Add `calculateWeightBasedDose` to `src/Functions.elm` and export it. It takes the dose per kg in mg/kg and the weight in kg and returns their product, unrounded. Verify `npm run build` succeeds.
- [x] 1.2 Add tests to `tests/FunctionsTests.elm`: 15 mg/kg and 70 kg gives 1050; 2.5 mg/kg and 12.3 kg gives about 30.75; 0.015 mg/kg and 4.2 kg gives about 0.063. Verify `npm test` passes.
- [x] 1.3 Check the chapter title for weight-based dosage in *Calculate with Confidence* against the publisher's table of contents, then replace the "Weight-based dosing" line under Pediatric Dosing in `FORMULAS.md` with the formula, dose (mg) = dose per kg (mg/kg) × weight (kg), and that source. Verify the entry reads correctly.

## 2. Strings

- [x] 2.1 Add `weightBasedDose`, `dosePerKg`, `mgPerKg`, `dose` and `weightBasedDoseFormula` to the `Strings` type in `src/Translations.elm`, in English and Georgian, using the English text from design.md. Verify `npm run build` succeeds, which checks that both records are complete.

## 3. Calculator module

- [x] 3.1 Create `src/Calculators/WeightBasedDose.elm` with `Model` (dosePerKg, weight, result, error), `Msg`, `init` and `update`. The validation order is in design.md, and every input message clears the result and the error. Verify `npm run build` succeeds.
- [x] 3.2 Add `view` using `Card.view`, two `numberField`s for dose per kg and weight, and `Label.view`. The result shows the dose formatted with `formatToDecimals 2` and the unit mg, with the working line `<dose> mg/kg × <weight> kg` underneath. It must show no cap or warning. Verify `npm run build` succeeds.
- [x] 3.3 Add `tests/WeightBasedDoseTests.elm` covering every scenario in `specs/weight-based-dose/spec.md` that `update` can check: the three dose examples and the large dose, the empty, non-numeric, zero and negative errors, stale-result and stale-error clearing, and reset. Verify `npm test` passes.

## 4. Page wiring, favorites and categories

- [x] 4.1 Add `WeightBasedDose` to `Favorites.Calculator` with the key `"weight-based-dose"`, placed after `BodySurfaceArea` in `all`. Extend `tests/FavoritesTests.elm` so an old stored list still decodes and the new key round-trips. Verify `npm test` passes.
- [x] 4.2 Add `WeightBasedDose` to the Medication dosing list in `src/Categories.elm`, after `BodySurfaceArea`. Update `tests/CategoriesTests.elm` so the concatenated list still equals `Favorites.all`. Verify `npm test` passes.
- [x] 4.3 Wire the calculator into `src/Main.elm`: the model field, `init`, a `WeightBasedDoseMsg` branch in `update`, and a `viewCalculator` branch. Verify `npm run build` succeeds and the Elm compiler reports no missing case branches.
- [x] 4.4 Confirm that `styles.css` needs no change for the new card, which reuses the existing `.card`, `.field` and `.result` styles. Verify by reading the generated markup classes against `styles.css`.

## 5. Docs and final checks

- [x] 5.1 In `CALCULATOR_CHECKLIST.md`, move "Weight-based dose" to Done as `- [x] Weight-based dose`. Verify the To do list now starts with Body mass index.
- [x] 5.2 Run `npm test` and `npm run build`. Verify both pass, as CI requires.
- [x] 5.3 Run `openspec validate add-weight-based-dose --strict` and verify it passes.

## Workflow follow-up

- The user checks the card in the browser: it is last in Medication dosing; 15 mg/kg and 70 kg shows 1050 mg with the working; the favorite toggle adds it to the Favorites page; switching language keeps the result.
- Review the Georgian strings before merging.
- Archive the change with `/opsx:archive` once it is merged.
