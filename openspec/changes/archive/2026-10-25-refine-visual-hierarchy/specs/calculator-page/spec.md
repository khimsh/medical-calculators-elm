# Spec Delta

## MODIFIED Requirements

### Requirement: Responsive layout
The page SHALL show each calculator as a separate card, in a single column at every viewport width, with no horizontal scrolling at 320 px width or wider. Each card MUST be no wider than a readable measure. The cards MUST be centred on the page, and each category heading MUST align with the left edge of its cards.

#### Scenario: Phone width
- **WHEN** the viewport is 375 px wide
- **THEN** the calculators are stacked in one column and the page does not scroll horizontally

#### Scenario: Desktop width
- **WHEN** the viewport is 1280 px wide
- **THEN** the calculators are still stacked in one column, and each card is narrower than the page

#### Scenario: Neighbouring cards
- **WHEN** two calculators have different amounts of content
- **THEN** each card's height follows its own content and does not change the height of the cards around it

## ADDED Requirements

### Requirement: Text hierarchy
Bold text (font weight 700) SHALL be used only for category headings and calculated result values. Card titles, field labels, legends, buttons, navigation links, and the testing-only banner MUST NOT use weight 700. Hierarchy between these elements SHALL be carried by size, colour, and spacing.

#### Scenario: Category heading
- **WHEN** a category heading is shown
- **THEN** it is in bold and larger than the card titles beneath it

#### Scenario: Card title and labels
- **WHEN** a card title, field label, or option button is shown
- **THEN** it is not bold and is no heavier than medium weight (500)

#### Scenario: Calculated result
- **WHEN** a calculated result value is shown
- **THEN** it is in bold and is the largest text in the card
