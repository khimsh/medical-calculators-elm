# Design

## Context

`FormFields.selectField` renders a `<label>` plus `<select>`, used twice: Nutrition weight loss (values `"0"`–`"3"`, mapped to `ChangeWeightLoss Int`) and Free water deficit sex (`"male"`/`"female"`, mapped to `UpdateSex Sex`). `FormFields.radioButtonField` exists but nothing uses it. Styles live in `styles.css` and use the tokens on `:root` (`--accent`, `--accent-soft`, `--border`, `--radius-small`, `--control-height`). The tests only cover `update` and calculation, not views. See proposal.md for why.

## Goals / Non-Goals

**Goals:**
- One reusable option-button field with the same call shape as `selectField`, so the two call sites change only by name.
- Native keyboard and screen-reader behaviour, with no custom key handling.

**Non-Goals:**
- Changing the checkbox fields (critical, elderly) or any number inputs.
- Changing `Msg`, `Model`, or calculation logic.
- Adding view tests (no `Test.Html` usage in the suite today).

## Decisions

**Native radio inputs styled as buttons, not `<button aria-pressed>`.** Each option is an `<input type="radio">` with its own `<label>`, all inside a `<fieldset>` whose `<legend>` is the field label. The browser then provides arrow-key movement, one tab stop per group, and "radio, 2 of 4, checked" announcements. Toggle buttons would need a hand-written roving tabindex and `role="radiogroup"` to match that. The input is hidden visually (clip pattern, still focusable), and the label is styled as the button.
- Alternative: `role="radiogroup"` on divs with buttons. Rejected: more code, same result.

**Helper signature.** `optionButtonsField : String -> String -> String -> List SelectOption -> (String -> msg) -> Html msg` (label, group id, current value, options, on change). It matches `selectField`, so the call sites keep their value mappings. Each radio gets `name` = group id, `id` = `groupId ++ "-" ++ opt.value`, `checked (opt.value == currentValue)`, and `onCheck` that sends `opt.value` when checked. Using `checked` from the model keeps Reset and language switching correct.

**Styling.** `.field-options` is a `fieldset` with border, padding and margin reset, and the legend styled like `.field label`. `.field-options-list` is a `flex-wrap: wrap` row with a small gap. Each option label has `min-height: var(--control-height)`, `--border`, `--radius-small` and a `--surface` background. When selected (`input:checked + label`) it gets `--accent` background, white text and `--accent` border, plus `font-weight: 600` so the selection does not depend on colour alone. Focus uses `input:focus-visible + label` with the existing 3px `--accent` outline. Hover on unselected options uses `--accent-soft`.

**Remove dead helpers.** Delete `selectField` and `radioButtonField` and their imports (`option`, `select`), and remove `select` from the `.field` CSS rules and the reset rule.

## Risks / Trade-offs

- [The Georgian "None" label is longer than the percentages, so widths are uneven] → Options size to their content and wrap. This is acceptable and matches the 320 px scenario.
- [A hidden radio input could lose focus visibility] → Focus styling goes on the label through `:focus-visible + label`; check it by hand in the browser.
- [No automated view coverage] → Check by hand in the browser for both calculators, including keyboard, Reset, and language switch.
