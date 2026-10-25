# Spec Delta

## Purpose

Calculates body surface area (BSA) in m² from height and weight, using the Mosteller formula. It shows the BSA and its working, and no dose.

## ADDED Requirements

### Requirement: Body surface area inputs
The body surface area calculator SHALL have a height field in cm and a weight field in kg. Both MUST be number fields with no placeholder. Both fields MUST start empty.

#### Scenario: Initial state
- **WHEN** the body surface area calculator is first shown
- **THEN** the height and weight fields are empty, and a hint is shown in place of a result

#### Scenario: Reset clears the inputs
- **WHEN** the user has entered height and weight, calculated, and then presses Reset
- **THEN** both fields are empty and no result is shown

### Requirement: Body surface area calculation
On Calculate with valid inputs, the calculator SHALL show the BSA in m² as the main result value. BSA is the square root of height in cm multiplied by weight in kg, divided by 3600, rounded to two decimal places.

#### Scenario: Average adult
- **WHEN** the user enters 170 cm and 70 kg and presses Calculate
- **THEN** the BSA shown is 1.82 m²

#### Scenario: Whole number result
- **WHEN** the user enters 180 cm and 80 kg and presses Calculate
- **THEN** the BSA shown is 2.00 m²

#### Scenario: Rounding
- **WHEN** the user enters 160 cm and 50 kg and presses Calculate
- **THEN** the BSA shown is 1.49 m²

### Requirement: Body surface area working
The result SHALL show the working for the BSA, using the user's own height and weight, in the form √(height cm × weight kg ÷ 3600).

#### Scenario: Working line
- **WHEN** the user calculates 170 cm and 70 kg
- **THEN** the working shows √(170 cm × 70 kg ÷ 3600)

### Requirement: No dose is shown
The calculator MUST NOT show a dose, a dosing recommendation, or a maximum dose. Its only result is the BSA and its working.

#### Scenario: Result contents
- **WHEN** a BSA result is shown
- **THEN** the result contains only the BSA value and its working

### Requirement: Body surface area input validation
The calculator MUST NOT show a result when an input is invalid. An empty or non-numeric height or weight MUST show the invalid inputs error, and a height or weight of zero or less MUST show the values must be greater than zero error.

#### Scenario: Empty weight
- **WHEN** the user enters 170 cm, leaves weight empty, and presses Calculate
- **THEN** the invalid inputs error is shown and no BSA is shown

#### Scenario: Non-numeric height
- **WHEN** the user enters "tall" as height and 70 kg as weight, then presses Calculate
- **THEN** the invalid inputs error is shown and no BSA is shown

#### Scenario: Zero height
- **WHEN** the user enters 0 cm and 70 kg and presses Calculate
- **THEN** the values must be greater than zero error is shown and no BSA is shown

#### Scenario: Negative weight
- **WHEN** the user enters 170 cm and -70 kg and presses Calculate
- **THEN** the values must be greater than zero error is shown

### Requirement: Stale results are cleared
Changing the height or weight after a calculation SHALL clear the shown result and any error until the user presses Calculate again.

#### Scenario: Changing the height
- **WHEN** a result is shown and the user changes the height
- **THEN** the result is cleared and the hint is shown

### Requirement: Body surface area texts are bilingual
All labels, units, errors, the formula line, and the working of the calculator SHALL be shown in the current language, Georgian or English.

#### Scenario: English labels
- **WHEN** the language is English
- **THEN** the card is titled "Body surface area", and its fields are labelled "Height (cm)" and "Weight (kg)"

#### Scenario: Switching language keeps the result
- **WHEN** a result is shown and the user switches language
- **THEN** the same BSA is shown with its unit and working in the new language
