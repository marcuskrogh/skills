# Warm direction

Default **direction** for [CONCEPT_FRONTEND](CONCEPT_FRONTEND.md) when the brief
leaves stance free. Load from that concept or from a skill that pins this look.
This file, with [FRONTEND-ELEMENTS.md](FRONTEND-ELEMENTS.md), is the style guide.

## Stance

A household instrument on a kitchen counter. Useful, understandable, quiet.
The first screen shows that the system is running, and the temperature in each
room. Deeper information opens where someone would look: House, a room,
Schedules, or another nav page.

Name the **subject** in the token plan (one sentence), then apply it. Example:
*House heating for the person at home — paper, clay Stop, large room
temperatures, the rest behind a click.*

## Tokens

| Role | Value | Use |
|------|--------|-----|
| Paper | `#f3ebe3` | Page background |
| Sheet | `#fffaf6` | Cards, plot face, fields |
| Ink | `#2a221c` | Text, the Now pill, selected outline |
| Clay | `#d4532b` | Stop, the degree mark, the primary pill, a state that must be seen |
| Sage | `#6d8b6f` | Calm live state: Healthy, Heating, Running |
| Honey | `#e3a15a` | Power series |
| Plum | `#8f5d78` | Experiment |
| Mute | `#8d7f74` | Labels, idle, secondary text |
| Rose | `#c48474` | Infeasible plot regions only. Opaque. |

- **Type.** Atkinson Hyperlegible for words and values. Weight 400 for copy.
  Weight 700 for readings and controls. `font-variant-numeric: lining-nums
  tabular-nums` on values.
- **Radius.** Surfaces `1.75rem`. Actions and nav links are pills.
- **Motion.** None, or a brief opacity when a layer opens. `transform` /
  `opacity` only. Still when `prefers-reduced-motion`.

## First screen

Overview shows four things: the shell (brand, page pills, Healthy, Stop), a
House card (Running or Stopped, and Next), and one card per room (name,
Heating / Idle / Off, temperature).

House opens the controller readings: overall health, MPC load, comfort,
heating power, system COP, daily energy, tracking error, model fit.

A room opens that room: current temperature, target, comfort band, heating
control, temperature plot, power plot, today’s periods, experiment when one
exists.

Schedules opens today’s periods. Tuning, parameter estimation, system status,
and configuration are their own pages. They do not appear as blocks on
Overview.

The same rule on every page: the first view is that page’s job. Other pages
stay in the nav.

## Against the industrial panel

Heating Assistant today ships `industrial.css`: hull `#1a1d23`, accent
`#00d4aa`, card `#22262e`, radius `8px`, JetBrains Mono ticks. Keep the jobs.
The surface is this catalog. Read
`marcuskrogh/HeatingAssistant` at `heatingassistant/app/static/` for jobs and
page structure. Do not edit that repo.

## Distinct from default clusters

| Cluster | This stance |
|---------|-------------|
| Terminal: near-black, acid-green or vermilion | Paper, clay control, sage for calm |
| News: hairline rules, zero radius, dense columns | Rounded sheets, air between groups |
