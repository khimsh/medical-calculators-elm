# Proposal

## Why

The app has grown from one page into a set of five calculators, favorites, categories, and a visual theme, but nothing defines what a first release must contain. Without an agreed MVP, each new calculator or polish task competes with the release, and there is no test for when the app is ready to ship. This change fixes the MVP scope and the release gate so later work can be measured against them.

## What Changes

- **MVP calculator set:** the five calculators already on the All calculators page (Pills, Liquids, IV infusion rate, Free water deficit, Nutrition) form the MVP. Items in `CALCULATOR_CHECKLIST.md` "To do" are post-MVP unless the user moves them in.
- **Release gate:** the app is releasable when every requirement in the new `mvp-release` capability holds. The gate covers the build and test pipeline, bilingual coverage, the testing-only scope notice, and accurate documentation.
- **Versioning:** releases follow Semantic Versioning. `package.json` `version` is the single version source, and each release is tagged `vX.Y.Z` in git to match it. The first release is `1.0.0`. `CHANGELOG.md` gets one entry per release.
- **Testing-only banner:** the page shows a visible testing-only banner above the calculators on both pages, in Georgian and English. This reverses the earlier removal of the disclaimer banner for this notice only. The no-title-heading rule still holds.
- **Documentation alignment:** `README.md` is brought in line with the shipped app. It currently lists four features (no IV infusion rate), describes the page as "unstyled" with no favorites or categories, and has a test-coverage list and project structure that omit the IV infusion, categories, and favorites modules and tests.
- No calculator formulas, UI behavior, or stored data change in this change.

### Assumptions

- "MVP" means the smallest set that is safe to show to testers as a first release, not a clinical release. The app stays labelled as testing-only, consistent with `README.md` and the project context.
- The MVP is defined by what is already built. No new calculators are required for release.

### Out of scope

- New calculators from `CALCULATOR_CHECKLIST.md`, including BSA, weight-based dose, BMI, and the other unchecked items.
- Scoring systems and lookup-table features listed under "Deferred" in `CALCULATOR_CHECKLIST.md`.
- Visual redesign or new themes. Only the browser-title requirement in `calculator-page` changes; its other requirements and all of `calculator-inputs` stay as they are.
- Hosting or deployment changes beyond what CI already does.
- Showing the version number in the page. It would change the `calculator-page` requirements.
- Automated version bumping or publishing.
- Clinical validation of formulas. Each formula's source is already recorded in `FORMULAS.md`; this change does not re-check them.

## Capabilities

### New Capabilities
- `mvp-release`: The release gate for the first release: the calculator set that ships, the build and test requirements, bilingual coverage, the testing-only notice, documentation accuracy, and versioning.

### Modified Capabilities
- `calculator-page`: the "Browser tab title" requirement stops banning a disclaimer banner, so the testing-only banner can be shown.

## Impact

- New spec: `openspec/specs/mvp-release/spec.md` (created when this change is archived and synced).
- `README.md`: feature list, test coverage section, and project structure updated to match the code.
- `TEST_SETUP.md`: its "Current Status" section describes a state that no longer applies. It is either removed or replaced with the current test command, as part of the documentation work.
- Code: `src/Translations.elm` (banner text in both languages), `src/Main.elm` (banner above the calculators), and `styles.css` (banner style). No new tests; the gate relies on the existing `npm test` and `npm run build`.
- Specs: `calculator-page` (modified) and `mvp-release` (new banner requirement).
- New file: `CHANGELOG.md`, starting with a 1.0.0 entry.
- `package.json`: `version` is confirmed as `1.0.0` and kept in step with the release tag.
