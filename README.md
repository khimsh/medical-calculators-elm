# Medical Calculators - Elm Implementation

A medical calculator application built with Elm for calculating pill dosages and liquid medication dosages.

## ⚠️ DISCLAIMER - TESTING PURPOSES ONLY

**This application is currently in development and testing phase. It is NOT intended for clinical use and should not be used to make medical decisions.**

- Do not rely on these calculations for patient care
- Always verify calculations independently
- Consult with qualified healthcare professionals before administering any medication
- This software comes with NO WARRANTY and the authors are not liable for any harm resulting from its use

---

## Features

- **Pill Dosage Calculator**: Calculate the number of tablets needed based on prescribed amount and tablet strength
- **Liquid Dosage Calculator**: Calculate the volume of liquid medication needed based on prescribed amount, concentration, and available volume
- **Nutrition Calculator**: Estimate daily calories and macronutrients from weight, height, weight loss and critical status
- **IV Infusion Rate Calculator**: Calculate the pump rate (mL/h) and the drip rate (drops/min) from volume, duration and drop factor
- **Free Water Deficit Calculator**: Estimate the free water deficit from weight, sodium, sex and age

The **All** page shows every calculator, grouped under the categories Medication dosing, Fluids & electrolytes, and Nutrition. The **Favorites** page shows the calculators you have starred, in the same grouping. A Georgian/English language toggle switches all text.

Planned calculators are tracked in [CALCULATOR_CHECKLIST.md](CALCULATOR_CHECKLIST.md).

## Running the Application

Requires Node.js and Elm 0.19.3 (installed locally through npm).

1. Install dependencies:

   ```bash
   npm install
   ```

2. Compile the application:

   ```bash
   npm run build
   ```

3. Open `index.html` in your browser

## Running Tests

The project includes comprehensive tests to verify calculator correctness.

```bash
npm test
```

## Test Coverage

The test suite includes:

- **Functions Tests**: String-to-float and float-to-string conversions, calorie, BMI, score, pump rate and drip rate calculations
- **Pill and Liquid Dosage Calculator Tests** (`MainTests.elm`):
  - Simple calculations
  - Decimal results
  - Edge cases (division by zero, empty inputs)
  - Large and small numbers
  - Complex medical scenarios and fractional dosages
- **Nutrition Calculator Tests**: Calorie and macronutrient results
- **Free Water Deficit Calculator Tests**: Deficit results and the not-elevated sodium case
- **IV Infusion Rate Calculator Tests**: Pump rate and drip rate results
- **Categories Tests**: Category order and the calculators in each category
- **Favorites Tests**: Toggling favorites and decoding the stored list

## Project Structure

```
medical-calculators-elm/
├── src/
│   ├── Main.elm                   # Page: All and Favorites views, language toggle
│   ├── Categories.elm             # Calculator categories and their order
│   ├── Favorites.elm              # Favorites: toggling and storage format
│   ├── FormFields.elm             # Shared form field helpers
│   ├── Functions.elm              # Utility functions
│   ├── Translations.elm           # Language translations
│   └── Calculators/
│       ├── Card.elm               # Card shell shared by all calculators
│       ├── Label.elm              # Result and error text
│       ├── Pills.elm              # Pill dosage calculator
│       ├── Liquids.elm            # Liquid dosage calculator
│       ├── IvInfusionRate.elm     # IV infusion rate calculator
│       ├── Nutrition.elm          # Nutrition calculator
│       └── FreeWaterDeficit.elm   # Free water deficit calculator
├── tests/
│   ├── FunctionsTests.elm         # Tests for utility functions
│   ├── MainTests.elm              # Tests for Pills and Liquids calculators
│   ├── NutritionTests.elm         # Tests for nutrition calculator
│   ├── FreeWaterDeficitTests.elm  # Tests for free water deficit calculator
│   ├── IvInfusionRateTests.elm    # Tests for IV infusion rate calculator
│   ├── CategoriesTests.elm        # Tests for categories
│   └── FavoritesTests.elm         # Tests for favorites
├── index.html                     # HTML entry point
├── styles.css                     # Theme: colours, FiraGO font, layout
├── fonts/                         # FiraGO WOFF2 subsets (Latin + Georgian, OFL)
├── package.json                   # NPM project configuration
└── elm.json                       # Elm project configuration
```

## Example Calculations

### Pill Dosage Example

- Prescribed: 100mg
- Tablet strength: 50mg
- Result: 2 tablets

### Liquid Dosage Example

- Prescribed: 200mg
- Concentration: 100mg per 5mL
- Result: 10mL
