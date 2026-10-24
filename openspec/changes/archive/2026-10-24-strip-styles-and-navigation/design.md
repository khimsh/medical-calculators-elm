# Design

## Context

`Main.elm` is a `Browser.application` with a `View = IndexView | CalculatorView Calculator` model, hash parsing (`parseUrl`, `calculatorToFragment`), and `SelectCalculator` / `GoToIndex` / `LinkClicked` / `UrlChanged` messages that also reset every calculator model. Calculator views go through `Calculators.Card` (form wrapper) and `Calculators.Label` (result "dispensing label", plus CSS-driven `syringe` and `tablets` graphics). `FormFields` and `Functions` add `class` attributes everywhere.

The working tree currently has a large uncommitted restyle (new `_calculator.scss`, `_label.scss`, `Label.elm`, etc.). This change builds on that working tree as-is; much of it is about to be deleted.

## Goals / Non-Goals

**Goals:**
- One `Browser.document` program rendering the language toggle followed by the four calculators.
- Zero CSS, fonts, or style tooling in the repo, build, or deploy.
- Calculator logic and `update` functions untouched, so existing tests keep passing.

**Non-Goals:**
- Changing formulas, validation, or result rounding.
- Re-translating stored error/result strings when the language changes (existing behavior: they keep the language they were produced in).
- Accessibility attributes: `aria-*`, `role`, `for`/`id` pairs stay — they are semantics, not style.

## Decisions

**`Browser.document` instead of `Browser.application`.** With no routes there's no need for `Nav.Key`, `onUrlChange`, or `onUrlRequest`. A hash in the URL is then ignored by Elm, satisfying the legacy-URL scenario for free. Alternative: keep `application` and ignore URLs — more code for nothing.

**Model drops `currentView` and `navKey`; `Calculator` and `View` types go.** Messages left: `ToggleLanguage` and the four sub-messages. The `setLangAttribute` port and the JS subscription in `index.html` stay.

**View order: toggle button, then Pills, Liquids, Nutrition, Free water deficit**, each `Html.map`-ed as today, inside `main_`. No wrapper `div`s with classes.

**Keep `Card` and `Label` modules, strip them rather than delete.** `Card.view` still provides the `article`/`h2`/formula/form/buttons/`aria-live` output structure; just remove `class`. `Label` keeps `view`, `empty`, `notice`; delete `syringe`, `tablets`, `Barrel`, `barrels`, and their uses in `Liquids`/`Pills` (pass `extra = []`). `Label.view` keeps the value + unit + working as text. Alternative: inline everything into each calculator — more churn, no gain.

**Strip every `class` and `style`/`attribute "style"` in `src/`.** Includes `FormFields`, `Functions` (`errorDisplay`, button helpers), `Nutrition` (`macro`, `macros`). Remove now-unused `class`/`style` imports so `elm make` has no unused-import noise.

**Remove dead translation keys** from the `Strings` record and both language records: `intro`, `back`, `backToIndex`, `disclaimer`, `pillDescription`, `liquidDescription`, `nutritionDescription`, `freeWaterDeficitDescription`, `syringe`. Keep `title` (document title), `switchLanguage`, `otherLanguage`. Elm's compiler will flag any missed use.

**index.html** keeps the GitHub Pages `<base>` script, the `#elm-app` mount, `elm-app.js`, and the port subscription. Remove the stylesheet link, both font preloads, the NordPass `<style>` block, and the `color-scheme` meta (it only exists to theme styles).

**Tooling.** Delete `.stylelintrc.json`; remove `build:scss`, `watch:scss`, `watch:lint`, `watch:all`, `lint:scss`, `lint:scss:fix` scripts and `sass`, `stylelint`, `stylelint-order`, `onchange`, `npm-run-all` devDependencies; regenerate `package-lock.json` with `npm install`. Keep `prettier` (used for non-CSS files). In CI drop "Build SCSS" and the `styles.css` / `fonts` copy lines.

## Risks / Trade-offs

- [Removing the disclaimer banner from a medical app] → User's explicit choice; the README disclaimer remains. Flag in the summary so it's a conscious decision.
- [Uncommitted restyle work is deleted] → Suggest committing or stashing the current working tree before applying, so it's recoverable.
- [Bookmarked `#calc` links no longer focus a calculator] → All calculators are on one page, so the content is still reachable by scrolling.
- [Unstyled page is long on mobile] → Accepted; this is the intended blank slate.
