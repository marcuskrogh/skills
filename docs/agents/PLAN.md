# Implementation plan: Pass criteria and spec locks

## Summary
- Define records **pass criteria** as checkable success rows, distinct from the specification.
- Implement writes a **spec lock** (automated check from that row) per pass-criteria row. `/test` audits the mapping.

## Scope / Decisions / Constraints
- Single source: CONCEPT_DEFINITION owns pass criteria; CONCEPT_IMPLEMENTATION owns spec lock.
- Replace `## Acceptance criteria` on definition artifacts with `## Pass criteria`. Legacy Acceptance rows still count as pass criteria.
- No new phase or skill. Docs-only; no `/refactor`-style invoke.
- Docs-only Tasks use `none — no executable behaviour`.

## Classification
- Class: refine
- Confidence: high
- Why: bounded skill/concept prose; no executable behaviour change

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
- Rationale: Docs-only; catalog skip for test. Harden stays dedicated.

## Inputs
- Research: none
- Model: none
- Sandbox: none

## Pass criteria
- PLAN.md, BUG.md, TWEAK.md, REFINE.md, REWORK.md, and ITERATE.md templates include `## Pass criteria` (not a second prose spec).
- CONCEPT_DEFINITION defines pass criteria as checkable rows distinct from the specification.
- CONCEPT_IMPLEMENTATION and testing.md require a spec lock per pass-criteria row (legacy Acceptance rows count).
- `/test` audits that mapping; review Spec checks spec locks, not only that the code matches the spec.
- No new skill, phase, or class.

## Work packages
1. Concepts + writing-for-agents tokens.
2. Define/bug/tweak/refine/rework/iterate artifacts and probes.
3. Implement testing.md, implement skill gate, `/test`, review Spec.

## Open items
- None

## Tracker
- Provider: markdown
- Story:
- Task: MD-1
- Sub-tasks:
- Branch: md-1-spec-lock-pass-criteria
- PR:
- Classification: refine
- Workflow: structure-safe

## Next
`/restructure MD-1` — Structure pass (same catalog as implement; small diffs included)
