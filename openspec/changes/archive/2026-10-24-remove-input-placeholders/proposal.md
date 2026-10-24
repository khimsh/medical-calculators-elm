# Proposal

## Why

Every number field shows `0.0` as its placeholder. The hint tells the user nothing that the field label (which already names the unit) does not. It can also be misread as an entered zero, and most calculators reject zero. A blank field is clearer than any hint.

## What Changes

- Remove the placeholder from all 11 number fields in Pills, Liquids, Nutrition, Free water deficit and IV infusion rate.
- Remove the placeholder parameter from the shared number field helper, so no field can get one back by accident.
- No formula or calculation changes. No formula source applies, and FORMULAS.md is unaffected.

### Out of scope

- Example-value hints (e.g. "e.g. 70"). These were considered and dropped in favour of no placeholder.
- The `"0.0"` default `result` string in the Pills and Liquids models. It is a result value, not a placeholder.
- Changing labels, units, validation, or the `min="0"` attribute.

## Capabilities

### New Capabilities
- `calculator-inputs`: How calculator number fields present themselves to the user, starting with what an empty field shows.

### Modified Capabilities
<!-- none -->

## Impact

- Elm modules: `src/FormFields.elm`, `src/Calculators/Pills.elm`, `src/Calculators/Liquids.elm`, `src/Calculators/Nutrition.elm`, `src/Calculators/FreeWaterDeficit.elm`, `src/Calculators/IvInfusionRate.elm`. `src/Translations.elm` is unchanged.
- Tests: no test files change. `numberField` no longer accepts a placeholder, so the compiler enforces this, and no calculation logic changes.
- No new dependencies.
