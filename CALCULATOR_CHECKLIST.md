# Calculator Checklist

Formula-based calculators to add, in priority order. Formulas come from [FORMULAS.md](FORMULAS.md).

Sources listed here are **proposed** until they are confirmed in each calculator's own change.

## How to use

1. Pick the top unchecked item.
2. Run `/opsx:propose` with it.
3. Confirm the formula source in that proposal.
4. Tick the item's box as part of that change.

## Done

- [x] Pills (dosage calculation: desired / available × quantity)
- [x] Liquids (dosage calculation for liquid medication)
- [x] IV infusion rate (pump rate in mL/h and drip rate in drops/min)
- [x] Free water deficit
- [x] Nutrition
- [x] Body surface area (BSA)
- [x] Weight-based dose

## To do

### Nutrition

- [ ] 3. Body mass index (BMI)
  - **Formula:** weight kg / (height m)²
  - **Inputs:** weight (kg), height (cm)
  - **Category:** Nutrition
  - **Proposed source:** WHO BMI definition
  - **Notes:** Reuse `Functions.calculateBMI`.

### Fluids & electrolytes

- [ ] 4. Maintenance fluid (4-2-1 rule)
  - **Formula:** 4 mL/kg/h for the first 10 kg, 2 mL/kg/h for the next 10 kg, 1 mL/kg/h for each kg above 20
  - **Inputs:** weight (kg)
  - **Category:** Fluids & electrolytes
  - **Proposed source:** Holliday & Segar, Pediatrics 1957;19:823
  - **Notes:** None.
- [ ] 5. Anion gap
  - **Formula:** Na⁺ − (Cl⁻ + HCO₃⁻)
  - **Inputs:** sodium, chloride, bicarbonate (mEq/L)
  - **Category:** Fluids & electrolytes
  - **Proposed source:** Emmett & Narins, Medicine 1977;56:38
  - **Notes:** Albumin correction is out of scope.
- [ ] 6. Corrected calcium
  - **Formula:** measured Ca + 0.8 × (4 − albumin)
  - **Inputs:** calcium, albumin
  - **Category:** Fluids & electrolytes
  - **Proposed source:** Payne et al., BMJ 1973;4:643
  - **Notes:** Units still to decide: mg/dL with g/dL, or mmol/L with g/L.
- [ ] 7. Corrected sodium for hyperglycaemia
  - **Formula:** Na + k × (glucose − 100) / 100
  - **Inputs:** sodium (mEq/L), glucose
  - **Category:** Fluids & electrolytes
  - **Proposed source:** Katz, NEJM 1973;289:843 (k = 1.6); Hillier et al., Am J Med 1999;106:399 (k = 2.4)
  - **Notes:** Still to decide: the value of k, and glucose units (mg/dL or mmol/L).
- [ ] 8. Parkland formula
  - **Formula:** 4 mL × weight kg × %TBSA burned; half in the first 8 hours
  - **Inputs:** weight (kg), %TBSA burned
  - **Category:** Fluids & electrolytes
  - **Proposed source:** Baxter & Shires, Ann NY Acad Sci 1968;150:874
  - **Notes:** %TBSA is entered directly, since Rule of Nines is deferred.
- [ ] 9. Fluid balance
  - **Formula:** intake − output
  - **Inputs:** total intake (mL), total output (mL)
  - **Category:** Fluids & electrolytes
  - **Proposed source:** Arithmetic definition
  - **Notes:** Might be too trivial to build.

### Cardiac & hemodynamic (new category)

- [ ] 10. Mean arterial pressure (MAP)
  - **Formula:** (2 × diastolic + systolic) / 3
  - **Inputs:** systolic and diastolic pressure (mmHg)
  - **Category:** Cardiac & hemodynamic (new)
  - **Proposed source:** Klabunde, *Cardiovascular Physiology Concepts*
  - **Notes:** Adds a new category.
- [ ] 11. Cardiac output
  - **Formula:** heart rate × stroke volume
  - **Inputs:** heart rate (beats/min), stroke volume (mL)
  - **Category:** Cardiac & hemodynamic (new)
  - **Proposed source:** Klabunde, *Cardiovascular Physiology Concepts*
  - **Notes:** Result in L/min.

### Renal (new category)

- [ ] 12. Creatinine clearance (Cockcroft-Gault)
  - **Formula:** (140 − age) × weight / (72 × serum creatinine), × 0.85 if female
  - **Inputs:** age (years), weight (kg), serum creatinine, sex
  - **Category:** Renal (new)
  - **Proposed source:** Cockcroft & Gault, Nephron 1976;16:31
  - **Notes:** Still to decide: which weight to use (actual or ideal), and creatinine units.
- [ ] 13. eGFR (CKD-EPI 2021)
  - **Formula:** CKD-EPI 2021 creatinine equation (race-free)
  - **Inputs:** serum creatinine, age (years), sex
  - **Category:** Renal (new)
  - **Proposed source:** Inker et al., NEJM 2021;385:1737
  - **Notes:** Chosen over MDRD, which is older and not current practice.

### Respiratory (new category)

- [ ] 14. Ventilator tidal volume
  - **Formula:** 6–8 mL/kg × ideal body weight (Devine)
  - **Inputs:** height (cm), sex
  - **Category:** Respiratory (new)
  - **Proposed source:** ARDS Network, NEJM 2000;342:1301; Devine, Drug Intell Clin Pharm 1974;8:650
  - **Notes:** Needs height and sex to get ideal body weight.
- [ ] 15. A–a gradient
  - **Formula:** FiO₂ × (Patm − 47) − PaCO₂ / 0.8 − PaO₂
  - **Inputs:** FiO₂, PaCO₂ (mmHg), PaO₂ (mmHg)
  - **Category:** Respiratory (new)
  - **Proposed source:** Alveolar gas equation (cite physiology text)
  - **Notes:** Default Patm is 760 mmHg.

### Pediatrics (new category)

- [ ] 16. Pediatric weight estimate
  - **Formula:** (age in years × 2) + 8
  - **Inputs:** age (years)
  - **Category:** Pediatrics (new)
  - **Proposed source:** APLS manual
  - **Notes:** Valid only for ages 1–10.
- [ ] 17. Uncuffed ET tube size
  - **Formula:** age / 4 + 4
  - **Inputs:** age (years)
  - **Category:** Pediatrics (new)
  - **Proposed source:** Cole formula (cite in change)
  - **Notes:** For ages 2 and up.

### Obstetrics (new category)

- [ ] 18. Estimated due date (Naegele's rule)
  - **Formula:** last menstrual period + 280 days
  - **Inputs:** date of last menstrual period
  - **Category:** Obstetrics (new)
  - **Proposed source:** Naegele's rule
  - **Notes:** Needs a new date field in `FormFields`.

## Deferred

- **Scoring systems.** These need a separate item-picker pattern: Glasgow Coma Scale, APGAR, CURB-65, CHA₂DS₂-VASc, HAS-BLED, Wells criteria, CHADS₂, HEART score, TIMI score, qSOFA, Bishop score.
- **Lookup tables, not formulas:** Rule of Nines, opioid equianalgesic doses, steroid conversion equivalents, insulin sliding scales and correction factors, normal vital sign ranges by age.
- **Formula not specified in FORMULAS.md:** estimated fetal weight, oxygen saturation calculations and FiO₂ adjustments.
- **Not a calculation:** sodium correction rate, which is a rate limit rather than a formula.
