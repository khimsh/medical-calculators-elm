# Tasks

## 1. Layout

- [x] 1.1 In `styles.css`, make `.calculators` a single column with `minmax(0, 40rem)` tracks and remove the two-column rule at 56 rem
- [x] 1.2 Check that `.card-slot` and `.card` do not stretch beyond the 40 rem column, and that the favorite toggle stays inside the card

## 2. Text weight

- [x] 2.1 Set `.card h3` to weight 500
- [x] 2.2 Set `.page-nav a[aria-current="page"]` to weight 500 and keep its `accent-soft` background
- [x] 2.3 Set `.field label` and `.field-options legend` to weight 400
- [x] 2.4 Set `.field-option input:checked + label` to weight 500
- [x] 2.5 Set `.result-title`, `.testing-banner` and `.notice` to weight 400
- [x] 2.6 Set `.macros dd` to weight 500
- [x] 2.7 Confirm the only weight-700 selectors left are `.category h2` and `.result-value`

## 3. Whitespace

- [x] 3.1 `.categories` gap to 3.5 rem
- [x] 3.2 `.calculators` gap to 2 rem
- [x] 3.3 `.card` padding to 2 rem and gap to 1.5 rem
- [x] 3.4 `.card form` gap to 1.25 rem
- [x] 3.5 `.field` gap to 0.5 rem, and `.card-formula` margin-top to 0.5 rem
- [x] 3.6 `.testing-banner` padding to 1 rem 1.25 rem and margin-bottom to 2 rem

## 4. Checks

- [x] 4.1 Run `npm test` and confirm it passes
- [x] 4.2 Run `npm run build` and confirm it succeeds
- [x] 4.3 Check the page at 320 px, 375 px and 1280 px, in both languages, by hand: one column, no horizontal scroll, uneven heights gone, hierarchy readable

## 5. Centring and spacing (follow-up)

- [x] 5.1 Centre each category block on the page at a maximum of 40 rem, with its heading aligned to the left edge of its cards
- [x] 5.2 Increase the space between categories, between cards, and between a category heading and its cards
- [x] 5.3 Increase the space between the header and the banner, and between the banner and the first category; centre the banner with the calculators
- [x] 5.4 Run `npm test` and `npm run build`
- [x] 5.5 Check the page at 320 px, 375 px and 1280 px by hand: centred column, heading alignment, spacing
