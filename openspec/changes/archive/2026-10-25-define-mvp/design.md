# Design

## Context

The five MVP calculators are already built and tested, and each has a formula source in `FORMULAS.md`. CI (`.github/workflows`) runs `npm ci`, `npm run build:prod`, and deploys `index.html`, `elm-app.js`, and `styles.css` to GitHub Pages. `npm test` runs `elm-test` over `tests/`. The project context in `openspec/config.yaml` already requires bilingual strings in `src/Translations.elm`, a testing-only app, and no new npm packages.

The gap is documentation and a written gate, not code. `README.md` predates the IV infusion rate, favorites, and categories. `TEST_SETUP.md` describes an install step that is no longer needed.

## Goals / Non-Goals

**Goals:**
- Record the MVP calculator set and the release gate as one spec the team can check against.
- Bring `README.md` and `TEST_SETUP.md` in line with the shipped app.
- Keep the gate to commands that already exist (`npm test`, `npm run build`).

**Non-Goals:**
- Adding a release tool or a changelog generator. Versioning uses the existing `package.json` field and plain git tags.
- Changing CI or the deploy workflow.
- Writing new tests for the calculators. Calculator coverage is already a per-calculator task.

## Decisions

**Define MVP as the built set, not the checklist.** The alternative was to pick a subset of the checklist (for example, BSA and weight-based dose) as the first release. That would add formula work and a new source-review step before anything can ship. The built set already has tests, sources, and bilingual text, so it is the smallest release that is actually ready.

**Put the gate in a new `mvp-release` capability, not in `calculator-page`.** The gate covers build, docs, and translations, which are not page behavior. Keeping it separate means `calculator-page` stays about what the page shows, and the gate can grow without editing UI requirements.

**Reuse `npm test` and `npm run build` as the gate.** These already run in CI. A separate checklist script would duplicate them and drift. The gate spec names the commands rather than re-describing them.

**Check documentation with the spec's scenarios, by hand.** A script that diffs the README against `src/` and `tests/` was considered. It is more machinery than the gate needs for a project this size, and the README changes rarely. Revisit if the module count keeps growing.

**Show the testing-only banner above the calculators on both pages.** The earlier removal of the disclaimer was for layout, not because a notice is unwanted, so the banner comes back in a new form. It sits once above the calculators, so it is seen on arrival and on the Favorites page too. It is not a modal, which would block use of the page.

**Banner text is the earlier disclaimer without its last sentence.** The old text ended with "consult healthcare professionals". The project context forbids patient-facing guidance text, so that sentence is left out. The rest stays: testing only, in development, do not use for clinical decisions.

**Banner style is its own.** It uses a white surface with a 4px orange edge on the left and a soft shadow, which is not the amber `.notice`, the red `.error`, or the blue-filled `.result`. Results, errors and clinical notices must stay distinct from it, per the `calculator-page` result requirement.

**Use Semantic Versioning, with `package.json` as the single source.** Breaking changes to calculator inputs or formulas matter to testers, and SemVer signals them. A date-based scheme (CalVer) would hide them. `package.json` already has a `version` field, starting at `1.0.0`, and Elm's `elm.json` has no app version, so a separate version file would only duplicate it.

**Record each release as a git tag `vX.Y.Z` plus a hand-written `CHANGELOG.md` entry.** Tags are the release record, and the changelog is what testers read. The gate checks that the tag and `package.json` match, so the two cannot drift silently. Tags do not trigger the existing deploy workflow, which runs on pushes to `main`, so CI is unchanged.

## Risks / Trade-offs

- **[Bilingual drift]** A string added without its Georgian or English pair passes the build, because Elm checks types, not translation completeness. → Mitigation: the release check reviews `src/Translations.elm` for both languages. A future test could assert every key has both values; that is out of scope here.
- **[Documentation drift again]** The README went stale within a few changes. → Mitigation: `mvp-release` makes the README match a stated requirement, so a stale README fails the gate rather than going unnoticed.
- **[Banner read as a result or clinical notice]** A testing banner that looks like a result, error, or clinical notice could be mistaken for one. → Mitigation: the banner has its own style and the `calculator-page` result requirement is unchanged.
- **[Manual version drift]** A bump in `package.json` can be forgotten, or a tag can be made without one. → Mitigation: the `Versioned releases` requirement blocks the release until the tag and `package.json` match.

## Migration Plan

No data or runtime migration. Steps:
1. Update `README.md` (features, test coverage, project structure) and remove or replace the stale status in `TEST_SETUP.md`.
2. Run `npm test` and `npm run build` on the resulting commit.
3. Check the `mvp-release` scenarios by hand, then archive the change, which syncs the new spec into `openspec/specs/mvp-release/spec.md`.

Rollback is a revert of the documentation commit. No behavior changes.

## Open Questions

- Should the version number be visible in the page? The default is no. Showing it would change the `calculator-page` requirements, so it needs the same decision as the testing-only notice.
