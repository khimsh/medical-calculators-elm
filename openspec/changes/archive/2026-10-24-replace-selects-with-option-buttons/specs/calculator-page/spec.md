# Spec Delta

## ADDED Requirements

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
