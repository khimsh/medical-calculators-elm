# Proposal

## Why

Nurses set IV infusion rates many times every shift, either as mL/h for a pump or as drops/min for a gravity set. The app already covers tablet and liquid doses. An infusion rate calculator completes the set for giving medication and fluids, and the drip rate formula is already listed in FORMULAS.md.

## What Changes

- Add an **IV infusion rate** calculator card. It takes the volume (mL), the duration with a unit choice (hours or minutes), and the drop factor of the giving set (10, 15, 20 or 60 drops/mL, default 20).
- One calculation shows both results: the pump rate in mL/h as the main value, and the gravity drip rate in drops/min as a second line, each with its working.
- Inputs are checked the same way as in the other calculators: empty or non-numeric input shows "Enter valid inputs", and zero or negative values show "All values must be greater than zero".
- The calculator appears last on the All calculators page, after Free water deficit. It can be marked as a favorite like the others (favorites key `iv-infusion-rate`).
- Add all new labels to `src/Translations.elm` in Georgian and English.
- Name the formula source in FORMULAS.md under Medication Dosing & Administration.

**Formula source:**
- Pump rate (mL/h) = volume (mL) ÷ time (h).
- Drip rate (drops/min) = volume (mL) × drop factor (drops/mL) ÷ time (min).

Both are standard dosage calculation formulas (D. C. Gray Morris, *Calculate with Confidence*, Elsevier, chapter on IV flow rates). The 20 drops/mL default is the standard adult giving set (ISO 8536-4).

### Out of scope

- Weight-based or dose-based infusions (mcg/kg/min or mg/h to mL/h, for example vasopressors or heparin). These are planned as a separate change.
- Working backwards from a rate to the remaining time, or to the volume infused so far.
- Maximum-rate warnings, drug libraries, or any clinical guidance text.
- Custom drop factors beyond the four standard ones.
- Changing the order or behaviour of the existing calculators.

## Capabilities

### New Capabilities
- `iv-infusion-rate`: inputs, validation, calculation, rounding and result display of the IV infusion rate calculator.

### Modified Capabilities
- `calculator-page`: the All calculators page lists five calculators, with IV infusion rate last. The independence and favorites scenarios now include it.

## Impact

**Elm modules:**
- New: `src/Calculators/IvInfusionRate.elm`
- Changed: `src/Functions.elm` (pure rate functions), `src/Favorites.elm` (new `IvInfusionRate` variant and key), `src/Main.elm` (model, messages, card), `src/Translations.elm` (new strings in both languages)

**Tests:**
- New: `tests/IvInfusionRateTests.elm`
- Changed: `tests/FunctionsTests.elm` (rate functions), `tests/FavoritesTests.elm` (new key round-trips)

**Other files:**
- `FORMULAS.md` (formula source)
- `styles.css` only if the second result line needs styling. It should reuse the existing `.result` styles.

No new dependencies. Favorites stored under the old keys stay valid.
