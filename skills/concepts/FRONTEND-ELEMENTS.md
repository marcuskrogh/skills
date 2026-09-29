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
daily energy, tracking error, and model fit. A room opens the room page jobs
below. Schedules opens today’s periods. One layer open at a time. Escape
closes it.

Numbers are Atkinson Hyperlegible, weight 700, lining and tabular figures.
A status word sits beside the number. Hide a reading that has no value.

## Room

**Where.** `pages/room-detail.js`, `components/room-climate-tile.js`,
`components/climate-card.js`.

This page is the deeper layer. It shows the current temperature (the
**signature**), target stepper, comfort band, heating control, temperature
plot, power plot, today’s periods, and the experiment when one is scheduled
or running. Heating / Idle / Off / Experiment is a short status word.
Experiment is a named run and a rounded plum capsule.

## Plots

**Where.** `components/time-series-chart.js`, `chart-theme.js`,
room-detail history, identification and tuning canvases.

The series fills the plot. Scale the axis to the data and the bounds, with
about a 5% margin. The plot face is a rounded rectangle, about 32px in the
chart frame, on sheet `#fffaf6`.

The feasible band is that plain sheet. Infeasible is opaque warm rose
`#c48474` from the bound out to the rounded edge: on temperature, above the
upper constraint and below the lower one; on power, outside heating and
cooling capacity. Boundary lines stay invisible.

Ticks are Atkinson Hyperlegible, weight 700, mute `#8d7f74`. Hairline grid in
ink at low contrast. Series: measured temperature clay `#d4532b`, setpoint
ink, power honey `#e3a15a`, forecast a lighter clay dash. Line width 2 CSS
pixels; round caps. Legend is sentence-case labels. Empty plot: one sentence
that names the next step (wait for history, pick a range).

## Schedules

**Where.** `pages/schedules.js`, `css/pages/schedules.css`.

The page’s job is the week and the day. Time range plus mode word (Comfort,
Setback, Off). Now is an ink pill. Editors are rounded fields and pills. The
live interval uses clay or ink, on sheet cells.

## Tuning and configuration

**Where.** `pages/tuning-controller.js`, `pages/configuration.js`.

Label above the control. Rounded fields on sheet. The primary action is the
clay pill. Errors sit next to the field and name the fix. Placeholders are
examples that end with `…`.

## System status and parameter estimation

**Where.** `pages/system-status.js`, `pages/parameter-estimation.js`.

System status is health, connectivity, and the readings that explain them.
Parameter estimation is the run: name, remaining time, plum progress capsule,
and the plot for that run when the page’s job is the trace.

One rounded capsule for a banner. Clay or plum only for the state that must
be seen. Loading copy ends with `…`. Empty and error states name the next
action, on the same surface.
