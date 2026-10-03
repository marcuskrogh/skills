# Implementation plan: Presentation front page

## Summary

- Rewrite the repository front page so it can be presented as-is: a short description with the motivation, an installation guide, a functionality section (what it does and how you use it), then a list of chapters.
- The operator already set that four-part structure and asked to record it and proceed. Depth stays in the existing guide chapters. Images and examples stay on the front page.
- Executable behaviour is unchanged. This is a docs refine of `README.md` and the guide pages it points at.

## Scope / Decisions / Constraints

- In: `README.md` as the presentation. Images committed under `docs/guide/` so GitHub renders them. The same images copied to the project store `artifacts/screenshots/` with a `readme_` prefix, without overwriting existing files. Guide chapters rewritten only where the front page needs them to match, using the existing skills, workflows, help, guide, and install docs as the source of truth.
- Out: inventing skills, workflows, or install steps. The parked front-end design skill on pull request 60. Merging this pull request (the request asks for an open pull request; merge stays on ship).
- Behaviour: the front page is short enough to present. The four sections are present, in that order, with images and examples. Chapters hold pinning, updates, the skill catalog, and the other long material that used to sit on the front page.
- Constraints: spell names in full. Keep harness for the agent host. Operator-facing prose follows the language concept. The delivery branch name is `cursor/readme-presentation-ac69` because this Cursor cloud session requires that pattern.

## Classification

- Class: refine
- Confidence: high
- Why: Bounded docs rewrite of the README and the guide pages it links. Executable behaviour unchanged.

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
- Rationale: Docs-only refine. test.mode=skip is the docs exception. Harden stays dedicated. Review stays focused and single.

## Inputs

- Research: none
- Model: none
- Sandbox: none

## Pass criteria

- none — no executable behaviour

## Work packages

1. Rewrite `README.md` into the four-part presentation, align the guide chapters it links, and commit the front-page images under `docs/guide/`.

## Open items

- Pull request 60 stays untouched.
- Merge waits for ship.

## Tracker

- Provider: markdown
- Story: none
- Task: MD-1
- Sub-tasks: MD-2
- Branch: cursor/readme-presentation-ac69
- PR: (opened with this plan)
- Classification: refine
- Workflow: structure-safe
