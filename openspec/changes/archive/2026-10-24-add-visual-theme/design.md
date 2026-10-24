# Design

## Context

The page is currently unstyled (see proposal.md). Markup comes from a few shared helpers, so a small number of edits covers all four calculators:

- `Main.view`: `main_ [ button (toggle), Pills, Liquids, Nutrition, FreeWaterDeficit ]`.
- `Card.view`: `article > header (h2, p formula) + form (fields…, div buttons) + div[aria-live] (result)`.
- `Label.view`: `div[role=region] > p title, p (span value, " ", span unit), extra…, div (p working…)`; `Label.empty`, `Label.notice` (`role=status`).
- `FormFields`: `div > label + input|select`; checkbox `div > input + label`.
- `Functions.errorDisplay`: `div[role=alert] > p`.
- Nutrition macros: `dl > div > dt + dd`.

The old FiraGO files were never committed, so they have to be fetched again from upstream (`bBoxType/FiraGO`, `Fonts/FiraGO_WEB_1001/Roman/*.woff2`, OFL). Each file is about 258 KB because it covers Arabic, Hebrew, Thai and more.

## Goals / Non-Goals

**Goals:**
- One plain `styles.css`, with CSS custom properties for every colour, size and radius, and no build step.
- Element selectors first; classes only where an element is ambiguous.
- Font payload kept small and loaded without layout shift.

**Non-Goals:**
- Dark mode (tokens make it easy to add later).
- Changing markup structure beyond adding classes and a wrapper for the card grid.
- Visual regression tooling.

## Decisions

**Tokens (`:root`)**, all contrast-checked:

| Token | Value | Use | Contrast |
|---|---|---|---|
| `--accent` | `#0014FF` | primary button, focus ring, result value | 7.6:1 on bg, 8.3:1 on white |
| `--accent-hover` | `#0010CC` | button hover/active | white text 10.8:1 |
| `--accent-soft` | `#E6E8FF` | result panel background | accent text 6.8:1 |
| `--bg` | `#F4F5FF` | page background | — |
| `--surface` | `#FFFFFF` | cards, inputs | — |
| `--text` | `#0B0D2E` | body text | 17.4:1 on bg |
| `--text-muted` | `#4A4F72` | formula, working lines, placeholders | 7.3:1 on bg |
| `--border` | `#8A8FB8` | input and select borders | 3.1:1 on white (non-text minimum) |
| `--border-soft` | `#DCDFF7` | card outline (decorative) | — |
| `--error` / `--error-bg` | `#B3261E` / `#FDECEA` | input errors | 5.7:1 |
| `--notice` / `--notice-bg` | `#7A4B00` / `#FFF4DE` | clinical notice (Na < 140) | 6.8:1 |

Alternative considered: using `#F4F5FF` for cards as well. Rejected, because white cards on the tinted page separate the calculators more clearly.

**Font: FiraGO Regular (400), Medium (500), Bold (700).** Medium is for labels and buttons, Bold for headings and result values. Subset each file once with `pyftsubset` from `fonttools` (in a throwaway virtualenv in the scratchpad) to Basic Latin, Latin-1, General Punctuation, the Georgian blocks (U+10A0–10FF, U+1C90–1CBF Mtavruli, U+2D00–2D2F), and the math, arrow and dash symbols the app prints (×, ÷, −, →, ≥, ≤, %). Keep the `tnum` feature. Commit the subset WOFF2 files and `OFL.txt` to `fonts/`. Use `font-display: swap` and preload Regular in `index.html`. Fallback stack: `FiraGO, "Noto Sans Georgian", system-ui, sans-serif`. Do not use `text-transform: uppercase` on Georgian text: it maps to Mtavruli, which reads as shouting and doesn't suit labels.

Alternative considered: load from a CDN. Rejected: FiraGO isn't on Google Fonts, and self-hosting keeps the app free of third-party requests.

**Type scale (rem, 16 px base):** body 1 / line-height 1.5; label 0.9375 Medium; card title (`h2`) 1.25 Bold; formula and working lines 0.875 muted; result value 2 Bold accent, with the unit at 1.125 Medium. `font-variant-numeric: tabular-nums` applies to `input`, `.result-value` and `dd`.

**Layout:** `body` has a max width of 72rem and is centred, with 1rem padding (1.5rem from 48rem up). A top bar holds the toggle, aligned right, as a quiet outline button. `main` is a CSS grid, one column by default and `repeat(2, 1fr)` from 56rem up, with a 1.5rem gap. Cards are `--surface`, 1rem radius, 1.5rem padding, with a soft 1px outline and no heavy shadows. Inputs fill the card width at 2.75rem height (a comfortable touch target). Calculate and Reset sit side by side.

Wrapping the toggle in a `header` changes the DOM. The "No navigation controls" scenario still holds, since the toggle remains the only control outside the forms.

**Classes added** (kebab-case, flat):
- Main: `topbar` (new `header` wrapping the toggle), `lang-toggle`, `calculators` (wrapper around the four cards, used as the grid).
- Card: `card` on `article`, `card-formula` on the formula `p`, `actions` on the buttons `div`, `button-primary` and `button-secondary` on the buttons.
- Label: `result` on the region, `result-title`, `result-value`, `result-unit`, `result-working`, `result-empty` for the hint, and `notice` for the notice.
- `errorDisplay`: `error`.
- FormFields: `field` on each field `div`, `field-check` on checkbox/radio groups.
- Nutrition: `macros` on the `dl`.

Alternative considered: element selectors only. Rejected: several `p` and `div` elements are indistinguishable by structure alone (result title vs. working lines).

**Focus:** `:focus-visible { outline: 3px solid var(--accent); outline-offset: 2px }`. Never remove outlines.

**Deploy:** `build-and-deploy.yml` copies `styles.css` and `fonts/` into `dist/` again.

## Risks / Trade-offs

- [Subsetting drops a glyph the UI needs, such as a symbol in a translation] → After subsetting, compare every character in `src/Translations.elm` and `src/` string literals against the font's cmap. Any missing character falls back to the system font, so the page stays readable either way.
- [FiraGO upstream URL moves] → The subset files are committed, so this matters only if they need regenerating.
- [Two columns make cards of different heights look ragged] → Accepted; use `align-items: start` so cards don't stretch.
- [No title heading leaves the top bar sparse] → Kept intentionally (earlier decision). Easy to revisit as a separate change.
