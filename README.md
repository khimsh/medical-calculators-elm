# Medical Calculators - Elm Implementation

A medical calculator application built with Elm for calculating pill dosages and liquid medication dosages.

## Features

- **Pill Dosage Calculator**: Calculate the number of tablets needed based on prescribed amount and tablet strength
- **Liquid Dosage Calculator**: Calculate the volume of liquid medication needed based on prescribed amount, concentration, and available volume

## Running the Application

1. Install dependencies:
   ```bash
   elm install
   ```

2. Compile the application:
   ```bash
   elm make src/Main.elm --output elm-app.js
   ```

3. Open `Index.html` in your browser

## Running Tests

The project includes comprehensive tests to verify calculator correctness.

### Install Test Dependencies

First, install the test dependencies:
```bash
elm install elm-explorations/test
```

When prompted, answer "n" (no) to keep it in test-dependencies.

### Run Tests

To run the tests, you have two options:

#### Option 1: Using elm-test (Recommended)

1. Install elm-test globally:
   ```bash
   npm install -g elm-test
   ```

2. Run the tests:
   ```bash
   elm-test
   ```

#### Option 2: Using Test Runner HTML

1. Compile the test runner:
   ```bash
   elm make tests/TestRunner.elm --output tests.html
   ```

2. Open `tests.html` in your browser to see the test results

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
│   ├── Main.elm          # Main application code
│   └── Functions.elm     # Utility functions
├── tests/
│   ├── FunctionsTests.elm # Tests for utility functions
│   ├── MainTests.elm      # Tests for calculator logic
│   └── TestRunner.elm    # Test runner
├── styles.css            # Application styles
├── Index.html            # HTML entry point
└── elm.json             # Elm project configuration
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
