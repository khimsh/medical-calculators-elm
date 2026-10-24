# Tasks

## 1. Fonts

- [x] 1.1 Download `FiraGO-Regular.woff2`, `FiraGO-Medium.woff2`, `FiraGO-Bold.woff2` and `OFL.txt` from `bBoxType/FiraGO` (`Fonts/FiraGO_WEB_1001/Roman/`) into a scratchpad directory; verify all four files exist and are non-empty
- [x] 1.2 In a throwaway scratchpad virtualenv, install `fonttools` and `brotli`, then subset each weight with `pyftsubset` to the unicode ranges in design.md, keeping the `tnum` feature, and output WOFF2 to `fonts/`; copy `OFL.txt` to `fonts/`; verify each subset file is under 60 KB
- [x] 1.3 Check that every character used in `src/Translations.elm` and Elm string literals in `src/` is present in the subset fonts' cmap; verify the script reports no missing characters

## 2. Stylesheet and page shell

- [x] 2.1 Create `styles.css` with the design.md tokens on `:root`, `@font-face` rules for the three weights (`font-display: swap`), base element styles, type scale, focus ring, and the classes listed in design.md; verify it parses with no errors (e.g. headless Chrome reports no stylesheet errors)
- [x] 2.2 In `index.html` add `<link rel="stylesheet" href="styles.css">` and a preload for `fonts/FiraGO-Regular.woff2`; verify both URLs load with status 200 when the page is served

## 3. Markup classes

- [x] 3.1 In `src/Main.elm` wrap the toggle in `header [ class "topbar" ]` with `class "lang-toggle"`, and wrap the four calculator views in `div [ class "calculators" ]`; verify `npm run build` succeeds
- [x] 3.2 Add the design.md classes in `src/Calculators/Card.elm`, `src/Calculators/Label.elm`, `src/FormFields.elm`, `src/Functions.elm` (`errorDisplay`), and `src/Calculators/Nutrition.elm` (`macros`); verify `npm run build` succeeds and `npm test` still passes 54 tests

## 4. Deploy and docs

- [x] 4.1 In `.github/workflows/build-and-deploy.yml` copy `styles.css` and `fonts/` into `dist/`; verify the "Prepare deployment directory" step lists both
- [x] 4.2 Update the README project structure with `styles.css` and `fonts/`; verify `grep -n "styles.css\|fonts/" README.md` finds them

## 5. Integration check

- [x] 5.1 Serve the built page and check in headless Chrome at 375 px and 1280 px: background `#F4F5FF`, Calculate buttons `#0014FF` with white text, FiraGO used for Georgian text (computed `font-family` and loaded font faces), one column at 375 px with no horizontal scroll, two columns at 1280 px, and a focus ring on a focused input; capture screenshots of both widths for review
- [x] 5.2 In the same session, trigger a result, an input error, and the Na < 140 notice; verify the result value is accent-coloured and larger than body text, and error and notice use their distinct colours; verify all font requests go to the app's own origin
