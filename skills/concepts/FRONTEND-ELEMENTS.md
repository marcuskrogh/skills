# Frontend elements

Recurring **product surface** pieces for [CONCEPT_FRONTEND](CONCEPT_FRONTEND.md).
Load with that concept. Heat the **tokens** from [FRONTEND-WARM.md](FRONTEND-WARM.md).
Candidate: Heating Assistant
(`marcuskrogh/HeatingAssistant`, `heatingassistant/app/static/`).

Build rules for the jobs in that app. Read it for page structure. Do not edit it.

## Shell

**Where.** `index.html`, `industrial-dashboard.js` panel chrome, `.panel-nav`.

Paper page. Nav is a quiet row: brand, text links as pills, Healthy as a sage
word with a round dot, Stop as a clay pill. Stopped is an outline pill labelled
Start. Skip links land on the first job.

Pages in the nav: Overview, Schedules, Tuning, Parameter estimation, System
status, Configuration.

## Overview

**Where.** `pages/overview.js`.

First view: House (Running or Stopped, Next), and one card per room (name,
Heating / Idle / Off, temperature). That is the whole first screen besides
the shell.

House opens overall health, MPC load, comfort, heating power, system COP,
daily energy, tracking error, and model fit. A room opens that room’s fact
(the temperature). Schedules in the nav opens what is on now. One layer open
at a time. Escape closes it.

Numbers are Atkinson Hyperlegible, weight 700, lining and tabular figures.
A status word sits beside the number. Hide a reading that has no value.

## Room

**Where.** `pages/room-detail.js`, `components/room-climate-tile.js`,
`components/climate-card.js`.

First view: the name, Heating / Idle / Off, and the temperature (the
**signature**). A running experiment is a plum word beside that status, not a
panel.

The temperature opens target, comfort band, and heating control. History on
that sheet opens the temperature plot and the power plot. Today opens today’s
periods. The plum word opens the run: name, remaining time, rounded plum
capsule.

## Plots

**Where.** `components/time-series-chart.js`, `chart-theme.js`,
room-detail history, identification and tuning canvases.

The series fills the plot. Scale the axis to the data and the bounds, with
about a 5% margin. The plot face is a rounded rectangle, about 32px in the
chart frame, on sheet `#fffaf6`.

Plots stay closed until History (or the page’s trace) is opened.

The feasible band is that plain sheet. Infeasible is opaque warm rose
`#c48474` from the bound out to the rounded edge: on temperature, above the
upper constraint and below the lower one; on power, outside heating and
cooling capacity. The two bounds run across the time axis. Rose never covers
the interior between them. Boundary lines stay invisible.

Ticks are Atkinson Hyperlegible, weight 700, mute `#8d7f74`. Hairline grid in
ink at low contrast. Series: measured temperature clay `#d4532b`, setpoint
ink, power honey `#e3a15a`, forecast a lighter clay dash. Line width 2 CSS
pixels; round caps. Legend is sentence-case labels. Empty plot: one sentence
that names the next step (wait for history, pick a range).

## Schedules

**Where.** `pages/schedules.js`, `css/pages/schedules.css`.

First view: one line per room. Mode word (Comfort, Off), and until when.
Now is an ink pill on the opened day, not a board of every period.

The line opens that day’s periods. The day opens the week. A period opens
the editor: rounded fields and pills. The live interval uses clay or ink, on
sheet cells. The week is not on the first view.

## Tuning and configuration

**Where.** `pages/tuning-controller.js`, `pages/configuration.js`.

Tuning’s first view is the planner in use, one sentence. The planner opens
its parameters: label above the control, rounded fields on sheet. Apply is
the clay pill, and it appears after a value changes.

Configuration’s first view is the section names. A name opens that section’s
fields. Errors sit next to the field and name the fix. Placeholders are
examples that end with `…`.

## System status and parameter estimation

**Where.** `pages/system-status.js`, `pages/parameter-estimation.js`.

System status first view: Healthy, or the one issue, in one line. That word
opens a short list — Overall, MQTT, Entities, MPC, Identification. A row
opens its readings. The list is rows, not a grid of cards on the first view.

Parameter estimation first view: the run name, and whether it is running.
The name opens remaining time, a rounded plum capsule, and the trace when
the opened job is the plot.

Loading copy ends with `…`. Empty and error states name the next action, on
the same surface.
