# Tasks

## 1. Option-button field

- [x] 1.1 Add `optionButtonsField` to `src/FormFields.elm`: a `fieldset.field-options` with a `legend`, and one visually hidden radio and label per option (`name` = group id, `id` = `groupId-value`, `checked` from the current value, `onCheck` sends the option value). Expose it, and verify with `npm run build`
- [x] 1.2 Add `.field-options` styles to `styles.css`: fieldset reset, legend styled like `.field label`, wrapping option row, button-like labels, a checked state with `--accent` fill, white text and heavier weight, a `:focus-visible + label` outline, and hover on `--accent-soft`. Verify the colours meet AA contrast (white on `#0014FF`, `--text` on `--surface`, `--border` against the surface ≥ 3:1)

## 2. Use it in the calculators

- [x] 2.1 Replace `selectField` with `optionButtonsField` in `src/Calculators/Nutrition.elm` (weight loss) and `src/Calculators/FreeWaterDeficit.elm` (sex), keeping the value mappings. Verify that `npm run build` and `npm test` pass
- [x] 2.2 Remove `selectField`, `radioButtonField`, and the unused `option`/`select` imports from `src/FormFields.elm`, and remove `select` from the `.field` and reset rules in `styles.css`. Verify that `npm run build` compiles with no unused-import warnings and that `grep -n "select" src styles.css` finds no dropdown code left

## 3. Manual verification

- [x] 3.1 In the browser, check both calculators against the spec scenarios: defaults (None, Male), clicking an option changes the result after Calculate, Reset restores the default, the language toggle keeps the selection, Tab and arrow keys move the selection with a visible focus ring, and at 320 px the options wrap with no horizontal scroll
