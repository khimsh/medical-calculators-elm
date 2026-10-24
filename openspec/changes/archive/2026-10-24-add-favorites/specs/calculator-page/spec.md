# Spec Delta

## MODIFIED Requirements

### Requirement: All calculators on one page
The app SHALL render the Pills, Liquids, Nutrition, and Free water deficit calculators together on the All calculators page, in that order. The All calculators page MUST be shown for the app root URL and for every URL hash other than `#favorites`.

#### Scenario: Opening the app
- **WHEN** the user opens the app root URL
- **THEN** all four calculators are visible on the page, in the order Pills, Liquids, Nutrition, Free water deficit

#### Scenario: Opening a legacy hash URL
- **WHEN** the user opens a URL ending in `#pills`, `#liquids`, `#nutrition`, or `#free-water-deficit`
- **THEN** the All calculators page with all four calculators is shown

### Requirement: No navigation controls
Outside the calculators' own forms, the page SHALL contain only the language toggle, a navigation with exactly two links (All and Favorites), and one favorite toggle per visible calculator. It MUST NOT contain a back link or a title link to home.

#### Scenario: Inspecting page controls
- **WHEN** the page is rendered
- **THEN** the only interactive elements outside the calculators' own forms are the language toggle, the All and Favorites links, and the favorite toggles

#### Scenario: Current page is marked
- **WHEN** the Favorites page is shown
- **THEN** the Favorites link is marked as the current page and the All link is not

## ADDED Requirements

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
