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
daily energy, tracking error, and model fit. A room opens that room’s reading,
target, and status. Schedules in the nav opens today’s shape. One layer open
at a time. Escape closes it.

Numbers are Atkinson Hyperlegible, weight 700, lining and tabular figures.
A status word sits beside the number. Hide a reading that has no value.

## Room

**Where.** `pages/room-detail.js`, `components/room-climate-tile.js`,
`components/climate-card.js`.

First view: the name, the temperature (the **signature**), the target, and
Heating / Idle / Off. Comfort sits with the target. History, Today, and a
plum experiment word are the way in. They are not panels.

History opens the temperature plot and the power plot. Today opens today’s
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

First view: today’s shape. One line per room shows what is on now and the
next change. Now is an ink pill on the current interval.

The week editor and the per-interval controls open from that line. Editors
are rounded fields and pills. The live interval uses clay or ink, on sheet
cells. The week grid is not on the first view.

## Tuning and configuration

**Where.** `pages/tuning-controller.js`, `pages/configuration.js`.

Tuning’s first view is the planner in use and the few parameters that define
it. Label above the control. Rounded fields on sheet. Show opens the rest of
the form. Apply is the clay pill.

Configuration’s first view is the open section’s few fields. Other sections
open from their names. Errors sit next to the field and name the fix.
Placeholders are examples that end with `…`.

## System status and parameter estimation

**Where.** `pages/system-status.js`, `pages/parameter-estimation.js`.

System status first view: Healthy or not, and the short list that explains
it — overall, MQTT, entities, MPC — as rows, not a wall of cards.
Identification history opens from that list.

Parameter estimation first view: the run name, whether it is running, and
the time remaining. The name opens a rounded plum capsule and the trace.

Loading copy ends with `…`. Empty and error states name the next action, on
the same surface.
