# Proposal

## Why

The app has accumulated a visual layer (SCSS partials, compiled CSS, web fonts, stylelint tooling, CSS-only result graphics) and a navigation layer (index of tiles, hash routing, back link, masthead) that sit on top of four small calculators. Stripping both back to plain, unstyled HTML leaves only the part that matters — the calculators — and gives a clean base to rebuild from.

## What Changes

- **BREAKING** Remove navigation: the index/tile view, `#pills` / `#liquids` / `#nutrition` / `#free-water-deficit` hash routes, the back link, and the masthead wordmark link. Old hash URLs simply load the same single page.
- All four calculators (Pills, Liquids, Nutrition, Free water deficit) render together on one page, in that order.
- Keep the Georgian/English language toggle (button + `<html lang>` sync). It becomes the only control outside the calculators.
- **BREAKING** Remove the on-page disclaimer banner and the visible app title heading. The browser tab title stays.
- Remove all styling: `src/scss/`, `styles.css`, `styles.css.map`, `fonts/`, the `<link>`/font preloads and inline `<style>` in `index.html`, `.stylelintrc.json`, and the sass/stylelint/onchange/npm-run-all dev dependencies and their npm scripts.
- Remove the "Build SCSS" step and the `styles.css`/`fonts` copies from the GitHub Pages workflow.
- Strip `class` and inline `style` attributes from Elm views; drop the CSS-only result visuals (syringe graduation drawing, tablet pips). Results still show the value, unit, extra numbers (e.g. macros) and the working lines as text.
- Remove translation strings that only served navigation or the removed banner (`intro`, `back`, `backToIndex`, `disclaimer`, the four `*Description` strings, and `syringe` if unused).
- Calculator inputs, validation, formulas, and results are unchanged.

## Capabilities

### New Capabilities

- `calculator-page`: The single page that hosts every calculator — what appears on it, in what order, and how the language toggle behaves. (Formula behavior of each calculator is out of scope and unchanged.)

### Modified Capabilities

<!-- None: openspec/specs/ is empty. -->

## Impact

- **Code**: `src/Main.elm` (rewritten: no `View`/`Calculator` routing, `Browser.application` → `Browser.document`), `src/Calculators/Card.elm`, `src/Calculators/Label.elm`, the four calculator modules, `src/FormFields.elm`, `src/Functions.elm`, `src/Translations.elm`.
- **Files deleted**: `src/scss/**`, `styles.css`, `styles.css.map`, `fonts/**`, `.stylelintrc.json`.
- **Build/CI**: `package.json` scripts and devDependencies, `package-lock.json`, `.github/workflows/build-and-deploy.yml`, `index.html`.
- **Docs**: `README.md` project structure section.
- **Tests**: Existing calculator unit tests are unaffected; any test touching removed strings or Main routing must be updated.
- **Users**: Bookmarked hash links still open the app but no longer jump to a specific calculator.
