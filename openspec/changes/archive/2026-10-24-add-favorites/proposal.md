# Proposal

## Why

Every calculator is shown on one long page, but most users rely on one or two of them. Letting users mark calculators as favorites and open a page with only those saves scrolling, especially on phones at the bedside.

## What Changes

- Each calculator card gets a star toggle that adds it to or removes it from the user's favorites.
- Favorites are remembered in the browser (`localStorage`) and survive reloads. Missing or corrupt stored data means no favorites; it never breaks the page.
- A new Favorites page at `#favorites` shows only the favorited calculators, in the usual order, with a hint when there are none.
- The top bar gets a two-item navigation: "All" and "Favorites". **BREAKING** (spec): this reverses the "No navigation controls" requirement.
- The root URL and any other hash (including legacy `#pills` etc.) still show all calculators.
- Calculator inputs and results are shared between both pages; switching pages keeps entered values.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

- `calculator-page`: the one-page and no-navigation requirements change; new requirements for favorite toggles, their persistence, and the Favorites page.

## Impact

- `src/Main.elm`: becomes a `Browser.application` with hash routing, favorites state, and a port to save favorites.
- New `src/Favorites.elm` with the calculator identity type and favorites encode/decode/toggle.
- `src/Translations.elm`: nav, star-label, and empty-state strings.
- `index.html`: reads favorites from `localStorage` into flags and saves them from the port.
- `styles.css`: nav, star button, and empty-state styles.
- `elm.json`: `elm/json` becomes a direct dependency. No new packages.
