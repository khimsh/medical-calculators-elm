# Spec Delta

## ADDED Requirements

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

## REMOVED Requirements

### Requirement: Unstyled presentation
**Reason**: The page now has a visual theme; it loads a stylesheet and a self-hosted web font, and uses class attributes for styling.
**Migration**: See the "Colour theme", "Typography", "Responsive layout", and "Result presentation" requirements. The "results as text, no syringe or tablet graphics" rule moves into "Result presentation".
