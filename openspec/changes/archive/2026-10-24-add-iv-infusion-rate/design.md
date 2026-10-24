# Design

## Context

Each calculator is its own module under `src/Calculators/`. It exposes `Model`, `Msg`, `init`, `update : Msg -> Model -> Strings -> Model` and `view`, and it renders through `Card.view` and `Label.view`. Pure formulas live in `src/Functions.elm`. `Main.elm` holds one sub-model per calculator. `Favorites.Calculator` lists the calculators and sets their order through `Favorites.all`. `FreeWaterDeficit.elm` is the closest model to follow: it has option buttons, a `Maybe` result and an `error : Maybe String`. Requirements are in `specs/iv-infusion-rate/spec.md` and `specs/calculator-page/spec.md`.

## Goals / Non-Goals

**Goals:**
- Follow the FreeWaterDeficit module shape, so the new calculator reads like the existing ones.
- Keep the formulas as pure functions in `Functions.elm`, so they can be tested without the UI.

**Non-Goals:**
- No shared "duration" field component. Only one calculator needs it for now.
- No changes to `Card`, `Label` or `FormFields`.

## Decisions

### One card with both results, not two modes
One calculation shows mL/h as the main `Label.view` value and drops/min as an extra line. Both use the same inputs, and the only extra input for drops/min is the drop factor. A mode switch would add state and a step without adding any information.
*Alternative:* a Pump / Gravity mode toggle. Rejected because it hides one of the two results, and nurses often need both.

### Duration is one number plus a Hours/Minutes option group
The unit is a custom type, `type DurationUnit = Hours | Minutes`, shown with `optionButtonsField`. The formulas take the duration already converted:
- `calculatePumpRate volumeMl hours = volumeMl / hours`
- `calculateDripRate volumeMl dropFactor minutes = volumeMl * toFloat dropFactor / minutes`

The view converts minutes to hours (or hours to minutes) once.
*Alternative:* separate hours and minutes fields. Rejected because it adds a third number field and an "either may be empty" rule to the validation.

The Hours/Minutes buttons sit on the same row as the duration input, inside a `.field-row` wrapper in `styles.css`. Within that row the option group's legend ("Duration unit") is visually hidden, because the field's own "Duration" label already names the row; screen readers still announce the legend. The input shrinks to make room and the row never wraps. Down to 320 px the input still fits four digits.

### Drop factor is an `Int` from a fixed list
The options are `[ 10, 15, 20, 60 ]`, the default is `20`, and they are shown as option buttons with values `"10"`, `"15"`, `"20"`, `"60"`. The option labels come from the strings (for example "20 drops/mL"), so they follow the language.

### Store numbers, not formatted text, in the result
`result : Maybe { mlPerHour : Float, dropsPerMinute : Int }`. Text is built only in `view`, so switching language re-renders the same result with new labels. This is how FreeWaterDeficit works, and it is what the bilingual spec scenario needs.
- mL/h is rounded with `formatToDecimals 1`, so 125.0 shows as `125`.
- drops/min uses Elm's `round`, which rounds halves up for positive numbers.

### Validation order
Each value is parsed with `strToFloat`. If either value is `Nothing`, `invalidInputs` is shown. If either value is `<= 0`, `zeroNotAccepted` is shown. Otherwise the rates are calculated. Every input `Msg` clears both `result` and `error`, as FreeWaterDeficit does.

### Placement and favorites key
- Add `IvInfusionRate` last in `Favorites.all`, with the key `"iv-infusion-rate"`.
- `Favorites.decode` already ignores unknown keys and fills missing ones by membership, so favorites stored under the old keys keep working without a migration.
- Add an `IvInfusionRateMsg` branch to `Main.update` and an `IvInfusionRate` branch to `viewCalculator`.

### Strings
New `Strings` fields in both languages:
- titles and labels: `ivInfusionRate`, `infusionVolume`, `infusionDuration`, `durationUnit`, `hours`, `minutes`, `dropFactor`
- results: `pumpRate`, `dripRate`, `ivInfusionFormula`
- units: `mlPerHour`, `dropsPerMinute`, `dropsPerMl`, `hoursShort`, `minutesShort`

The existing `ml`, `calculate`, `reset`, `resultHint`, `calculationResult`, `invalidInputs` and `zeroNotAccepted` are reused.

Suggested Georgian: "ინფუზიის სიჩქარე", "მოცულობა (მლ)", "ხანგრძლივობა", "საათი", "წუთი", "წვეთის ფაქტორი", "მლ/სთ", "წვეთი/წთ".

## Risks / Trade-offs

- [Very short durations such as 1 min give very high rates.] → This is accepted, because limits and warnings are out of scope. The math stays correct.
- [Floating-point edge cases near .5 rounding, for example 41.5 drops/min.] → Tests cover one exact half case so the rounding direction is fixed.
- [Georgian medical wording may not match local usage.] → The user reviews the Georgian strings before merge.
