# Spec Delta

## MODIFIED Requirements

### Requirement: Body surface area texts are bilingual
All labels, units, errors, the formula line, and the working of the calculator SHALL be shown in the current language, Georgian or English.

#### Scenario: English labels
- **WHEN** the language is English
- **THEN** the card is titled "Body surface area", and its fields are labelled "Height (cm)" and "Weight (kg)"

#### Scenario: Switching language keeps the result
- **WHEN** a result is shown and the user switches language
- **THEN** the same BSA is shown with its unit and working in the new language

#### Scenario: Unit in each language
- **WHEN** a result is shown
- **THEN** the unit is "m²" in English and "მ²" in Georgian
