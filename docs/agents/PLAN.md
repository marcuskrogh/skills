# Implementation plan: Introduce refactoring as a structure keyword

## Summary
- Add **refactoring** as the ordinary word for behaviour-preserving structure edits.
- No new phase, class, or `/refactor` invoke. Campground, CRAP, and `/restructure` already produce those edits.

## Scope / Decisions / Constraints
- Single source of meaning: `CONCEPT_STRUCTURE` leading word.
- Skills and help point at that meaning; they do not restate a second definition.
- Do not rename `/restructure` or class **refine**.
- Docs-only; executable behaviour unchanged.

## Classification
- Class: refine
- Confidence: high
- Why: bounded skill/concept prose; naming only; no behaviour change

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
- Rationale: Purely non-behavioural docs; catalog skip row for `test.mode`. Harden stays dedicated.

## Inputs
- Research: none
- Model: none
- Sandbox: none

## Acceptance criteria
- **refactoring** is a leading word on `CONCEPT_STRUCTURE` (and the writing-for-agents token table).
- `/restructure`, CRAP, and campground prose use the word where the outcome is those edits.
- Help names the closeout pass as refactoring once.
- No new skill, phase, or class.

## Work packages
1. Concept + catalog + writing-for-agents token.
2. Restructure/harden/implement structure pointers; help; refine class line.

## Open items
- None

## Tracker
- Provider: markdown
- Story:
- Task: MD-1
- Sub-tasks:
- Branch: md-1-refactoring-keyword
- PR:
- Classification: refine
- Workflow: structure-safe

## Next
`/restructure MD-1` — Structure pass (same catalog as implement; small diffs included)
