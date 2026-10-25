# Proposal

## Why

Too much of the page is bold. Nav links, buttons, field labels, option buttons, result titles, the banner and card titles all use weight 500 or 700, so no element stands out and the page reads as one flat level. The calculator cards also sit in two columns with top alignment, so cards with more fields or results end up at different heights from their neighbours, which makes the grid look uneven. A single column removes that side-by-side comparison and gives each card room.

## What Changes

- **One column of calculators at every width.** The All and Favorites pages show every calculator as one card per row, in category order. Cards keep a readable maximum width and are centred on the page, with each category heading aligned to the left edge of its cards. **BREAKING (layout):** the two-column layout on wide screens is removed.
- **Bold reserved for two levels.** Weight 700 is used only for category headings and calculated result values. Card titles move from 700 to 500, and the rest of the bold text drops to 500 or 400, as listed in the design.
- **More whitespace.** Gaps between cards, between categories, between fields and inside cards and the banner increase, so each element has room to breathe.
- The language toggle, favorite toggles, colours, font, formulas and calculator behaviour do not change.

### Assumptions

- "Bold" means font weights 500 and 700 in `styles.css`. FiraGO's existing weights (400, 500, 700) are used, and no new font files are added.
- The one-column rule applies to the Favorites page too, so the two pages stay consistent.

### Out of scope

- Any change to Elm code, calculator logic, formulas, or translations. Text stays the same.
- New colours, a new theme, or a new font.
- Changing the mobile layout, which is already one column.
- Equal-height cards. One column makes them unnecessary.

## Capabilities

### New Capabilities
<!-- none -->

### Modified Capabilities
- `calculator-page`: the "Responsive layout" requirement changes to one column at every width. A new "Text hierarchy" requirement sets which text may be bold.

## Impact

- Styles: `styles.css` only. The `.calculators` grid, the `.card` and `.card-slot` sizing, the weights listed in the design, and the spacing values.
- Elm modules: none. `src/Main.elm`, `src/Calculators/*.elm`, and `src/Translations.elm` are not changed.
- Tests: none. `npm test` and `npm run build` must still pass; no test assertions depend on styling.
- The `mvp-release` spec is not affected.
