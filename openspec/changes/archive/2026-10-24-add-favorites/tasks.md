# Tasks

## 1. Favorites logic

- [x] 1.1 Move `elm/json` to direct dependencies in `elm.json` and add `src/Favorites.elm` with `Calculator`, `all`, `toKey`, `fromKey`, `toggle`, `encode`, `decode`. Verify with `npm run build`
- [x] 1.2 Add `tests/FavoritesTests.elm` covering toggle add/remove, key round-trip for all calculators, and decode of a valid list, unknown keys, duplicates, and non-list/null values. Verify `npm test` passes

## 2. Routing, persistence, and view

- [x] 2.1 Add nav, favorite-label, and empty-state strings in both languages to `src/Translations.elm`. Verify with `npm run build`
- [x] 2.2 Convert `src/Main.elm` to `Browser.application` with `Page`, `pageFromUrl`, `favorites` from flags, `ToggleFavorite` + `saveFavorites` port, the top-bar nav with `aria-current`, `viewCalculator`, star toggles, and the Favorites empty state. Verify `npm run build` and `npm test` pass
- [x] 2.3 Update `index.html` to pass parsed `localStorage.favorites` as flags and save from the `saveFavorites` port, both in try/catch. Verify the app loads with storage empty, valid, and set to garbage
- [x] 2.4 Add `.page-nav`, `.card-slot`, `.favorite-toggle`, and `.empty-state` styles to `styles.css` using existing tokens. Verify AA contrast and no horizontal scroll at 320 px

## 3. Integration check

- [x] 3.1 In the browser, walk the spec scenarios: add/remove favorite, reload keeps favorites, `#favorites` shows only favorites in order, unfavoriting removes the card, empty hint, values kept between pages, legacy hashes show all, language switch translates nav and star labels

## Workflow follow-up

- Archive the change so `openspec/specs/calculator-page/spec.md` is updated.
