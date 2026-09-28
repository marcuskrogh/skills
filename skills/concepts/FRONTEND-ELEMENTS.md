# Frontend elements

Recurring **product surface** pieces for [CONCEPT_FRONTEND](CONCEPT_FRONTEND.md).
Load with that concept. Heat the **tokens** from [FRONTEND-WARM.md](FRONTEND-WARM.md).
Candidate: Heating Assistant
(`marcuskrogh/HeatingAssistant`, `heatingassistant/app/static/`).

These are build rules, not a screenshot of today's industrial panel. Keep the
jobs and class names where they already exist; restyle them to **warm**.

## Shell

**Where.** `index.html`, `industrial-dashboard.js` panel chrome, `.panel-nav`.

Cream hull. Nav is a quiet row: brand, text links as pills, one terracotta
Start/Stop. Live vs stopped is a short word plus a small round dot — not a
teal sweep across the bar. Skip links land on the first job (`main` or Rooms).

## Sections

**Where.** Overview (`pages/overview.js`): System status, Controller KPIs,
Rooms. Room detail, schedules, configuration, system status, parameter
estimation, tuning.

A section is a heading plus its modules. Sentence case. No hairline rule
farm. One heading scale. Space above the heading is larger than space inside
the module. Do not nest a second card inside a card for the same job.

## KPI cards

**Where.** `.card.kpi`, `components/kpi-card.js`, overview `grid-kpi`.

Large tabular number, short label under it, optional unit. One status word
when it changes a decision (Healthy, Warning). No filled gauge well, no
percentage bar behind the number, no mono tick strip. A grid of four to eight
cards is enough on Overview; hide a card that has no value.

Expand (`components/kpi-expand.js`): details open under the same card, cream
on cream, not a dark drawer. Copy names the next action.

## Gauges

**Where.** `components/gauge.js` on Overview (health, MPC load, comfort,
power, COP, daily energy, tracking error, model fit).

Treat a gauge as a KPI card unless the brief asks for a band. Comfort band
belongs on the climate card track, not as a circular dial. If a fill remains,
it is a short rounded capsule in terracotta or mute, never cyan.

## Climate cards / room tiles

**Where.** `components/climate-card.js`, `components/room-climate-tile.js`,
`css/pages/climate-card.css`. Overview room grid; room detail.

Modules, top to bottom: name + status, current temperature (the **signature**
reading on a room page), target stepper, comfort band, today's schedule
rows. Heating / Idle / Off / Experiment as a short status word. Power is an
icon button with an accessible name. Experiment is a named run, remaining
time, and a rounded progress capsule in plum — not a violet industrial bar.

## Plots

**Where.** `components/time-series-chart.js`, `chart-theme.js`, `chart-align.js`,
room-detail history, identification/tuning canvases.

The series fills the plot. Scale the axis to the data and the bounds, with
about a 5% margin, the same way Heating Assistant sizes a room chart. The
line sits in that range.

Feasible and infeasible are areas, not extra lines. The feasible band is the
plain plot surface (`#fffaf6`), with no wash. Infeasible is an opaque plum
fill (`#8f5d78`) from the bound out to the edge of the plot: on temperature,
above the upper constraint and below the lower one; on power, outside heating
and cooling capacity. No dashed boundary, and no translucent green or red.

Cream plot face, warm ink ticks, hairline grid at low contrast. Series:
measured temperature terracotta, setpoint ink, power amber (`#d08a2b`),
outdoor mute stone, solar a dusty gold, forecast a light terracotta dash.
Line width 2 CSS pixels; round caps. No cyan, no teal fill under the line.
Height stays `--chart-height-primary` (240px) / secondary (200px). Legend is
sentence-case labels, not a mono key. Empty plot: one sentence that names
the next step (wait for history, pick a range).

## Countdown

**Where.** `components/countdown.js` — Next control.

Label above a large tabular time. This may be the Overview **signature**
readout beside Start. No spinning ring.

## Schedule rows

**Where.** `components/schedule-overview.js`, `css/pages/schedules.css`.

Time range + mode word (Comfort, Setback, Off). Now is a pill, not a neon
marker. Editors stay rounded inputs and pills. Dense week grids still use
cream cells and terracotta for the live interval.

## Forms and configuration

**Where.** `pages/configuration.js`, `css/pages/configuration.css`, tuning,
parameter estimation.

Label above control. Rounded fields on cream. Primary submit is the
terracotta pill. Errors sit next to the field and name the fix. Placeholders
are examples that end with `…`.

## Status banners

**Where.** Identification running banner, ingress status, system-status page.

One rounded capsule, ink on cream, terracotta or plum only for the state that
must be seen. Do not steal the Start control's colour for a background wash.

## Empty, loading, error

Loading copy ends with `…`. Empty and error states name the next action.
Keep them in the same module; do not switch to a dark overlay.
