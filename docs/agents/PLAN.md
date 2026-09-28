# Implementation plan: Front-end design skill

## Summary
- Add a **warm** front-end design skill for product-surface UI.
- Ground it in Heating Assistant as a read-only candidate: simplicity, low clutter, cream and terracotta, rounded modules. Not the teal/grey industrial look.
- Element references for plots, KPI cards, sections, climate cards, and the other recurring pieces in that app.

## Scope / Decisions / Constraints
- In: `skills/frontend-design`, `CONCEPT_FRONTEND`, `FRONTEND-WARM.md`, `FRONTEND-ELEMENTS.md`, `FRONTEND-CRAFT.md`, calibration HTML under `examples/frontend-design/`.
- Out: no edits, branches, or pull requests in Heating Assistant or other apps.
- Preferences stated by the user: simpler, less clutter, warmer colours, more rounded and warm elements.
- Prior skill on `cursor/frontend-design-concept-3aa3` still valid where it matches: tokens first, one signature, craft floor, Archivo, cream hull, terracotta accent, drop analog dials, air between groups. Default direction is **warm**, not retro-futuristic steel.

## Classification
- Class: feature
- Confidence: high
- Why: new invokable skill plus concept and catalogs; not a defect or structure-only change

## Workflow
- Template: feature-standard
- Parameters:
  - implement.mode: single
  - implement.verify: tests
  - implement.iteration: one-shot
  - test.mode: skip
  - harden.mode: dedicated
  - review.mode: single
  - review.depth: focused
  - review.lasers: sequential
  - side_paths: none
  - sandbox: inject
- Chain: architect → implement → sandbox inspect-loop → restructure → review → ship
- Rationale: docs-only in this repo (`test.mode=skip`); harden stays the floor; localized skill add keeps review focused; sandbox is the visual inspect-loop for the design sheet

## Inputs
- Research: none
- Model: none
- Sandbox: docs/agents/SANDBOX.md (`sandbox/front-end-design/`)
- Prior skill: commit `212b727` / branch `cursor/frontend-design-concept-3aa3`

## Pass criteria
- none — no executable behaviour

## Work packages
1. Concept, warm catalog, element catalog, craft floor, skill, plugin listing, README/help pointers
2. Calibration HTML for Heating Assistant jobs (overview, climate, plot)

## Open items
- Applying the look in Heating Assistant production files is a later Task in that repo

## Tracker
- Provider: markdown
- Story:
- Task: MD-1
- Sub-tasks: MD-2, MD-3
- Branch: cursor/frontend-design-skill-f322
- PR: https://github.com/marcuskrogh/skills/pull/60
- Classification: feature
- Workflow: feature-standard

## Next
`/sandbox MD-1` — inspect-loop; name a change, accept, or end
