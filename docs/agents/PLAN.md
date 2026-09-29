# Implementation plan: Front-end design skill

## Summary
- The **warm** front-end design skill is the accepted direction: a light first screen, Atkinson Hyperlegible, paper `#f3ebe3`, sheet `#fffaf6`, ink `#2a221c`, clay `#d4532b`, sage `#6d8b6f`, honey `#e3a15a`, plum `#8f5d78`, mute `#8d7f74`, rounded `1.75rem` surfaces, and opaque rose `#c48474` only on infeasible plot regions.
- Style guide: `skills/concepts/FRONTEND-WARM.md` and `skills/concepts/FRONTEND-ELEMENTS.md`. Heating Assistant is read-only.

## Scope / Decisions / Constraints
- In: `skills/frontend-design`, `CONCEPT_FRONTEND`, `FRONTEND-WARM.md`, `FRONTEND-ELEMENTS.md`, `FRONTEND-CRAFT.md`, calibration HTML under `examples/frontend-design/`.
- Out: no edits, branches, or pull requests in Heating Assistant or other apps.
- Preferences stated by the user, and accepted: light first screen; Atkinson Hyperlegible; the palette and rose plot rule above; deeper information on House, a room, Schedules, or a nav page. The earlier Archivo / cream-and-terracotta restyle is retired.

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
