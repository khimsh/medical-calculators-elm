# calculator-inputs Specification

## Purpose

Defines how calculator number fields present themselves before the user types, so an empty field is never mistaken for an entered value.

## Requirements

### Requirement: Number fields have no placeholder
Calculator number fields SHALL NOT have a placeholder. An empty number field MUST appear blank.

#### Scenario: Initial view
- **WHEN** any calculator is first shown
- **THEN** its empty number fields are blank and none has a placeholder

#### Scenario: After reset
- **WHEN** the user enters values in a calculator and presses Reset
- **THEN** the cleared number fields are blank and none has a placeholder

#### Scenario: Language switch
- **WHEN** the user switches language while a calculator's number fields are empty
- **THEN** the fields stay blank in both Georgian and English
