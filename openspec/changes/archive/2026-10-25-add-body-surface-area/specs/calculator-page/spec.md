# Spec Delta

## MODIFIED Requirements

### Requirement: All calculators on one page
The app SHALL render the Pills, Liquids, IV infusion rate, Body surface area, Free water deficit, and Nutrition calculators together on the All calculators page, in that order, grouped by category. The All calculators page MUST be shown for the app root URL and for every URL hash other than `#favorites`.

#### Scenario: Opening the app
- **WHEN** the user opens the app root URL
- **THEN** all six calculators are visible on the page, in the order Pills, Liquids, IV infusion rate, Body surface area, Free water deficit, Nutrition

#### Scenario: Opening a legacy hash URL
- **WHEN** the user opens a URL ending in `#pills`, `#liquids`, `#nutrition`, or `#free-water-deficit`
- **THEN** the All calculators page with all six calculators is shown

### Requirement: Calculator categories
Every calculator SHALL belong to exactly one category, and the categories SHALL be shown in this order: Medication dosing (Pills, Liquids, IV infusion rate, Body surface area), Fluids & electrolytes (Free water deficit), and Nutrition (Nutrition). Each category MUST be shown as a section with a localized heading above its calculators. That heading MUST rank one level above the calculator titles in the heading outline.

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
- **THEN** the calculators in each category are stacked in one centred column, and each category starts below the previous one

## ADDED Requirements

### Requirement: Body surface area can be a favorite
The body surface area calculator SHALL have a favorite toggle like the other calculators. Favorites saved before this calculator existed MUST still load unchanged.

#### Scenario: Favoriting the body surface area calculator
- **WHEN** the user presses the favorite toggle on the body surface area calculator and opens the Favorites page
- **THEN** the body surface area calculator is shown there, under the Medication dosing heading

#### Scenario: Older stored favorites
- **WHEN** the stored favorites list only Pills and Nutrition
- **THEN** the app loads with Pills and Nutrition as favorites and body surface area is not a favorite
