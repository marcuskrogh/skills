# Warm direction

Default **direction** for [CONCEPT_FRONTEND](CONCEPT_FRONTEND.md) when the brief
leaves stance free. Load from that concept or from a skill that pins this look.

## Stance

Simple, uncrowded, cream paper, terracotta accent, rounded modules. The page
feels like a household instrument on a kitchen counter, not a plant SCADA
wall. Useful, understandable, unobtrusive, honest, as little design as
possible — then make every remaining part warm and round.

Name the **subject** in the token plan (one sentence), then apply it. Example:
*House heating for the person at home — cream board, terracotta Start, large
room temperature.*

## Tokens

- **Color.** Cream hull (`#f0ece4`). Warm near-black ink (`#1a1916`). Mute
  stone (`#6a6660`). One terracotta accent (`#ef5a11`) for the **signature**
  control and the one live value. Optional panel mix: white into hull. Four to
  six named values. Cream is the body; terracotta is the control. Status uses
  the same family: heating = terracotta, idle = mute, off = ink at low
  weight, experiment = a distinct warm plum (`#8b5e83`), never teal.
- **Type.** **Archivo** for display and body (a close square grotesk if Archivo
  is unavailable). Label above the value. Tracked labels. Tabular numerals on
  readings. Skip novelty display faces and monospace dashboards.
- **Layout.** Capsule modules with generous radius (`1.5rem` or pill for
  chips and nav links). Gutters wider than the industrial 8px grid. Separate
  groups (status, reading, controls, schedule) into their own modules or
  stacked blocks. The **signature** is the terracotta control plus one large
  numeric reading in type, not a circular dial, not a needle, not a CRT, not
  a filled gauge well.
- **Motion.** None, or a brief opacity on a new row. `transform` / `opacity`
  only. Still when `prefers-reduced-motion`.

## Intensity

Less, but fully built. Space between groups is part of the design. Every
remaining control is aligned, labelled, and rounded. Volume comes from radius
and cream, not from packed numerals or glowing edges.

## Against the industrial look

Heating Assistant today ships `industrial.css`: hull `#1a1d23`, accent
`#00d4aa`, card `#22262e`, radius `8px`, JetBrains Mono ticks. That teal/grey
plant palette is the look this **direction** replaces. Cool steel rims, cyan
plot series, live-bar accent sweeps, and dense uppercase gauge grids go with
it. Keep the jobs (overview KPIs, room climate, plots, schedules); change the
surface.

## Distinct from default clusters

| Cluster | This stance |
|---------|-------------|
| Terminal: near-black, acid-green or vermilion | Cream hull, terracotta control, no phosphor |
| News: hairline rules, zero radius, dense columns | Rounded capsules, air between groups |
