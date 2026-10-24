# Proposal

## Why

The Nutrition "weight loss" and Free water deficit "sex" fields are native `<select>` dropdowns. With only two to four short options, a dropdown hides the choices behind an extra tap, renders inconsistently across browsers and phones, and clashes with the new visual theme. Showing every option as a button lets users see and pick a value in one tap.

## What Changes

- Replace the `<select>` dropdown in the Nutrition calculator's weight loss field (None, 1-5%, 5-10%, >10%) with a row of option buttons.
- Replace the `<select>` dropdown in the Free water deficit calculator's sex field (Male, Female) with a row of option buttons.
- The selected option is visibly marked in the accent colour; exactly one option is always selected, and the defaults stay the same (None, Male).
- The option group stays keyboard and screen-reader accessible: it has a group label, the selected option is announced, and focus shows the existing `#0014FF` indicator.
- The option rows wrap onto more lines on narrow screens, so nothing scrolls horizontally at 320 px.
- Remove the `selectField` helper and the unused `radioButtonField` helper from `FormFields` in favour of one option-button helper. Calculation results and messages do not change.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

- `calculator-page`: adds a requirement that single-choice fields are shown as option buttons, not dropdowns.

## Impact

- `src/FormFields.elm`: new option-button field; `selectField` and `radioButtonField` removed.
- `src/Calculators/Nutrition.elm`, `src/Calculators/FreeWaterDeficit.elm`: use the new field.
- `styles.css`: styles for the option-button group; the `.field select` rule is removed.
- No new dependencies. `Msg` types and calculation logic are unchanged, so the existing tests still apply.
