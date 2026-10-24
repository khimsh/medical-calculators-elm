# Design

## Context

See proposal.md, "Why". Things about the current code that affect priority:

- `src/FormFields.elm` provides only `numberField`, `optionButtonsField` and `checkboxField`. There is no date field.
- `Categories.elm` has three categories: Medication dosing, Fluids & electrolytes, and Nutrition. `Categories.calculators` concatenated over all categories must equal `Favorites.all`, so a new calculator touches both modules.
- `Functions.calculateBMI` already exists because Nutrition uses it.
- Built: Pills, Liquids, IV infusion rate (pump rate and drip rate), Free water deficit, Nutrition.

## Goals / Non-Goals

**Goals:**
- Make each checklist entry complete enough to start that calculator's `/opsx:propose` straight from it.
- Order entries so the first ones reuse existing field types and helpers.

**Non-Goals:**
- Confirming sources clinically. The checklist records a proposed source, and the calculator's own change confirms it.
- Deciding UI layout or translations for any calculator.

## Decisions

### File and format

A plain Markdown file, `CALCULATOR_CHECKLIST.md`, with `- [ ]` / `- [x]` items under category headings. Each item has indented sub-bullets: **Formula**, **Inputs**, **Category**, **Proposed source**, **Notes**. A short **Priority** list comes first, followed by a **Done** section and a **Deferred** section.
- *Alternative:* add checkboxes to FORMULAS.md. Rejected: that file also holds deferred non-formula items and serves as the formula reference.
- *Alternative:* GitHub issues. Rejected: the project plans in OpenSpec and Markdown in the repo.

### Entries (formula-based, from FORMULAS.md)

Priority order. Earlier entries need only number or option fields and no new category.

| # | Calculator | Formula | Category | Proposed source | Notes |
|---|---|---|---|---|---|
| 1 | Body surface area | √(height cm × weight kg / 3600) | Medication dosing | Mosteller, NEJM 1987;317:1098 | Number fields only |
| 2 | Weight-based dose | dose mg/kg × weight kg | Medication dosing | Standard mg/kg dosing (cite in change) | No max-dose cap, which would be patient guidance |
| 3 | BMI | weight kg / (height m)² | Nutrition | WHO BMI definition | Reuse `Functions.calculateBMI` |
| 4 | Maintenance fluid (4-2-1) | 4/2/1 mL/kg/h by weight band | Fluids & electrolytes | Holliday & Segar, Pediatrics 1957;19:823 | — |
| 5 | Anion gap | Na − (Cl + HCO₃) | Fluids & electrolytes | Emmett & Narins, Medicine 1977;56:38 | Albumin correction out of scope |
| 6 | Corrected calcium | Ca + 0.8 × (4 − albumin) | Fluids & electrolytes | Payne et al., BMJ 1973;4:643 | Units: mg/dL + g/dL vs mmol/L + g/L |
| 7 | Corrected sodium (hyperglycaemia) | Na + k × (glucose − 100)/100 | Fluids & electrolytes | Katz, NEJM 1973;289:843 (k=1.6); Hillier, Am J Med 1999;106:399 (k=2.4) | Choose k, glucose units |
| 8 | Parkland formula | 4 mL × kg × %TBSA; half in first 8 h | Fluids & electrolytes | Baxter & Shires, Ann NY Acad Sci 1968;150:874 | %TBSA is entered, since Rule of Nines is deferred |
| 9 | Fluid balance | intake − output | Fluids & electrolytes | Arithmetic definition | Might be too trivial to build |
| 10 | Mean arterial pressure | (2 × DBP + SBP)/3 | Cardiac & hemodynamic (new) | Klabunde, *Cardiovascular Physiology Concepts* | New category |
| 11 | Cardiac output | HR × SV | Cardiac & hemodynamic (new) | Klabunde, as above | SV in mL, result in L/min |
| 12 | Creatinine clearance | (140 − age) × wt / (72 × SCr) × 0.85 if female | Renal (new) | Cockcroft & Gault, Nephron 1976;16:31 | Which weight (actual vs ideal); SCr units |
| 13 | eGFR | CKD-EPI 2021 (race-free) | Renal (new) | Inker et al., NEJM 2021;385:1737 | Chosen over MDRD, which is older and not current practice |
| 14 | Ventilator tidal volume | 6–8 mL/kg × IBW; IBW (Devine) | Respiratory (new) | ARDSNet, NEJM 2000;342:1301; Devine 1974 | Needs height and sex |
| 15 | A–a gradient | FiO₂(Patm − 47) − PaCO₂/0.8 − PaO₂ | Respiratory (new) | Alveolar gas equation (cite physiology text) | Default Patm 760 mmHg |
| 16 | Pediatric weight estimate | (age y × 2) + 8 | Pediatrics (new) | APLS manual | Valid for ages 1–10 only |
| 17 | Uncuffed ET tube size | age/4 + 4 | Pediatrics (new) | Cole formula (cite in change) | Age ≥ 2 |
| 18 | Estimated due date | LMP + 280 days | Obstetrics (new) | Naegele's rule | Needs a new date field in FormFields |

### Done

Dosage calculation (Pills, Liquids), IV pump rate, IV drip rate, Free water deficit, Nutrition.

### Deferred, with reasons

- **Scoring system** (needs a separate item-picker pattern): GCS, APGAR, CURB-65, CHA₂DS₂-VASc, HAS-BLED, Wells, CHADS₂, HEART, TIMI, qSOFA, Bishop.
- **Lookup table:** Rule of Nines, opioid equianalgesic doses, steroid equivalents, insulin sliding scales, normal vital-sign ranges.
- **Formula not specified in FORMULAS.md:** estimated fetal weight, oxygen saturation/FiO₂ adjustments.
- **Not a calculation:** sodium correction rate. It is a rate limit, not a formula.

## Risks / Trade-offs

- [Proposed sources from memory may be wrong or out of date] → Label them "proposed" in the file. Each calculator change confirms its source before writing the spec.
- [The checklist drifts from the app] → Each calculator change ticks its own item. The tasks template for a calculator change should include that step.
- [Numbering implies commitment] → Treat priority as a suggestion. Reordering is a doc edit.

## Open Questions

- Units for lab values (mg/dL vs mmol/L) in corrected calcium, corrected sodium and creatinine clearance. These are decided in each calculator's change. The checklist only flags them.
