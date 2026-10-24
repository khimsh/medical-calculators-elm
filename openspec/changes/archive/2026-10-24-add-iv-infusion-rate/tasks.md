# Tasks

## 1. Formulas

- [x] 1.1 Add `calculatePumpRate` and `calculateDripRate` to `src/Functions.elm` and export them. Verify `npm run build` succeeds.
- [x] 1.2 Add tests to `tests/FunctionsTests.elm`. Pump rate: 1000 mL / 8 h = 125 and 100 mL / 0.5 h = 200. Drip rate: 1000 × 20 / 480 ≈ 41.67, and 249 × 10 / 60 = 41.5, which rounds to 42. Verify `npm test` passes.
- [x] 1.3 Add the source for both formulas to FORMULAS.md under Medication Dosing & Administration: Gray Morris, *Calculate with Confidence*, and ISO 8536-4 for the 20 drops/mL default. Verify the entry reads correctly.

## 2. Strings

- [x] 2.1 Add the new `Strings` fields from design.md to `src/Translations.elm`, in English and Georgian. Verify `npm run build` succeeds, which checks that both records are complete.

## 3. Calculator module

- [x] 3.1 Create `src/Calculators/IvInfusionRate.elm` with `Model`, `DurationUnit`, `Msg`, `init` and `update`, following the validation order in design.md. Defaults are Hours and 20 drops/mL. Every input message clears the result and the error. Verify `npm run build` succeeds.
- [x] 3.2 Add `view` using `Card.view`, two `numberField`s, two `optionButtonsField`s, and `Label.view`. The result shows mL/h as the value, drops/min as an extra line, and the working lines for both. Verify `npm run build` succeeds.
- [x] 3.3 Add `tests/IvInfusionRateTests.elm` covering every scenario in `specs/iv-infusion-rate/spec.md` that `update` can check: hours, minutes, rounding, the three drop factors, the empty, zero and negative errors, stale-result clearing, and reset to defaults. Verify `npm test` passes.

## 4. Page wiring and favorites

- [x] 4.1 Add `IvInfusionRate` to `Favorites.Calculator`, last in `all`, with the key `"iv-infusion-rate"`. Extend `tests/FavoritesTests.elm` to check that an old stored list (`["pills", "nutrition"]`) still decodes to `[ Pills, Nutrition ]`. Verify `npm test` passes; the existing round-trip test also covers the new key.
- [x] 4.2 Wire the calculator into `src/Main.elm`: the model field, `init`, an `IvInfusionRateMsg` branch in `update`, and a `viewCalculator` branch. Verify `npm run build` succeeds and that the elm compiler reports no missing case branches.
- [x] 4.3 Run the app and check the card. It appears last on All calculators; the 1000 mL / 8 h / 20 drops/mL example shows 125 mL/h and 42 drops/min; switching language keeps the result; the favorite toggle adds it to the Favorites page; at 320 px wide there is no horizontal scroll.

## 5. Final checks

- [x] 5.1 Run `npm test` and `npm run build`. Verify both pass, as CI requires.
- [x] 5.2 Run `openspec validate add-iv-infusion-rate --strict` and verify it passes.

## Workflow follow-up

- Review the Georgian strings before merging.
- Archive the change with `/opsx:archive` once it is merged.
