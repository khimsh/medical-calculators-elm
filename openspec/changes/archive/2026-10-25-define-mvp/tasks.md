# Tasks

## 1. Documentation

- [x] 1.1 Update the feature list in `README.md` to include the IV infusion rate calculator and describe the categories and favorites that ship
- [x] 1.2 Update the `README.md` "Test Coverage" section to cover the IV infusion rate, categories, and favorites test files
- [x] 1.3 Update the `README.md` project structure to list every module under `src/` and every test file under `tests/`, and correct the "unstyled" description of the page
- [x] 1.4 Keep the testing-only and not-for-clinical-use statement in `README.md`
- [x] 1.5 Remove or replace the "Current Status" section of `TEST_SETUP.md` with the current test command (`npm test`)

## 2. Translations

- [x] 2.1 Review `src/Translations.elm` and confirm every user-facing string has both a Georgian and an English value; list any gaps and fix them

## 3. Release gate

- [x] 3.1 Run `npm test` on the release commit and confirm it passes
- [x] 3.2 Run `npm run build` on the release commit and confirm it succeeds
- [x] 3.3 Check each `mvp-release` scenario against the release build by hand: calculator set, bilingual switch, README contents

## 4. Versioning

- [x] 4.1 Confirm the `version` field in `package.json` is `1.0.0`
- [x] 4.2 Create `CHANGELOG.md` with a 1.0.0 entry
- [x] 4.3 Before tagging, check that `package.json` `version` matches the tag to be created
- [ ] 4.4 After the release gate passes, tag the release commit `v1.0.0`

## 5. Decisions

- [x] 5.1 Decision: show a testing-only banner in the page. Implemented in section 6, with the `calculator-page` requirement changed to match

## 6. Testing-only banner

- [x] 6.1 Add a `testingBanner` string to `Strings` in `src/Translations.elm`, in English and Georgian
- [x] 6.2 Render the banner once above the calculators in `src/Main.elm`, on both the All and Favorites pages
- [x] 6.3 Style `.testing-banner` in `styles.css`: distinct from `.notice`, `.error` and `.result`, readable at 320 px
- [x] 6.4 Run `npm test` and `npm run build`
- [ ] 6.5 Check the banner in both languages at phone and desktop widths, by hand
