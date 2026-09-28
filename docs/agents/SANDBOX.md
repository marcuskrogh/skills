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
- Relevant areas: runtime (static HTML/CSS, Archivo, Chrome render), data (dummy Heating Assistant jobs: KPIs, living-room climate, plot, schedule, form, banner, empty/error), neighbours (current industrial tokens beside proposed warm tokens), path (element jobs from `FRONTEND-ELEMENTS.md`, tokens from `industrial.css` vs `FRONTEND-WARM.md`), baseline (current column copies industrial hull `#1a1d23`, accent `#00d4aa`, radius `8px`)
- How reproduced: `sheet.html` stages each element twice; current column uses industrial tokens; proposed column uses cream/terracotta/`1.5rem`
- Gaps: live Heating Assistant websocket, real room history, and `industrial.css` host wiring. FLIP motion (220ms) and scroll-into-view are named, not played in this still. Operator scope: Heating Assistant is read-only. Those gaps cannot move a token verdict. The open-card layout is in the sheet.

## Bar
- Scenario: the representative map above (not a simplified stand-in)

## Promote map
- Production targets: `skills/concepts/FRONTEND-WARM.md`, `skills/concepts/FRONTEND-ELEMENTS.md`, `examples/frontend-design/`
- Copy notes: accepted `--p-*` values become named tokens in `FRONTEND-WARM.md`; accepted proposed blocks update element rules; calibration HTML follows the same tokens. User-facing sheet copy: `/cursor/stores/self/docs/front-end-design-sheet.html`

## Iterations
| N | Change | Inspectable | Verdict |
|---|--------|-------------|---------|
| 1 | initial extract | sandbox/front-end-design/inspect/01-tokens-nav-kpi.png, 01-countdown-climate-plot.png, 01-banner-empty.png, 01-sheet-top.png | delta: show the jobs, not only the resting look |
| 2 | KPI expand: one open card moves first, spans the row, detail stays on the card. Current dark inset vs proposed cream detail. Clickable in `sheet.html`. | sandbox/front-end-design/inspect/02-kpi-expand.png | delta: waiting on whether this open state matches |

## Role
Promotion input. Supportive isolation — not production source.

## Tracker
- Task: MD-1
- Relates:
- Artifact: docs/agents/SANDBOX.md
- Branch: cursor/frontend-design-skill-f322
- PR: — (sandbox never opens a PR)

## Next
`/sandbox MD-1` — inspect-loop; name a change, accept, or end
