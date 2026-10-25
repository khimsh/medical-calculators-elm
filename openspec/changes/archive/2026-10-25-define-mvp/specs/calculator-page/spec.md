# Spec Delta

## MODIFIED Requirements

### Requirement: Browser tab title
The document title SHALL be the localized app title, and no visible title heading SHALL be rendered on the page. The testing-only banner required by `mvp-release` MAY be shown; it is not a title heading.

#### Scenario: Title in English
- **WHEN** the language is English
- **THEN** the browser tab title is "Medical Calculators" and no heading with that text appears in the page body
