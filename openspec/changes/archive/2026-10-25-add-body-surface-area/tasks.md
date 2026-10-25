# Tasks

## 1. Formula

- [x] 1.1 Add `calculateBodySurfaceArea` to `src/Functions.elm` and export it. It takes height in cm and weight in kg and returns √(height × weight ÷ 3600). Verify `npm run build` succeeds.
- [x] 1.2 Add tests to `tests/FunctionsTests.elm`: 170 cm and 70 kg gives 1.82; 180 cm and 80 kg gives 2.00; 160 cm and 50 kg gives 1.49 after rounding. Verify `npm test` passes.
- [x] 1.3 Update the Body Surface Area line in `FORMULAS.md` under Medication Dosing & Administration with the citation: Mosteller RD, *N Engl J Med* 1987;317:1098. Verify the entry reads correctly.

## 2. Strings

- [x] 2.1 Add `bodySurfaceArea`, `bsaFormula`, `bsaUnit` and `cm` to the `Strings` type in `src/Translations.elm`, in English and Georgian. `bsaUnit` is "m²" in both. Verify `npm run build` succeeds, which checks that both records are complete.

## 3. Calculator module

- [x] 3.1 Create `src/Calculators/BodySurfaceArea.elm` with `Model` (height, weight, result, error), `Msg`, `init` and `update`. The validation order is in design.md, and every input message clears the result and the error. Verify `npm run build` succeeds.
- [x] 3.2 Add `view` using `Card.view`, two `numberField`s for height and weight, and `Label.view`. The result shows the BSA in m² as the value and the working line underneath. It must show no dose. Verify `npm run build` succeeds.
- [x] 3.3 Add `tests/BodySurfaceAreaTests.elm` covering every scenario in `specs/body-surface-area/spec.md` that `update` can check: the three BSA examples, the working line, the empty, non-numeric, zero and negative errors, stale-result clearing, and reset. Verify `npm test` passes.

## 4. Page wiring, favorites and categories

- [x] 4.1 Add `BodySurfaceArea` to `Favorites.Calculator` with the key `"body-surface-area"`, placed after `IvInfusionRate` in `all`. Extend `tests/FavoritesTests.elm` so an old stored list still decodes and the new key round-trips. Verify `npm test` passes.
- [x] 4.2 Add `BodySurfaceArea` to the Medication dosing list in `src/Categories.elm`, after `IvInfusionRate`. Update `tests/CategoriesTests.elm` so the concatenated list still equals `Favorites.all`. Verify `npm test` passes.
- [x] 4.3 Wire the calculator into `src/Main.elm`: the model field, `init`, a `BodySurfaceAreaMsg` branch in `update`, and a `viewCalculator` branch. Verify `npm run build` succeeds and the Elm compiler reports no missing case branches.
- [x] 4.4 Confirm that `styles.css` needs no change for the new card. The card should reuse the existing `.card`, `.field` and `.result` styles.

## 5. Final checks

- [x] 5.1 Run `npm test` and `npm run build`. Verify both pass, as CI requires.
- [x] 5.2 Run `openspec validate add-body-surface-area --strict` and verify it passes.
- [x] 5.3 Check the card by hand: it is last in Medication dosing; 170 cm and 70 kg shows 1.82 m² with the working; the favorite toggle adds it to the Favorites page; switching language keeps the result.

## Workflow follow-up

- Review the Georgian strings before merging.
- Archive the change with `/opsx:archive` once it is merged.
