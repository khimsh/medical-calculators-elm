# Spec Delta

## MODIFIED Requirements

### Requirement: All calculators on one page
The app SHALL render the Pills, Liquids, Nutrition, Free water deficit, and IV infusion rate calculators together on the All calculators page, in that order. The All calculators page MUST be shown for the app root URL and for every URL hash other than `#favorites`.

#### Scenario: Opening the app
- **WHEN** the user opens the app root URL
- **THEN** all five calculators are visible on the page, in the order Pills, Liquids, Nutrition, Free water deficit, IV infusion rate

#### Scenario: Opening a legacy hash URL
- **WHEN** the user opens a URL ending in `#pills`, `#liquids`, `#nutrition`, or `#free-water-deficit`
- **THEN** the All calculators page with all five calculators is shown

### Requirement: Calculators operate independently
Each calculator SHALL keep its own inputs and result; entering values, calculating, or resetting one calculator MUST NOT change any other calculator.

#### Scenario: Calculating in one calculator
- **WHEN** the user calculates a Pills result
- **THEN** the Liquids, Nutrition, Free water deficit, and IV infusion rate inputs and results are unchanged

#### Scenario: Resetting one calculator
- **WHEN** the user presses Reset in the Nutrition calculator
- **THEN** only the Nutrition inputs and result are cleared

#### Scenario: Calculating an infusion rate
- **WHEN** the user calculates an IV infusion rate result
- **THEN** the Pills, Liquids, Nutrition, and Free water deficit inputs and results are unchanged

## ADDED Requirements

### Requirement: IV infusion rate can be a favorite
The IV infusion rate calculator SHALL have a favorite toggle like the other calculators. Favorites saved before this calculator existed MUST still load unchanged.

#### Scenario: Favoriting the infusion calculator
- **WHEN** the user presses the favorite toggle on the IV infusion rate calculator and opens the Favorites page
- **THEN** the IV infusion rate calculator is shown there

#### Scenario: Older stored favorites
- **WHEN** the stored favorites list only Pills and Nutrition
- **THEN** the app loads with Pills and Nutrition as favorites and IV infusion rate is not a favorite
