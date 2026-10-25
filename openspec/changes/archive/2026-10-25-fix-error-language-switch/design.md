# Design

## Context

Each calculator's `update : Msg -> Model -> Strings -> Model` writes `error = Just strings.invalidInputs` or `Just strings.zeroNotAccepted` into the model. `Main.update` passes the current language's strings, and `ToggleLanguage` only changes `model.language`, so a stored error keeps the old language. Errors are the only thing any `update` reads from `Strings`. `FreeWaterDeficit.view` also checks `error == strings.sodiumNotElevated` to choose between `Label.notice` and `errorDisplay`. See proposal.md for motivation.

## Goals / Non-Goals

**Goals:**
- Stored model state holds no translated text, so any language switch re-renders everything.
- The compiler stops translated text from being stored again.

**Non-Goals:**
- Changing how results, which are already numbers or numeric strings, are stored.
- Restructuring calculators beyond their error handling.

## Decisions

**A shared `InputError` type in `src/Calculators/InputError.elm`.** It has two variants, `InvalidInputs` and `NotPositive`, a `text : Strings -> InputError -> String` lookup, and `view : Strings -> InputError -> Html msg`, which renders the existing error box (`class "error"`, `role="alert"`). It sits next to `Card` and `Label`, the other shared calculator view helpers. The alternative, a type per calculator, would repeat the same two variants seven times.

**`errorDisplay` moves into the new module.** Once every caller passes an `InputError`, `Functions.errorDisplay` has no other users. It is removed from `Functions`, which then no longer imports `Html`, if nothing else there needs it.

**Free water deficit gets its own problem type.** Its model's `error` becomes `Maybe Problem`, with `type Problem = InputProblem InputError | SodiumNotElevated`. The view matches on the variant to choose `Label.notice` or `InputError.view`, which removes the text comparison. The sodium notice is not an input error, so it stays out of the shared type.

**`update` drops its `Strings` argument.** The new signature is `update : Msg -> Model -> Model` in every calculator. `Main.update` stops calling `getStrings` in each calculator branch. The alternative, keeping the argument unused, would let a later change store translated text again without the compiler noticing.

**Tests compare variants, not text.** Tests that checked `Just testStrings.invalidInputs` now check `Just InvalidInputs`, or `Just (InputProblem InvalidInputs)` for free water deficit. Each test file that covers a calculator with an error adds one test that `InputError.text` gives different text for `englishStrings` and `georgianStrings`. This is the testable half of the new language-switch scenario, since the switch itself is in `Main`.

**BSA display test.** `formatBsa` becomes exposed from `Calculators.BodySurfaceArea` so `tests/BodySurfaceAreaTests.elm` can check that 2 gives "2.00", 1.8181 gives "1.82", and 0.05 gives "0.05".

**Georgian BSA unit.** `bsaUnit` in the Georgian record becomes "მ²". The English value stays "m²".

## Risks / Trade-offs

- **[Wide diff]** Seven modules, `Main` and six test files change at once. → Mitigation: tasks go one calculator at a time, with `npm test` and `npm run build` after each.
- **[Hidden string use]** An `update` might read `Strings` for something other than errors. → Mitigation: a check of each module found only `invalidInputs`, `zeroNotAccepted` and `sodiumNotElevated`. The compiler will flag anything missed once the argument is removed.
- **[Georgian unit]** "მ²" has not been used in the app before. → Mitigation: it follows the other translated units, and the user confirmed it.

## Migration Plan

No stored data changes. Rollback is a revert of the change's commit.
