# calculator-page Specification

## Purpose

Defines the single, unstyled page that hosts every medical calculator in the app, including which calculators appear, their order, and the language toggle.

## Requirements

### Requirement: All calculators on one page
The app SHALL render the Pills, Liquids, Nutrition, and Free water deficit calculators together on a single page, in that order, with no index, menu, or per-calculator routes.

#### Scenario: Opening the app
- **WHEN** the user opens the app root URL
- **THEN** all four calculators are visible on the page, in the order Pills, Liquids, Nutrition, Free water deficit

#### Scenario: Opening a legacy hash URL
- **WHEN** the user opens a URL ending in `#pills`, `#liquids`, `#nutrition`, or `#free-water-deficit`
- **THEN** the same single page with all four calculators is shown

### Requirement: Calculators operate independently
Each calculator SHALL keep its own inputs and result; entering values, calculating, or resetting one calculator MUST NOT change any other calculator.

#### Scenario: Calculating in one calculator
- **WHEN** the user calculates a Pills result
- **THEN** the Liquids, Nutrition, and Free water deficit inputs and results are unchanged

#### Scenario: Resetting one calculator
- **WHEN** the user presses Reset in the Nutrition calculator
- **THEN** only the Nutrition inputs and result are cleared

### Requirement: No navigation controls
The page SHALL NOT contain navigation links or buttons, including an index of calculators, a back link, or a title link to home.

#### Scenario: Inspecting page controls
- **WHEN** the page is rendered
- **THEN** the only interactive elements outside the calculators' own forms are the language toggle button

### Requirement: Unstyled presentation
The page SHALL load no stylesheets or web fonts and SHALL render calculator elements without class or inline style attributes, relying on default browser rendering.

#### Scenario: Loading the page
- **WHEN** the page loads
- **THEN** no CSS file or font file is requested and no `<style>` element is present

#### Scenario: Viewing a result
- **WHEN** a calculator shows a result
- **THEN** the value, unit, any extra figures (such as macronutrient grams), and the working lines are shown as plain text, with no graphical syringe or tablet drawing

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

### Requirement: Browser tab title
The document title SHALL be the localized app title, and no visible title heading or disclaimer banner SHALL be rendered on the page.

#### Scenario: Title in English
- **WHEN** the language is English
- **THEN** the browser tab title is "Medical Calculators" and no heading with that text appears in the page body
