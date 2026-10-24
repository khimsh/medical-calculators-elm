# Tasks

## 1. Category model

- [x] 1.1 Add `medicationDosing`, `fluidsAndElectrolytes` and `nutritionCategory` to `Strings` in `src/Translations.elm`, in English and Georgian. Verify that `npm run build` compiles.
- [x] 1.2 Reorder `Favorites.all` to Pills, Liquids, IvInfusionRate, FreeWaterDeficit, Nutrition. Update any order-dependent expectations in `tests/FavoritesTests.elm`, and verify that `npm test` passes.
- [x] 1.3 Create `src/Categories.elm` with `Category`, `all`, `calculators` and `title`. Add `tests/CategoriesTests.elm` covering four things: the concatenated category calculators equal `Favorites.all`, there are three categories in order, each category has the expected calculators, and the English titles are right. Verify that `npm test` passes.

## 2. Page rendering

- [x] 2.1 Change the card title from `h2` to `h3` in `src/Calculators/Card.elm`, and rename `.card h2` to `.card h3` in `styles.css`. Verify that `npm run build` passes and the card titles look the same in the browser.
- [x] 2.2 Render one `section.category` per category in `Main.view`, each with an `h2` heading linked by `aria-labelledby` and its own `.calculators` grid. Drop categories with no visible calculators, and keep the no-favorites hint. Verify the All page shows three headed sections in the specified order.
- [x] 2.3 Add `.category` and `.category h2` styles in `styles.css`: section spacing, plus a heading larger than the card titles that meets the contrast requirement. Verify there's no horizontal scroll at 320 px and two columns at 1280 px.
- [x] 2.4 Verify the Favorites page in the browser. With Pills and Free water deficit favorited, it shows two headed sections. With only Nutrition, it shows one. With none, it shows only the hint. Unfavoriting the last calculator in a category removes that section.

## 3. Integration check

- [x] 3.1 Run `npm test` and `npm run build`, and confirm both pass. Switch the language and confirm the category headings are translated and entered values are kept.
