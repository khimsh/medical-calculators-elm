# calculator-page Specification

## Purpose

Defines the single, unstyled page that hosts every medical calculator in the app, including which calculators appear, their order, and the language toggle.

## Requirements

### Requirement: All calculators on one page
The app SHALL render the Pills, Liquids, Nutrition, and Free water deficit calculators together on the All calculators page, in that order. The All calculators page MUST be shown for the app root URL and for every URL hash other than `#favorites`.

#### Scenario: Opening the app
- **WHEN** the user opens the app root URL
- **THEN** all four calculators are visible on the page, in the order Pills, Liquids, Nutrition, Free water deficit

#### Scenario: Opening a legacy hash URL
- **WHEN** the user opens a URL ending in `#pills`, `#liquids`, `#nutrition`, or `#free-water-deficit`
- **THEN** the All calculators page with all four calculators is shown

### Requirement: Calculators operate independently
Each calculator SHALL keep its own inputs and result; entering values, calculating, or resetting one calculator MUST NOT change any other calculator.

#### Scenario: Calculating in one calculator
- **WHEN** the user calculates a Pills result
- **THEN** the Liquids, Nutrition, and Free water deficit inputs and results are unchanged

#### Scenario: Resetting one calculator
- **WHEN** the user presses Reset in the Nutrition calculator
- **THEN** only the Nutrition inputs and result are cleared

### Requirement: No navigation controls
Outside the calculators' own forms, the page SHALL contain only the language toggle, a navigation with exactly two links (All and Favorites), and one favorite toggle per visible calculator. It MUST NOT contain a back link or a title link to home.

#### Scenario: Inspecting page controls
- **WHEN** the page is rendered
- **THEN** the only interactive elements outside the calculators' own forms are the language toggle, the All and Favorites links, and the favorite toggles

#### Scenario: Current page is marked
- **WHEN** the Favorites page is shown
- **THEN** the Favorites link is marked as the current page and the All link is not

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

### Requirement: Single-choice fields as option buttons
Every field where the user picks one value from a fixed list SHALL show all its options at once as a labelled group of buttons, not as a dropdown. Exactly one option MUST be selected at all times, and the selected option MUST be marked in the accent colour by more than colour alone. The group MUST be usable by keyboard and announced by screen readers with its label and the selected option.

#### Scenario: Nutrition weight loss options
- **WHEN** the Nutrition calculator is shown
- **THEN** the weight loss field shows the options None, 1-5%, 5-10%, and >10% as buttons, with None selected, and the page has no dropdown

#### Scenario: Free water deficit sex options
- **WHEN** the Free water deficit calculator is shown
- **THEN** the sex field shows Male and Female as buttons, with Male selected

#### Scenario: Choosing an option
- **WHEN** the user taps the 5-10% weight loss option
- **THEN** 5-10% becomes the only selected option and the next Nutrition calculation uses it

#### Scenario: Keyboard use
- **WHEN** a keyboard user tabs into an option group and presses the arrow keys
- **THEN** focus moves between the options with the `#0014FF` focus indicator and the focused option becomes selected

#### Scenario: Screen reader
- **WHEN** a screen reader reaches an option group
- **THEN** it announces the field label, each option's text, and which option is selected

#### Scenario: Reset restores the default
- **WHEN** the user has selected Female and presses Reset in the Free water deficit calculator
- **THEN** Male is selected again

#### Scenario: Narrow screen
- **WHEN** the viewport is 320 px wide
- **THEN** the weight loss options wrap as needed and the page does not scroll horizontally

#### Scenario: Language switch
- **WHEN** the user switches language after selecting an option
- **THEN** the option labels are shown in the new language and the same option stays selected

### Requirement: Favorite calculators
Each calculator SHALL have a favorite toggle that adds it to or removes it from the user's favorites. The toggle MUST show whether the calculator is a favorite by more than colour alone, and MUST be announced to screen readers with the calculator name and its pressed state. Favorites MUST be stored in the browser and restored when the app is opened again; missing, unreadable, or invalid stored data MUST result in no favorites without any error shown.

#### Scenario: Adding a favorite
- **WHEN** the user presses the favorite toggle on the Pills calculator
- **THEN** the toggle shows as pressed and Pills is a favorite

#### Scenario: Removing a favorite
- **WHEN** the user presses the pressed favorite toggle on the Pills calculator
- **THEN** the toggle shows as not pressed and Pills is no longer a favorite

#### Scenario: Favorites survive a reload
- **WHEN** the user has favorited Nutrition and reloads the page
- **THEN** Nutrition is still a favorite

#### Scenario: Invalid stored data
- **WHEN** the stored favorites data is not a valid list of calculators
- **THEN** the app loads normally with no favorites

#### Scenario: Language switch
- **WHEN** the user switches language
- **THEN** the favorite toggles' accessible labels are in the new language and favorites are unchanged

### Requirement: Favorites page
The app SHALL show a Favorites page at the URL hash `#favorites` that renders only the favorited calculators, in the same order as on the All calculators page. When there are no favorites, the page MUST show a hint explaining how to add one. Calculator inputs and results MUST be the same on both pages.

#### Scenario: Viewing favorites
- **WHEN** Free water deficit and Pills are favorites and the user opens the Favorites page
- **THEN** only the Pills and Free water deficit calculators are shown, in that order

#### Scenario: No favorites
- **WHEN** there are no favorites and the user opens the Favorites page
- **THEN** no calculators are shown and a hint explains how to add a favorite

#### Scenario: Unfavoriting on the Favorites page
- **WHEN** the user presses the favorite toggle of a calculator on the Favorites page
- **THEN** that calculator disappears from the Favorites page

#### Scenario: Values kept between pages
- **WHEN** the user enters values in the Pills calculator on the All calculators page and then opens the Favorites page with Pills favorited
- **THEN** the Pills calculator shows the same values
