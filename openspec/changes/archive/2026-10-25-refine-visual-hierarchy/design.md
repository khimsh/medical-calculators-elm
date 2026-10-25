# Design

## Context

All layout and weight rules live in `styles.css`. The calculator grid is `.calculators`, two columns from 56 rem with `align-items: start`, so each card keeps its own height and neighbours are uneven. Weights 500 and 700 are set on about twenty selectors. FiraGO is loaded at 400, 500 and 700 only. Markup is not changed by this proposal; see proposal.md for motivation.

## Goals / Non-Goals

**Goals:**
- One column of cards at every width, with a measure that suits forms.
- Bold only for category headings and result values, so hierarchy reads at a glance.
- More space between sections, cards, and fields.

**Non-Goals:**
- Equal-height or masonry layouts.
- New font files or weights, and no new colours.
- Any Elm change.

## Decisions

**One column with a maximum width of 40 rem.** The grid becomes `grid-template-columns: minmax(0, 40rem)` with the same gap, and each category block is centred on the page. Category headings align with the left edge of their cards. Forty rem keeps the number fields and the option buttons in one row without stretching. The alternative was to keep two columns and stretch cards to equal height, which leaves empty space in short cards and still looks uneven when content differs. Full width (72 rem) was rejected because it makes forms and results hard to scan.

**Weight map.** Bold is removed everywhere except category headings and result values. Weight 500 carries the middle level, and 400 carries labels and body text.

| Element | Now | New |
| --- | --- | --- |
| `.category h2` | 700 | 700 (unchanged) |
| `.result-value` | 700 | 700 (unchanged) |
| `.card h3` | 700 | 500, size unchanged |
| `.page-nav a[aria-current]` | 700 | 500, marked by the `accent-soft` background only |
| `.field label` | 500 | 400 |
| `.field-options legend` | 500 | 400 |
| `.field-option input:checked + label` | 700 | 500 |
| `.result-title` | 500 | 400 |
| `.macros dd` | 700 | 500 |
| `.testing-banner` | 500 | 400 |
| `.notice` | inherits | 400 |
| `.error`, `.button-*`, `.page-nav a`, `.lang-toggle` | 500 | 500 (unchanged) |

**Whitespace.** The gaps and padding that are repeated in the stylesheet grow by one step, so the page keeps one rhythm.

| Selector | Now | New |
| --- | --- | --- |
| `.categories` gap | 2.5 rem | 3.5 rem |
| `.calculators` gap | 1.5 rem | 2 rem |
| `.card` padding | 1.5 rem | 2 rem |
| `.card` gap | 1.25 rem | 1.5 rem |
| `.card form` gap | 1 rem | 1.25 rem |
| `.field` gap | 0.375 rem | 0.5 rem |
| `.card-formula` margin-top | 0.25 rem | 0.5 rem |
| `.testing-banner` padding | 0.75 rem 1 rem | 1 rem 1.25 rem |
| `.testing-banner` margin-bottom | 1.5 rem | 2 rem |

## Risks / Trade-offs

- **[Longer page]** One column makes the All and Favorites pages taller. → Mitigation: category headings and the larger gaps mark sections, and the card width keeps each card short enough to scan.
- **[Lower emphasis on labels]** Labels at 400 are lighter than before. → Mitigation: keep their current size and colour, and check the page at 320 px before release.
- **[Selected nav link]** Dropping 700 on the current page link removes one cue. → Mitigation: the `accent-soft` pill stays, and `aria-current` is unchanged.

## Migration Plan

No data or runtime changes. Edit `styles.css`, then run `npm test` and `npm run build` as the gate. Rollback is a revert of the stylesheet commit.
