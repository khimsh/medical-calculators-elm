# Tasks

## 1. Write the checklist

- [x] 1.1 Create `CALCULATOR_CHECKLIST.md` at the repo root with a title, a one-line note that sources are proposed until confirmed in each calculator's change, and a link to FORMULAS.md; verify the file renders as Markdown with the link resolving to `FORMULAS.md`
- [x] 1.2 Add a **Done** section with checked `- [x]` items for Pills, Liquids, IV infusion rate (pump and drip rate), Free water deficit, and Nutrition; verify it lists exactly those five, matching `Favorites.all` in `src/Favorites.elm`
- [x] 1.3 Add the 18 to-do entries from design.md "Entries" as unchecked `- [ ]` items under category headings, in priority order. Each item gets the sub-bullets Formula, Inputs, Category, Proposed source, and Notes. Verify that `grep -c '^- \[ \]' CALCULATOR_CHECKLIST.md` reports 18 and that each entry has all five sub-bullets
- [x] 1.4 Add a **Deferred** section with the items and one-line reasons from design.md "Deferred, with reasons"; verify every FORMULAS.md item appears in exactly one of Done, to-do, or Deferred
- [x] 1.5 Add a short "How to use" note: pick the top unchecked item, run `/opsx:propose` with it, confirm the source in that proposal, and tick the box in that change. Verify the note contains no patient-facing guidance text

## 2. Link and check

- [x] 2.1 Add one line to `README.md` linking to `CALCULATOR_CHECKLIST.md`; verify the link path is correct and no other README lines changed (`git diff README.md`)
- [x] 2.2 Run `git status` and verify that only `CALCULATOR_CHECKLIST.md`, `README.md`, and this change's files changed, with nothing under `src/` or `tests/`

## Workflow follow-up

- Archive the change once the checklist has been reviewed.
