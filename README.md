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
- **Free Water Deficit Calculator**: Estimate the free water deficit from weight, sodium, sex and age

All calculators are shown together on a single, unstyled page with a Georgian/English language toggle.

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

- **Functions Tests**: Tests for string-to-float and float-to-string conversions
- **Pill Dosage Calculator Tests**:
  - Simple calculations
  - Decimal results
  - Edge cases (division by zero, empty inputs)
  - Large and small numbers
- **Liquid Dosage Calculator Tests**:
  - Simple calculations
  - Complex medical scenarios
  - Edge cases
  - Fractional dosages
- **Model Update Tests**: Verifies that model updates work correctly

## Project Structure

```
medical-calculators-elm/
├── src/
│   ├── Main.elm                   # Single unstyled page: language toggle + all calculators
│   ├── Functions.elm              # Utility functions
│   ├── Translations.elm           # Language translations
│   └── Calculators/
│       ├── Pills.elm              # Pill dosage calculator
│       ├── Liquids.elm            # Liquid dosage calculator
│       ├── Nutrition.elm          # Nutrition calculator
│       └── FreeWaterDeficit.elm   # Free water deficit calculator
├── tests/
│   ├── FunctionsTests.elm         # Tests for utility functions
│   ├── MainTests.elm              # Tests for calculator logic
│   └── FreeWaterDeficitTests.elm  # Tests for free water deficit calculator
├── index.html                     # HTML entry point
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
