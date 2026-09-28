# Implementation plan: Repository guide

## Summary
- Write a wiki-style guide for marcuskrogh/skills.
- `README.md` stays an overview plus a complete install guide.
- Linked pages under `docs/guide/` hold structure, how it works, workflows, skills, concepts, examples, and extra install depth.
- Source of truth is the existing skills, workflows, help, guide, and install docs. Do not invent skills, workflows, or install steps.

## Scope / Decisions / Constraints
- In: operator-facing guide in this repo (`README.md` + `docs/guide/`).
- In: consistent description of each element (how, where, outputs, which workflows).
- In: complete description of structure, contents, how it works, and how it is used.
- Out: Heating Assistant.
- Out: front-end design skill work on pull request 60 (`cursor/frontend-design-skill-f322`). If the front page mentions a skill, describe only what is already on `main`.
- Out: inventing skills, workflows, or install steps. Unclear items are stated as unclear on the page.
- Front page stays scannable. Depth lives on linked pages.
- New branch from `main`. Open a pull request against `main`.
- Docs that agents read follow writing-for-agents where it applies. Operator-facing prose follows CONCEPT_LANGUAGE.

## Classification
- Class: refine
- Confidence: high
- Why: bounded docs and README work with no executable behaviour change

## Workflow
- Template: structure-safe
- Parameters:
  - implement.mode: single
  - implement.verify: non-regression
  - implement.iteration: one-shot
  - test.mode: skip
  - harden.mode: dedicated
  - review.mode: single
  - review.depth: focused
  - review.lasers: sequential
  - side_paths: none
  - sandbox: none
- Chain: architect → implement → restructure → review → ship
- Rationale: docs-only refine; skip tests; keep restructure and review.

## Inputs
- Research: none
- Model: none
- Sandbox: none

## Pass criteria
- none — no executable behaviour

## Work packages
1. Front page: scannable overview and a complete install guide on `README.md`
2. Linked pages: structure, how it works, and workflows
3. Linked pages: skills catalog and concepts catalog
4. Linked pages: application examples and extra install depth
5. Pipeline artifacts for this Task (`PLAN.md`, `ARCHITECTURE.md`, markdown issues)

## Open items
- None. Skill list is `plugin.json` plus folders on `main`. Front-end design is not on `main`.

## Tracker
- Provider: markdown
- Story: (none)
- Task: MD-1
- Sub-tasks: MD-2, MD-3, MD-4, MD-5
- Branch: cursor/skills-repository-guide-4766
- PR: https://github.com/marcuskrogh/skills/pull/61
- Classification: refine
- Workflow: structure-safe

## Next
`/ship MD-1` — merge remaining closeout when ready
