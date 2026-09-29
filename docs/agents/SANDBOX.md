# Sandbox: Front-end design sheet

## Element
Warm vs industrial comparisons for every Heating Assistant control the
front-end design skill names. Iterate on `sandbox/front-end-design/sheet.html`
(`--p-*` tokens and proposed blocks). Heating Assistant production files stay
untouched.

## Kind
visual

## Isolation
- Path: sandbox/front-end-design/
- Command: open `sandbox/front-end-design/sheet.html` (or `python3 -m http.server 8765 --bind 127.0.0.1 --directory sandbox/front-end-design` then `http://127.0.0.1:8765/sheet.html`)
- Inspectables: sandbox/front-end-design/inspect/

## Representativeness
- Relevant areas: runtime (static HTML/CSS, Atkinson Hyperlegible, Chrome render), data (dummy house jobs: room temperature, next control, house health, plot, schedule, form), neighbours (paper, clay, sage, honey, plum on one surface), path (jobs from Heating Assistant, layout invented for this pass), baseline (no industrial palette on the sheet)
- How reproduced: `sheet.html` is one composed home plus a style guide. Every value uses Atkinson Hyperlegible at weight 700 with lining and tabular figures.
- Gaps: live Heating Assistant websocket, real room history, and `industrial.css` host wiring. Operator scope: Heating Assistant is read-only. Those gaps cannot move a verdict on this look.

## Bar
- Scenario: the representative map above (not a simplified stand-in)

## Promote map
- Production targets: `skills/concepts/FRONTEND-WARM.md`, `skills/concepts/FRONTEND-ELEMENTS.md`, `examples/frontend-design/`
- Copy notes: accepted `--p-*` values become named tokens in `FRONTEND-WARM.md`; accepted proposed blocks update element rules; calibration HTML follows the same tokens. User-facing sheet copy: `/cursor/stores/self/docs/front-end-design-sheet.html`

## Iterations
| N | Change | Inspectable | Verdict |
|---|--------|-------------|---------|
| 1 | initial extract | sandbox/front-end-design/inspect/01-tokens-nav-kpi.png, 01-countdown-climate-plot.png, 01-banner-empty.png, 01-sheet-top.png | delta: show the jobs, not only the resting look |
| 2 | KPI expand: one open card moves first, spans the row, detail stays on the card. Current dark inset vs proposed cream detail. Clickable in `sheet.html`. | sandbox/front-end-design/inspect/02-kpi-expand.png | delta: do not stay bound to the current structure |
| 3 | Free rethink: Fraunces reading, Outfit UI, paper/clay/sage, one home, detail as a sentence. Style guide and pieces. Industrial strip is scale only. | sandbox/front-end-design/inspect/03-home.png, 03-style-guide.png, 03-pieces.png | delta: one clear face for every value; drop the charcoal and teal strip |
| 4 | Atkinson Hyperlegible for words and values. Weight 700, lining and tabular figures. Industrial strip removed. | sandbox/front-end-design/inspect/04-home.png, 04-style-guide.png, 04-pieces.png | delta: waiting on whether this type is the one to write into the skill |
| 5 | Temperature and power plots fill the frame. Sage wash is feasible. Clay wash is infeasible, to the plot edge, with no boundary line. | sandbox/front-end-design/inspect/05-plots.png | delta: drop the green and red washes |
| 6 | Infeasible is opaque plum to the plot edge. Feasible is the plain sheet, with no wash. | sandbox/front-end-design/inspect/06-plots.png | accept the opaque infeasible-only treatment |
| 7 | Plot face is a rounded rectangle. Infeasible is opaque warm rose `#c48474`. | sandbox/front-end-design/inspect/07-plots.png | accept the rounded warm-rose plots |
| 8 | One Heating Assistant overview page in the warm look: reading, rooms, start/stop, plots, schedule, controller jobs. | sandbox/front-end-design/inspect/08-example-home.png | delta: the first view is too busy |
| 9 | Light overview: house running, three room temperatures. House, a room, or Schedules opens the rest. | sandbox/front-end-design/inspect/09-overview-light.png, 09-overview-room.png | accept as the overview guide |

## Role
Promotion input. Supportive isolation — not production source.

## Tracker
- Task: MD-1
- Relates:
- Artifact: docs/agents/SANDBOX.md
- Branch: cursor/frontend-design-skill-f322
- PR: — (sandbox never opens a PR)

## Next
`/implement MD-1` — overview accepted; style guide is in FRONTEND-WARM and FRONTEND-ELEMENTS
