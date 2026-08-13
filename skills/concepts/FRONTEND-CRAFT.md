# Frontend craft

Quality floor for [CONCEPT_FRONTEND](CONCEPT_FRONTEND.md). Load from that
concept or from a skill that applies it. Check these on every **product
surface**; the concept owns **direction** and **signature**.

## Document

- Landmarks first: `header`, `nav`, `main`, `footer` as the page needs them.
- Headings run `h1`–`h6` in order. Page-length views include a skip link to
  `main`. Heading anchors use `scroll-margin-top`.
- `button` for actions; `a` for navigation.
- Images have `alt` (empty when decorative). Decorative icons are
  `aria-hidden="true"`. Icon-only controls have an accessible name.
- `theme-color` / `color-scheme` match the page background.

## Focus and keyboard

- Interactive elements show a visible `:focus-visible` ring (or equivalent).
- `outline: none` only when a replacement focus style is present.
- Compound controls group focus with `:focus-within` when that matches the hit
  target.
- Keyboard reaches every action the pointer can.

## Forms

- Every control has a label (`label` + `for`, or a wrapping `label`).
- `name` and `autocomplete` fit the field; `type` / `inputmode` match the data.
- Labels and controls share one hit target. Paste stays available.
- Errors sit next to the field and name the fix. First error takes focus on
  submit.
- Placeholders are examples that end with `…`, not labels.
- The submit control stays usable until the request starts.

## Motion

- `prefers-reduced-motion: reduce` disables or replaces motion.
- Transitions list properties; they are `transform` and `opacity` only.
- Animations are interruptible. `transform-origin` is set when it matters.

## Type and content

- Headings use `text-wrap: balance` or `text-pretty`.
- Numeric columns use `font-variant-numeric: tabular-nums`.
- Ellipsis is `…`. Quotes are curly where the locale uses them. Tight pairs
  (`10 MB`, `⌘ K`) use a non-breaking space.
- Loading copy ends with `…`. Empty and error states name the next action.
- Text containers survive short, average, and long strings (`min-width: 0` in
  flex children; clamp, truncate, or wrap on purpose).

## Layout, touch, media

- Layout holds at a small viewport. Full-bleed views respect
  `env(safe-area-inset-*)`.
- `touch-action: manipulation` on interactive controls.
- Images declare width and height. Below-fold images lazy-load; the LCP image
  is eager.
- Hover and active states increase contrast relative to rest.

## Theme

- Dark pages set `color-scheme: dark`. Native form controls get explicit
  `background-color` and `color`.
- Tokens drive theme, not one-off hex in scattered rules.
