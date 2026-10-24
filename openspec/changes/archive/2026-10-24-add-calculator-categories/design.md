# Design

## Context

`Main.view` renders `Favorites.all`, filtered by favorites on the Favorites page, into a single `div.calculators` grid. `Favorites.all` is the canonical calculator order: `decode` returns favorites in that order. Card titles are `h2`, rendered by `Calculators.Card`. See proposal.md for the motivation.

## Goals / Non-Goals

**Goals:**
- One place that defines the categories, their order, and the calculators in each.
- The page order and `Favorites.all` cannot drift apart.

**Non-Goals:**
- Category state in the model or URL. Categories are static.

## Decisions

**New `Categories` module.**
- It defines `type Category = MedicationDosing | FluidsAndElectrolytes | NutritionCategory`, `all : List Category`, `calculators : Category -> List Calculator`, and `title : Strings -> Category -> String`.
- `Favorites.all` is redefined in category order. It stays a literal list to avoid a circular import, because `Categories` imports `Favorites.Calculator`.
- A test in `tests/CategoriesTests.elm` asserts that `List.concatMap Categories.calculators Categories.all == Favorites.all`. This covers two things at once: every calculator is in exactly one category, and the orders match.
- *Alternative:* add a `category : Calculator -> Category` function in `Favorites`. Rejected because `Favorites` is about persistence, and putting grouping there mixes two concerns.
- *Alternative:* derive `Favorites.all` from `Categories`. Rejected because of the import cycle.

**`NutritionCategory` constructor name.** It avoids a clash with `Favorites.Nutrition` when both modules are imported unqualified.

**Rendering.**
- `Main.view` maps each category to `section [ class "category", aria-labelledby ] [ h2 [ id ] [title], div.calculators [...] ]`, keeping only the visible calculators in that category.
- Empty sections are dropped. That only happens on the Favorites page, because every category has calculators on the All page.
- The existing empty-state hint is unchanged: it shows when no calculators are visible at all.
- The `.calculators` grid is reused inside each section, so the one/two-column behaviour is unchanged.

**Heading levels.** `Card.elm` switches from `h2` to `h3`, and the `.card h2` CSS rule becomes `.card h3` at the same size. The category `h2` gets its own `.category h2` style, visibly larger than card titles, plus spacing between sections.

**Translations.** Add three fields: `medicationDosing`, `fluidsAndElectrolytes`, and `nutritionCategory`.
- English: "Medication dosing", "Fluids & electrolytes", "Nutrition".
- Georgian: "მედიკამენტების დოზირება", "სითხეები და ელექტროლიტები", "კვება".

`nutritionCategory` is kept separate from the calculator title `nutrition`, even though the text is the same today, so the two can change independently.

## Risks / Trade-offs

- [Display order changes for existing users] → This is accepted and recorded as BREAKING in the proposal. Stored favorites are unaffected because they are stored by key.
- [The Nutrition category heading repeats the Nutrition card title] → Accepted for now. Either name can change on its own later.
- [Georgian translations are drafts] → The user should review them during apply.
