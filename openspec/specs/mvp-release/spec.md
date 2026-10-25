# mvp-release Specification

## Purpose

Defines the release gate for the first release of the app: which calculators ship, what must pass before a release, and what the documentation must say. It is the reference for deciding whether the app is ready to ship.

## Requirements

### Requirement: MVP calculator set
The first release SHALL include the Pills, Liquids, IV infusion rate, Free water deficit, and Nutrition calculators and no others. Calculators listed as unchecked in `CALCULATOR_CHECKLIST.md` MUST NOT be required for the release.

#### Scenario: Release contents
- **WHEN** the release build is opened
- **THEN** exactly the five MVP calculators are shown on the All calculators page

#### Scenario: Unchecked calculator not required
- **WHEN** a calculator from the "To do" list of `CALCULATOR_CHECKLIST.md` has not been built
- **THEN** the release is not blocked by its absence

### Requirement: Build and test gate
A release SHALL NOT be made unless `npm test` and `npm run build` both complete without errors on the release commit.

#### Scenario: Passing gate
- **WHEN** `npm test` and `npm run build` are run on the release commit
- **THEN** both exit successfully

#### Scenario: Failing test
- **WHEN** any test in `npm test` fails
- **THEN** the release is blocked until the failure is fixed

### Requirement: Bilingual coverage
Every user-facing string in the release SHALL have both a Georgian and an English translation in `src/Translations.elm`. A release MUST NOT show a string in one language only.

#### Scenario: Language switch
- **WHEN** the user switches between Georgian and English on any calculator
- **THEN** no text is shown in the wrong language or left blank

#### Scenario: Missing translation
- **WHEN** a new user-facing string is added without a Georgian or an English translation
- **THEN** the release is blocked until the translation is added

### Requirement: Documentation matches the release
`README.md` SHALL list every MVP calculator in its features, SHALL describe the page as it ships, and SHALL list every module under `src/` and every test file under `tests/` in its project structure. The README MUST state that the app is for testing only and not for clinical use.

#### Scenario: Feature list
- **WHEN** the README feature list is compared with the MVP calculator set
- **THEN** the two match, with the IV infusion rate calculator included

#### Scenario: Project structure
- **WHEN** the README project structure is compared with the files in `src/` and `tests/`
- **THEN** every module and test file is listed

#### Scenario: Testing-only statement
- **WHEN** the README is read before release
- **THEN** it states that the app is for testing only and not for clinical use

### Requirement: Versioned releases
A release version SHALL follow Semantic Versioning, and the first release SHALL be `1.0.0`. The `version` field in `package.json` and the git tag `vX.Y.Z` on the release commit MUST be identical. `CHANGELOG.md` MUST contain an entry for the release version.

#### Scenario: Matching tag
- **WHEN** the release commit is tagged with the version in `package.json`
- **THEN** the release passes the version check

#### Scenario: Mismatched tag
- **WHEN** the git tag and the `package.json` version differ
- **THEN** the release is blocked until they match

#### Scenario: Missing changelog entry
- **WHEN** `CHANGELOG.md` has no entry for the release version
- **THEN** the release is blocked until the entry is added

### Requirement: Testing-only banner
The page SHALL show a testing-only banner above the calculators on the All calculators page and on the Favorites page. The banner SHALL state that the app is for testing only and is not for clinical use, in the language the page is currently shown in. Its Georgian and English text MUST both be present in `src/Translations.elm`.

#### Scenario: Banner on both pages
- **WHEN** the All calculators page or the Favorites page is shown
- **THEN** the testing-only banner appears above the calculators

#### Scenario: Banner in English
- **WHEN** the language is English
- **THEN** the banner states that the app is for testing only and not for clinical use, in English

#### Scenario: Banner in Georgian
- **WHEN** the language is Georgian
- **THEN** the banner states the same in Georgian
