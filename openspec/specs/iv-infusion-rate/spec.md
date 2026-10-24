# iv-infusion-rate Specification

## Purpose

Calculates the rate at which an IV infusion runs from its volume and duration. It gives the pump rate in mL/h and the gravity drip rate in drops/min for a chosen giving set.

## Requirements

### Requirement: Infusion rate inputs
The IV infusion rate calculator SHALL have a volume field in mL, a duration field, a duration unit choice of Hours or Minutes, and a drop factor choice of 10, 15, 20 or 60 drops/mL. The unit and drop factor choices MUST be option buttons, with Hours and 20 drops/mL selected by default.

#### Scenario: Initial state
- **WHEN** the IV infusion rate calculator is first shown
- **THEN** the volume and duration fields are empty, Hours is selected, 20 drops/mL is selected, and a hint is shown in place of a result

#### Scenario: Reset restores defaults
- **WHEN** the user has entered values, chosen Minutes and 60 drops/mL, calculated, and then presses Reset
- **THEN** the fields are empty, Hours and 20 drops/mL are selected, and no result is shown

### Requirement: Pump rate
On Calculate with valid inputs, the calculator SHALL show the pump rate in mL/h as the main result value: volume ÷ duration in hours, rounded to one decimal place. A duration entered in minutes MUST be converted to hours by dividing it by 60.

#### Scenario: Duration in hours
- **WHEN** the user enters 1000 mL over 8 Hours and presses Calculate
- **THEN** the pump rate shown is 125 mL/h

#### Scenario: Duration in minutes
- **WHEN** the user enters 100 mL over 30 Minutes and presses Calculate
- **THEN** the pump rate shown is 200 mL/h

#### Scenario: Rounding
- **WHEN** the user enters 1000 mL over 7 Hours and presses Calculate
- **THEN** the pump rate shown is 142.9 mL/h

### Requirement: Drip rate
The same calculation SHALL show the gravity drip rate in drops/min as a second result line: volume × drop factor ÷ duration in minutes, rounded to the nearest whole drop, with halves rounded up.

#### Scenario: Default drop factor
- **WHEN** the user enters 1000 mL over 8 Hours with 20 drops/mL and presses Calculate
- **THEN** the drip rate shown is 42 drops/min

#### Scenario: Other drop factor
- **WHEN** the user enters 500 mL over 4 Hours with 15 drops/mL and presses Calculate
- **THEN** the drip rate shown is 31 drops/min

#### Scenario: Micro-drip set
- **WHEN** the user enters 250 mL over 3 Hours with 60 drops/mL and presses Calculate
- **THEN** the drip rate shown is 83 drops/min

### Requirement: Result working
The result SHALL show the working for both rates, using the user's own numbers, the duration converted to the needed unit, and the chosen drop factor.

#### Scenario: Working lines
- **WHEN** the user calculates 1000 mL over 8 Hours with 20 drops/mL
- **THEN** the working shows 1000 mL ÷ 8 h for the pump rate and 1000 mL × 20 ÷ 480 min for the drip rate

### Requirement: Infusion rate input validation
The calculator MUST NOT show a result when an input is invalid. An empty or non-numeric volume or duration MUST show the invalid inputs error, and a volume or duration of zero or less MUST show the values must be greater than zero error.

#### Scenario: Empty duration
- **WHEN** the user enters 500 mL, leaves duration empty, and presses Calculate
- **THEN** the invalid inputs error is shown and no rates are shown

#### Scenario: Zero duration
- **WHEN** the user enters 500 mL over 0 Hours and presses Calculate
- **THEN** the values must be greater than zero error is shown and no rates are shown

#### Scenario: Negative volume
- **WHEN** the user enters -100 mL over 2 Hours and presses Calculate
- **THEN** the values must be greater than zero error is shown

### Requirement: Stale results are cleared
Changing any input or choice after a calculation SHALL clear the shown result and any error until the user presses Calculate again.

#### Scenario: Changing the drop factor
- **WHEN** a result is shown and the user selects 60 drops/mL
- **THEN** the result is cleared and the hint is shown

### Requirement: Infusion rate texts are bilingual
All labels, option texts, units, errors and the formula line of the calculator SHALL be shown in the current language, Georgian or English.

#### Scenario: English labels
- **WHEN** the language is English
- **THEN** the card is titled "IV infusion rate" and the options read Hours, Minutes, and 10, 15, 20, 60 drops/mL

#### Scenario: Switching language keeps the result
- **WHEN** a result is shown and the user switches language
- **THEN** the same rates are shown with their labels and units in the new language
