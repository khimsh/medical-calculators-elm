# Tasks

## 1. Remove style files and tooling

- [x] 1.1 Delete `src/scss/`, `styles.css`, `styles.css.map`, `fonts/`, and `.stylelintrc.json`; verify with `ls` that none remain
- [x] 1.2 In `package.json` remove the `build:scss`, `watch:scss`, `watch:lint`, `watch:all`, `lint:scss`, `lint:scss:fix` scripts and the `sass`, `stylelint`, `stylelint-order`, `onchange`, `npm-run-all` devDependencies; run `npm install` and verify `package-lock.json` no longer mentions `sass` or `stylelint`
- [x] 1.3 In `.github/workflows/build-and-deploy.yml` remove the "Build SCSS" step and the `cp styles.css` / `cp -R fonts` lines; verify `grep -n "scss\|styles.css\|fonts"` on the workflow returns nothing
- [x] 1.4 In `index.html` remove the stylesheet `<link>`, both font preloads, the inline `<style>` block, and the `color-scheme` meta, keeping the base-href script, mount node, `elm-app.js`, and port subscription; verify `grep -n "style\|font" index.html` returns nothing

## 2. Collapse Main to a single page

- [x] 2.1 Rewrite `src/Main.elm` as `Browser.document`: drop `View`, `Calculator`, `parseUrl`, `calculatorToFragment`, `navKey`, `currentView`, and the `SelectCalculator`/`GoToIndex`/`LinkClicked`/`UrlChanged` messages; keep `ToggleLanguage`, the four sub-messages, and the `setLangAttribute` port
- [x] 2.2 Render `main_` containing the language toggle button followed by Pills, Liquids, Nutrition, Free water deficit views, with no `class` attributes, header, disclaimer, or title heading; verify `npm run build` succeeds and opening `index.html` (and `index.html#pills`) shows all four calculators with only the toggle above them

## 3. Strip styling from Elm views

- [x] 3.1 Remove all `class`/`style` attributes and their imports from `src/Calculators/Card.elm`, `src/FormFields.elm`, `src/Functions.elm`, and `src/Calculators/Nutrition.elm`
- [x] 3.2 In `src/Calculators/Label.elm` remove `class` attributes and delete `syringe`, `tablets`, `Barrel`, `barrels` from the module and its exports; in `Pills.elm` and `Liquids.elm` set `extra = []`
- [x] 3.3 Verify `grep -rn "class\|style" src` returns no Elm attribute uses and `npm run build` compiles with no errors

## 4. Prune translations and docs

- [x] 4.1 Remove `intro`, `back`, `backToIndex`, `disclaimer`, `pillDescription`, `liquidDescription`, `nutritionDescription`, `freeWaterDeficitDescription`, and `syringe` from the `Strings` type and both language records in `src/Translations.elm`; verify `npm run build` succeeds
- [x] 4.2 Update `README.md` project-structure section to drop `styles.css` / SCSS and describe the single-page layout; verify `grep -n "styles.css\|scss" README.md` returns nothing

## 5. Integration check

- [x] 5.1 Run `npm test` and verify all existing calculator tests pass
- [x] 5.2 Run `npm run build:prod`, open the page, and verify: no CSS/font network requests, toggle switches labels between Georgian and English and updates `<html lang>`, entered values survive a toggle, and calculating/resetting one calculator leaves the others unchanged
