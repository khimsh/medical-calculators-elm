# Proposal

## Why

FORMULAS.md lists about 35 candidate calculations in one flat list. It doesn't show which ones are built, which are plain formulas and which are scoring systems or lookup tables, or what source each one would cite. Five calculators exist now, and each new one needs a named formula source in its proposal. A checklist lets us pick the next calculator and start its change without repeating that triage each time.

## What Changes

- Add a new `CALCULATOR_CHECKLIST.md` at the repository root. It is a Markdown checklist of the **formula-based** calculators from FORMULAS.md, grouped by category and ordered by priority. Each entry gives:
  - the formula,
  - the inputs it needs,
  - the app category it would join (an existing one or a new one),
  - a proposed formula source, to be confirmed in that calculator's own change,
  - open questions (units, coefficient choice, new field types).
- Mark calculators that already exist as done: Pills and Liquids (dosage calculation), IV infusion rate (pump and drip rate), Free water deficit, and Nutrition.
- List the items left out as **Deferred** with a one-line reason each (scoring system, lookup table, or formula not specified).
- Add one line to `README.md` that links to the checklist.

### Out of scope

- Building any calculator. Each checklist item becomes its own later change, with its own spec, translations, and `tests/<Name>Tests.elm`.
- Scoring systems (GCS, APGAR, CURB-65, CHA₂DS₂-VASc, HAS-BLED, Wells, CHADS₂, HEART, TIMI, qSOFA, Bishop), lookup-table items (Rule of Nines, opioid, steroid and insulin conversions, normal vital-sign ranges), and items whose formula FORMULAS.md doesn't specify. These are listed as Deferred only.
- Editing or reorganising FORMULAS.md. It stays the list of formulas.
- Any change to `src/`, `tests/`, `styles.css`, the build, or CI.

### Assumptions

- The checklist goes in its own file so FORMULAS.md stays a formula list. Ticking an item off is a one-line edit in each calculator's change.
- The sources in the checklist are **proposed**. They are not final until the calculator's own proposal confirms them.

## Capabilities

### New Capabilities

<!-- None: docs-only change, no spec-level behavior changes (skip_specs: true). -->

### Modified Capabilities

<!-- None. -->

## Impact

- New file: `CALCULATOR_CHECKLIST.md`.
- `README.md`: one added link line.
- Elm modules changed: none. Test files changed: none.
- `npm test` and `npm run build` are unaffected.
