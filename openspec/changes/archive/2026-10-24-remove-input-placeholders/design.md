# Design

## Context

`FormFields.numberField` takes a placeholder string, and all 11 callers pass the literal `"0.0"`. See proposal.md - Why for the motivation.

## Goals / Non-Goals

**Goals:**
- Make it impossible to add a placeholder through `numberField` again.

**Non-Goals:**
- Any replacement hint text or placeholder styling.

## Decisions

**Remove the parameter from `numberField`.** Its signature becomes `String -> String -> String -> (String -> msg) -> Html msg` (label, id, value, message). The `placeholder` import is removed from `FormFields`.
- *Alternative:* keep the parameter and pass `""` at each call site. Rejected because it leaves an unused parameter, and a later caller could add a placeholder back without noticing.

**No new view tests.** Without the parameter, the compiler guarantees that the helper emits no placeholder. No calculation logic changes, so the existing calculator tests are sufficient. A grep in the final check covers stray `placeholder` uses.

## Risks / Trade-offs

- [The signature change breaks every caller at once] → It is a compile-time break inside one repo, and tasks update each caller in turn.
