# Spec Delta

## Purpose

Calculates a total dose in mg from a dose per kilogram (mg/kg) and a body weight (kg). It shows the dose and its working, with no maximum-dose cap or dosing advice.

## ADDED Requirements

### Requirement: Weight-based dose inputs
The weight-based dose calculator SHALL have a dose per kg field in mg/kg and a weight field in kg. Both MUST be number fields with no placeholder. Both fields MUST start empty.

#### Scenario: Initial state
- **WHEN** the weight-based dose calculator is first shown
- **THEN** the dose per kg and weight fields are empty, and a hint is shown in place of a result

#### Scenario: Reset clears the inputs
- **WHEN** the user has entered a dose per kg and a weight, calculated, and then presses Reset
- **THEN** both fields are empty and no result is shown

### Requirement: Weight-based dose calculation
On Calculate with valid inputs, the calculator SHALL show the total dose in mg as the main result value. The dose is the dose per kg multiplied by the weight, rounded to at most two decimal places and shown without trailing zeros.

#### Scenario: Whole number result
- **WHEN** the user enters 15 mg/kg and 70 kg and presses Calculate
- **THEN** the dose shown is 1050 mg

#### Scenario: Decimal result
- **WHEN** the user enters 2.5 mg/kg and 12.3 kg and presses Calculate
- **THEN** the dose shown is 30.75 mg

#### Scenario: Rounding
- **WHEN** the user enters 0.015 mg/kg and 4.2 kg and presses Calculate
- **THEN** the dose shown is 0.06 mg

### Requirement: Weight-based dose working
The result SHALL show the working for the dose, using the user's own dose per kg and weight, in the form dose mg/kg × weight kg.

#### Scenario: Working line
- **WHEN** the user calculates 15 mg/kg and 70 kg
- **THEN** the working shows 15 mg/kg × 70 kg

### Requirement: No dosing guidance is shown
The calculator MUST NOT show a maximum dose, a dose limit warning, or a dosing recommendation. Its only result is the calculated dose and its working.

#### Scenario: Result contents
- **WHEN** a weight-based dose result is shown
- **THEN** the result contains only the dose value and its working

#### Scenario: Large dose
- **WHEN** the user enters 100 mg/kg and 150 kg and presses Calculate
- **THEN** the dose shown is 15000 mg and no warning is shown

### Requirement: Weight-based dose input validation
The calculator MUST NOT show a result when an input is invalid. An empty or non-numeric dose per kg or weight MUST show the invalid inputs error, and a dose per kg or weight of zero or less MUST show the values must be greater than zero error.

#### Scenario: Empty weight
- **WHEN** the user enters 15 mg/kg, leaves weight empty, and presses Calculate
- **THEN** the invalid inputs error is shown and no dose is shown

#### Scenario: Non-numeric dose per kg
- **WHEN** the user enters "abc" as the dose per kg and 70 kg as weight, then presses Calculate
- **THEN** the invalid inputs error is shown and no dose is shown

#### Scenario: Zero dose per kg
- **WHEN** the user enters 0 mg/kg and 70 kg and presses Calculate
- **THEN** the values must be greater than zero error is shown and no dose is shown

#### Scenario: Negative weight
- **WHEN** the user enters 15 mg/kg and -70 kg and presses Calculate
- **THEN** the values must be greater than zero error is shown

### Requirement: Stale results are cleared
Changing the dose per kg or the weight after a calculation SHALL clear the shown result and any error until the user presses Calculate again.

#### Scenario: Changing the weight
- **WHEN** a result is shown and the user changes the weight
- **THEN** the result is cleared and the hint is shown

#### Scenario: Changing the dose per kg after an error
- **WHEN** an error is shown and the user changes the dose per kg
- **THEN** the error is cleared and the hint is shown

### Requirement: Weight-based dose texts are bilingual
All labels, units, errors, the formula line, and the working of the calculator SHALL be shown in the current language, Georgian or English.

#### Scenario: English labels
- **WHEN** the language is English
- **THEN** the card is titled "Weight-based dose", and its fields are labelled "Dose per kg (mg/kg)" and "Weight (kg)"

#### Scenario: Switching language keeps the result
- **WHEN** a result is shown and the user switches language
- **THEN** the same dose is shown with its unit and working in the new language
