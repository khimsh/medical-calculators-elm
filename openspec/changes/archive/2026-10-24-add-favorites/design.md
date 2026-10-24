# Design

## Context

`Main.elm` is a `Browser.document` holding each calculator's model and mapping their views with `Html.map`. The only port is `setLangAttribute`, subscribed in `index.html`. `Card.elm` and the calculator modules are generic over their own `Msg` and know nothing about Main. `elm/url` is a direct dependency; `elm/json` is indirect. The site is static on GitHub Pages under a `<base href>`. See proposal.md for why.

## Goals / Non-Goals

**Goals:**
- Bookmarkable Favorites page that works on static hosting.
- Bad `localStorage` contents can never crash init.
- Calculator modules and `Card.elm` stay unchanged.

**Non-Goals:**
- Reordering favorites or syncing them across devices.
- Persisting calculator inputs or the chosen language.

## Decisions

**Hash routing with `Browser.application`.** `pageFromUrl` maps fragment `"favorites"` to `FavoritesPage` and everything else to `AllPage`, which keeps the legacy-hash behaviour. Hash URLs need no server rewrites and work with the `<base href>`. Nav links are `href "#"` and `href "#favorites"`; internal link clicks go through `Nav.pushUrl`.
- Alternative: keep `Browser.document` and switch pages in-model only. Rejected: the page could not be bookmarked or reached with Back.

**`Favorites` module.** Holds `type Calculator = Pills | Liquids | Nutrition | FreeWaterDeficit`, `all` (canonical order), `toKey`/`fromKey` (`pills`, `liquids`, `nutrition`, `free-water-deficit`), `toggle`, `encode`, and `decode : Value -> List Calculator`. `decode` reads a list of strings, drops unknown keys and duplicates, and returns `[]` on any failure. Pure, so it is unit-tested directly.

**Flags as `Json.Decode.Value` plus a save port.** `index.html` reads `localStorage.favorites` and `JSON.parse`s it inside try/catch (fallback `null`) and passes it as flags; Elm decodes it with `Favorites.decode`. `port saveFavorites : Value -> Cmd msg` fires on every toggle; JS writes it inside try/catch because storage can throw in private mode. Typed `List String` flags were rejected because a malformed value would throw at init.

**Star button lives in Main, overlaid on the card.** The toggle must send Main's `ToggleFavorite`, which calculator `Msg` types cannot carry. Each card is wrapped in `div.card-slot` (position relative) with a `button.favorite-toggle` positioned top-right, `aria-pressed`, a fixed `aria-label` "Mark <calculator title> as favorite" (the label stays the same so `aria-pressed` alone conveys the state), and ☆/★ as content (shape, not just colour). `.card header` gets right padding so titles don't run under it. Rendering goes through `viewCalculator : Strings -> Model -> Calculator -> Html Msg`.
- Alternative: add a header-action slot to `Card.view` and a toggle Msg to every calculator. Rejected: touches all five modules for one Main-level concern.

## Risks / Trade-offs

- [The star precedes the card in DOM order] → Tab order reaches it before the card's fields; acceptable and consistent across cards.
- [Long Georgian titles near the star] → Header right padding reserves the space; check by hand at 320 px.
- [No view tests in the suite] → `Favorites` logic is unit-tested; pages and storage are checked by hand in the browser.
