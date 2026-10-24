# Tasks

## 1. Remove redundant tests

- [x] 1.1 In `tests/FunctionsTests.elm` delete the `floatToStr` describe group and drop `floatToStr` from the `Functions` import; verify `npx elm-test tests/FunctionsTests.elm` passes 12 tests
- [x] 1.2 In `tests/MainTests.elm` delete the Liquids "calculates decimal result" test; verify `npx elm-test tests/MainTests.elm` passes 4 tests
- [x] 1.3 In `tests/FreeWaterDeficitTests.elm` delete "Initial model has empty fields and no result", "Update weight updates the model", "Update sodium updates the model", "70 kg man with Na 160 has a deficit of 6.0 L", the `totalBodyWaterFactor` describe group, and "calculateFreeWaterDeficit returns liters"; remove the now-unused `Functions` import and any unused `Expect` exposing; verify `npx elm-test tests/FreeWaterDeficitTests.elm` passes 11 tests

## 2. Add missing tests

- [x] 2.1 In `tests/FunctionsTests.elm` add a `calculateBMI` test (70 kg / 175 cm → 22.857), a `scoreCalculator` group (BMI 22 → 0, exactly 20 → 1, exactly 18.5 → 1, 18.4 → 2; weight loss 2 → +1, 3 → +2; critical → +2), and four `calculateCalories` tests (score 2 with BMI 17 → 30 kcal/kg, score 1 → 25 kcal/kg, score 2 with BMI exactly 16 → 30 kcal/kg, score 2 with BMI exactly 14 → 10 kcal/kg); verify `npx elm-test tests/FunctionsTests.elm` passes 24 tests
- [x] 2.2 In `tests/MainTests.elm` add Pills tests (empty → `invalidInputs`, 100/30 → `"3.33"`, `ChangePrescribed` after `Calculate` sets `calculated = False`) and Liquids tests (a zero input → `zeroNotAccepted`, empty → `invalidInputs`, 10/3×1 → `"3.33"`, editing after `Calculate` sets `calculated = False`); verify `npx elm-test tests/MainTests.elm` passes 11 tests
- [x] 2.3 Create `tests/NutritionTests.elm` with the 7 tests in the proposal (70/175 happy path checking bmi, calories, proteins, fats, carbs; 40/170 critical → `"200"` kcal; empty; zero height; negative weight; unparseable; editing after `Calculate` sets `calculated = False`); verify `npx elm-test tests/NutritionTests.elm` passes 7 tests
- [x] 2.4 In `tests/FreeWaterDeficitTests.elm` add a test that `UpdateSodium` after a successful `Calculate` sets `result` back to `Nothing`; verify `npx elm-test tests/FreeWaterDeficitTests.elm` passes 12 tests

## 3. Integration check

- [x] 3.1 Run `npm test` and verify it reports 54 passed, 0 failed, with no compiler warnings about unused imports
