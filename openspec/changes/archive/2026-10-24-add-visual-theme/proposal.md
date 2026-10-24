# Proposal

## Why

The app is a single unstyled page: four calculators rendered with browser defaults. It works, but it is hard to scan, and the Georgian text falls back to whatever system font is available. A light, modern theme with one Georgian/Latin sans-serif font makes the calculators easier to read and use, especially on phones.

## What Changes

- **BREAKING (spec)** Replace the "unstyled presentation" requirement: the page now loads one stylesheet (`styles.css`) and the FiraGO web font.
- Colour theme with two brand colours: accent `#0014FF` (buttons, focus rings, result values, links) and background `#F4F5FF` (page and surfaces). Light mode only. Supporting neutrals (text, borders, error) are derived in `design.md`.
- Typography: FiraGO (OFL, Latin + Georgian incl. Mtavruli) in Regular, Medium and Bold. Fonts are subset to Latin + Georgian, self-hosted as WOFF2 in `fonts/`, and use tabular figures for numbers.
- Layout: keep the single page. A slim top bar holds the language toggle. Calculators show as cards, one column on phones and two columns on wide screens.
- Readable results: the calculated value and unit are large and in the accent colour, the working lines are smaller and muted, and errors and notices are visually distinct.
- Re-add a small set of `class` attributes in Elm views only where element selectors are not enough (result value, unit, working, error, notice, toggle). Most styling uses element selectors.
- Deploy: copy `styles.css` and `fonts/` into the GitHub Pages output again.
- No changes to calculator logic, inputs, navigation, or translations.

Out of scope: dark mode, navigation, bringing back the title heading or disclaimer, and graphical syringe or tablet visuals.

## Capabilities

### New Capabilities

<!-- None. -->

### Modified Capabilities

- `calculator-page`: remove "Unstyled presentation" and add requirements for the visual theme, typography, responsive layout, and result presentation.

## Impact

- **New files**: `styles.css`, `fonts/FiraGO-{Regular,Medium,Bold}.woff2`, `fonts/OFL.txt`.
- **Code**: `index.html` (stylesheet link, font preload), `src/Main.elm`, `src/Calculators/Card.elm`, `src/Calculators/Label.elm`, `src/Calculators/Nutrition.elm`, `src/FormFields.elm`, `src/Functions.elm` (a few classes).
- **CI**: `.github/workflows/build-and-deploy.yml` copies `styles.css` and `fonts/` into `dist/`.
- **Tooling**: none permanent. Font subsetting is a one-off step with `fonttools` in a throwaway virtualenv, and the subset files are committed.
- **Docs**: README project structure mentions `styles.css` and `fonts/`.
- **Tests**: unaffected (logic only).
