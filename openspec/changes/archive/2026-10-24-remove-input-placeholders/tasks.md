# Tasks

## 1. Shared field helper

- [x] 1.1 Remove the placeholder parameter and the `placeholder` import from `numberField` in `src/FormFields.elm`. Verify that `npm run build` reports errors only at the `numberField` call sites in the calculators (expected until group 2 is done).

## 2. Calculator call sites

- [x] 2.1 Pills: drop the `"0.0"` argument from both `numberField` calls in `src/Calculators/Pills.elm`. Verify that the build reports no errors in this module.
- [x] 2.2 Liquids: drop the `"0.0"` argument from all three `numberField` calls in `src/Calculators/Liquids.elm`. Verify that the build reports no errors in this module.
- [x] 2.3 Nutrition: drop the `"0.0"` argument from both `numberField` calls in `src/Calculators/Nutrition.elm`. Verify that the build reports no errors in this module.
- [x] 2.4 Free water deficit: drop the `"0.0"` argument from both `numberField` calls in `src/Calculators/FreeWaterDeficit.elm`. Verify that the build reports no errors in this module.
- [x] 2.5 IV infusion rate: drop the `"0.0"` argument from both `numberField` calls in `src/Calculators/IvInfusionRate.elm`. Verify that `npm run build` succeeds.

## 3. Integration check

- [x] 3.1 Confirm that `grep -rn 'placeholder' src` returns nothing and that `grep -rn '"0.0"' src` matches only the Pills/Liquids `result` defaults. Then run `npm test` and `npm run build`, and confirm both pass.
