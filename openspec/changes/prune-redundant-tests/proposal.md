# Proposal

## Why

The 40 unit tests in `tests/` mix real clinical checks with tests that only restate a record literal, exercise a standard-library wrapper, or repeat another test through a different path. Meanwhile, real logic is untested: Nutrition's input handling, the nutrition risk score, several energy tiers, Liquids' zero and empty inputs, and result rounding. Prune the noise and cover the gaps, so every test protects a formula, a validation rule, or a boundary.

## What Changes

Remove 13 tests, keep 27, and add 27, for 54 in total. No production code changes.

### Removed (13)

**`tests/FunctionsTests.elm` (3):**
- `floatToStr` group: "converts integer", "converts decimal", and "converts zero" only test `String.fromFloat`.

**`tests/MainTests.elm` (1):**
- Liquids "calculates decimal result" (75/50×10 = 15). The result is not a decimal, and it uses the same path as "calculates correct liquid volume".

**`tests/FreeWaterDeficitTests.elm` (9):**
- "Initial model has empty fields and no result": compares `init` to a copy of itself.
- "Update weight updates the model" and "Update sodium updates the model": trivial field setters.
- "70 kg man with Na 160 has a deficit of 6.0 L": the same factor and path as the Na 150 case.
- `totalBodyWaterFactor` group (4): each factor is already checked end to end by the man/woman/elderly man/elderly woman deficit tests.
- "calculateFreeWaterDeficit returns liters": exact duplicate of the 70 kg / Na 150 case.

### Kept (27)

- `strToFloat` parsing guards (6).
- `calculateCalories` energy tiers and macro split (6).
- Pills: whole tablets, half tablets, zero strength (3).
- Liquids volume (1).
- Free water deficit: one case per body-water factor (4), Na = 140 boundary, Na < 140 notice, zero/negative weight, zero sodium, unparseable input, empty input (11).

### Added (27)

**`tests/FunctionsTests.elm` (12):**
- `calculateBMI`: 70 kg / 175 cm → 22.857.
- `scoreCalculator`: BMI 22 → 0; BMI exactly 20 → 1; BMI exactly 18.5 → 1; BMI 18.4 → 2; weight loss 5–10% → +1; weight loss >10% → +2; critical illness → +2.
- `calculateCalories`: score ≥ 2 with BMI ≥ 16 → 30 kcal/kg; score exactly 1 → 25 kcal/kg; score ≥ 2 with BMI exactly 16 → 30 kcal/kg; score ≥ 2 with BMI exactly 14 → 10 kcal/kg.

**`tests/MainTests.elm` (7):**
- Pills: empty inputs → invalid-input error; 100 mg / 30 mg → `"3.33"` (two-decimal rounding); editing an input after calculating hides the previous result.
- Liquids: a zero input → zero-not-accepted error; empty inputs → invalid-input error; 10 mg / 3 mg × 1 mL → `"3.33"`; editing an input after calculating hides the previous result.

**New `tests/NutritionTests.elm` (7):**
- 70 kg / 175 cm, no risk factors → BMI `"22.86"`, `"1750"` kcal, protein `"109"`, fat `"49"`, carbohydrate `"219"` g.
- 40 kg / 170 cm, critically ill → 200 kcal (5 kcal/kg tier).
- Empty inputs → invalid-input error.
- Zero height → zero-not-accepted error (guards the BMI division).
- Negative weight → zero-not-accepted error.
- Unparseable input → invalid-input error.
- Editing an input after calculating hides the previous result.

**`tests/FreeWaterDeficitTests.elm` (1):**
- Editing sodium after calculating clears the previous result.

### Assumptions

- Zero weight and negative weight both stay, because they are different inputs a user can type even though they share a branch.
- New tests lock in the formulas **as currently implemented**, including 30 kcal/kg for high-risk patients with BMI ≥ 16. They do not re-check the formulas clinically.
- The "editing hides the previous result" tests guard against a stale dose being shown next to new inputs.

## Capabilities

### New Capabilities

<!-- None: test-only change, no spec-level behavior changes (skip_specs: true). -->

### Modified Capabilities

<!-- None. -->

## Impact

- `tests/FunctionsTests.elm`, `tests/MainTests.elm`, `tests/FreeWaterDeficitTests.elm`: tests removed and added; unused imports cleaned up.
- New `tests/NutritionTests.elm`.
- `npm test` count goes from 40 to 54; all must pass.
- No changes to `src/`, the build, or CI.
