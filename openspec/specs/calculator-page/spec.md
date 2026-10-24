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

### Requirement: Colour theme
The page SHALL use `#F4F5FF` as the page background and `#0014FF` as the accent colour for primary buttons, focus indicators, and calculated result values. All text and interactive elements MUST meet a WCAG 2.1 AA contrast ratio against their background.

#### Scenario: Page colours
- **WHEN** the page loads
- **THEN** the page background is `#F4F5FF` and the Calculate buttons are filled with `#0014FF` with white text

#### Scenario: Keyboard focus
- **WHEN** a user moves keyboard focus to an input or button
- **THEN** a visible focus indicator in `#0014FF` surrounds it

#### Scenario: Contrast
- **WHEN** any text or control is checked against its background
- **THEN** the contrast ratio is at least 4.5:1 for body text and 3:1 for large text and control borders

### Requirement: Typography
The page SHALL render Georgian and Latin text in the FiraGO font loaded from the site itself, with a sans-serif system font fallback. Numbers in inputs and results MUST use tabular figures.

#### Scenario: Georgian text
- **WHEN** the page is shown in Georgian
- **THEN** headings, labels, buttons, and results render in FiraGO

#### Scenario: Font unavailable
- **WHEN** the font files fail to load
- **THEN** the page remains readable in a sans-serif system font

#### Scenario: No third-party font requests
- **WHEN** the page loads
- **THEN** font files are requested only from the app's own origin

### Requirement: Responsive layout
The page SHALL show each calculator as a separate card, in one column on narrow screens and two columns on wide screens, with no horizontal scrolling at 320 px width or wider.

#### Scenario: Phone width
- **WHEN** the viewport is 375 px wide
- **THEN** the calculators are stacked in one column and the page does not scroll horizontally

#### Scenario: Desktop width
- **WHEN** the viewport is 1280 px wide
- **THEN** the calculators are arranged in two columns

### Requirement: Result presentation
A calculated result SHALL show its value and unit prominently in the accent colour, with the working lines in smaller muted text; input errors and clinical notices MUST be visually distinct from results and from each other. Results remain text, with no syringe or tablet graphics.

#### Scenario: Successful result
- **WHEN** a calculator shows a result
- **THEN** the value is larger than the body text and coloured `#0014FF`, and the working lines are smaller than the body text

#### Scenario: Input error
- **WHEN** a calculator shows an input error
- **THEN** it is styled as an error and is distinct from a result

#### Scenario: Clinical notice
- **WHEN** the free water deficit calculator shows that sodium is not elevated
- **THEN** it is styled as a notice and is distinct from both a result and an error
