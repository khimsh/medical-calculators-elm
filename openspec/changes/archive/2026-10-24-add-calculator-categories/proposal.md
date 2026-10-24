# Proposal

## Why

The All calculators page is one flat grid of five cards, and it will get harder to scan as calculators are added. Grouping cards under category headings lets users find the right calculator by clinical area.

## What Changes

- Add three categories, each with a heading on the page:
  - **Medication dosing**: Pills, Liquids, IV infusion rate.
  - **Fluids & electrolytes**: Free water deficit.
  - **Nutrition**: Nutrition.
- The All calculators page shows each category as a section: the category heading, then its calculators in the existing card grid.
- **BREAKING (display order):** calculators now appear in category order: Pills, Liquids, IV infusion rate, Free water deficit, Nutrition. The current order is Pills, Liquids, Nutrition, Free water deficit, IV infusion rate.
- The Favorites page uses the same grouping and leaves out categories with no favorites. (Assumption: grouping there was not specified, but it keeps the two pages consistent.)
- Card titles move from `h2` to `h3`, so category headings (`h2`) sit above them in the heading outline.
- Category names are added to `src/Translations.elm` in English and Georgian.
- No formula or calculation changes. No formula source applies, and FORMULAS.md is unaffected.

### Out of scope

- Category navigation links, per-category URL hashes, and filter controls. The existing "No navigation controls" requirement stays as it is.
- Collapsing, reordering, or hiding categories by the user.
- Changes to stored favorites. The storage format stays the same and existing favorites remain valid.
- New calculators.

## Capabilities

### New Capabilities
<!-- none -->

### Modified Capabilities
- `calculator-page`: Calculators are grouped under category headings, which changes the order requirement on the All calculators page. The Favorites page groups its calculators the same way.

## Impact

- Elm modules:
  - New `src/Categories.elm`, which holds the category type, its order, and the calculators in each category.
  - `src/Main.elm`: the view renders sections per category.
  - `src/Favorites.elm`: `all` is reordered to category order.
  - `src/Calculators/Card.elm`: card titles change from `h2` to `h3`.
  - `src/Translations.elm`: three category names.
- Styles: `styles.css` gets category section and heading styles, and `.card h2` becomes `.card h3`.
- Tests: new `tests/CategoriesTests.elm`. `tests/FavoritesTests.elm` is checked against the new canonical order.
- No new dependencies.
