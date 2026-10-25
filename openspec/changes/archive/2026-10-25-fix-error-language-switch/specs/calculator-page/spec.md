# Spec Delta

## MODIFIED Requirements

### Requirement: Language toggle
The page SHALL provide one button that switches all visible text between Georgian and English and updates the document's `lang` attribute to `ka` or `en`; the app MUST start in Georgian.

#### Scenario: Initial language
- **WHEN** the app loads
- **THEN** text is in Georgian and the document `lang` is `ka`

#### Scenario: Switching language
- **WHEN** the user presses the language toggle while in Georgian
- **THEN** calculator titles, field labels, and buttons are shown in English and the document `lang` becomes `en`

#### Scenario: Switching keeps entered values
- **WHEN** the user has entered values in a calculator and presses the language toggle
- **THEN** the entered values remain in their fields

#### Scenario: Switching translates a shown error
- **WHEN** a calculator shows an input error in Georgian, for example after Calculate with an empty field, and the user presses the language toggle
- **THEN** the same error is shown in English, and it is still shown as an error

#### Scenario: Switching translates the free water deficit notice
- **WHEN** the free water deficit calculator shows that sodium is not elevated, and the user presses the language toggle
- **THEN** the same notice is shown in the new language, and it is still shown as a notice, not as an error
