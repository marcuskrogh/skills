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

## First view

The shell is the frame: brand, page pills, Healthy, Stop. It is not content.

The first view shows the small set of facts a person needs to understand that
page’s job, in a light layout. Deeper material opens where they would look or
click. One layer at a time. Escape closes it.

A single word, with the rest of the job hidden, is not done. Every reading,
control, and chart on the first view is not done.

| Page | On the first view | Opens from there |
|------|-------------------|------------------|
| Overview | Running or Stopped, and each room’s temperature | House opens the controller readings. A room opens that room. |
| Schedules | Today’s shape: what is on now, and the next change, per room | The week editor and the per-interval controls |
| Room | The reading, the target, and Heating, Idle, or Off | History opens the plots. Today opens the periods. The experiment word opens the run. |
| Tuning | Which planner is in use, and the few parameters that define it | Show opens the rest of the form |
| System status | Healthy or not, and the short list that explains it: overall, MQTT, entities, MPC | Identification history |
| Parameter estimation | The run name, whether it is running, and the time remaining | The name opens the trace and the rest of the run |
| Configuration | The open section’s few fields | Other sections open from their names |

Overview does not carry Tuning, parameter estimation, system status, or
configuration. Those stay in the nav.

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
