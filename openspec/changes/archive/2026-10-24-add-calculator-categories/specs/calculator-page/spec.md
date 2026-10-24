## ADDED Requirements

### Requirement: Calculator categories
Every calculator SHALL belong to exactly one category, and the categories SHALL be shown in this order: Medication dosing (Pills, Liquids, IV infusion rate), Fluids & electrolytes (Free water deficit), and Nutrition (Nutrition). Each category MUST be shown as a section with a localized heading above its calculators. That heading MUST rank one level above the calculator titles in the heading outline.

#### Scenario: Category headings in English
- **WHEN** the All calculators page is shown in English
- **THEN** the headings "Medication dosing", "Fluids & electrolytes" and "Nutrition" appear in that order, each above its own calculators

#### Scenario: Category headings in Georgian
- **WHEN** the All calculators page is shown in Georgian
- **THEN** the category headings are shown in Georgian

#### Scenario: Heading outline
- **WHEN** a screen reader lists the page headings
- **THEN** each calculator title is nested under its category heading

#### Scenario: Grid within a category
- **WHEN** the viewport is 1280 px wide
- **THEN** the calculators in each category are arranged in two columns, and each category starts on a new row below the previous one

## MODIFIED Requirements

### Requirement: All calculators on one page
The app SHALL render the Pills, Liquids, IV infusion rate, Free water deficit, and Nutrition calculators together on the All calculators page, in that order, grouped by category. The All calculators page MUST be shown for the app root URL and for every URL hash other than `#favorites`.

#### Scenario: Opening the app
- **WHEN** the user opens the app root URL
- **THEN** all five calculators are visible on the page, in the order Pills, Liquids, IV infusion rate, Free water deficit, Nutrition

#### Scenario: Opening a legacy hash URL
- **WHEN** the user opens a URL ending in `#pills`, `#liquids`, `#nutrition`, or `#free-water-deficit`
- **THEN** the All calculators page with all five calculators is shown

### Requirement: Favorites page
The app SHALL show a Favorites page at the URL hash `#favorites` that renders only the favorited calculators, grouped under the same category headings and in the same order as on the All calculators page. A category with no favorited calculators MUST NOT be shown. When there are no favorites, the page MUST show a hint explaining how to add one. Calculator inputs and results MUST be the same on both pages.

#### Scenario: Viewing favorites
- **WHEN** Free water deficit and Pills are favorites and the user opens the Favorites page
- **THEN** only the Pills and Free water deficit calculators are shown, in that order, under the Medication dosing and Fluids & electrolytes headings

#### Scenario: Empty categories hidden
- **WHEN** only Nutrition is a favorite and the user opens the Favorites page
- **THEN** only the Nutrition heading and the Nutrition calculator are shown

#### Scenario: No favorites
- **WHEN** there are no favorites and the user opens the Favorites page
- **THEN** no calculators or category headings are shown and a hint explains how to add a favorite

#### Scenario: Unfavoriting on the Favorites page
- **WHEN** the user presses the favorite toggle of a calculator on the Favorites page
- **THEN** that calculator disappears from the Favorites page, along with its category heading if it was the last favorite in that category

#### Scenario: Values kept between pages
- **WHEN** the user enters values in the Pills calculator on the All calculators page and then opens the Favorites page with Pills favorited
- **THEN** the Pills calculator shows the same values
