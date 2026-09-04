# Implementation plan: Session working tree for local delivery

## Summary
- Pipeline checkout uses the folder the agent session was started in.
- Local Desktop/CLI operators can run the delivery head in the clone they opened.
- A second Git worktree is only for competing parallel attempts the operator asked for.

## Scope / Decisions / Constraints
- Scope in: delivery continuity, implementation branch discipline, Cursor worker spawn.
- Scope out: changing Cursor's own Agents Window / `/worktree` UI; sandbox isolation trees under `sandbox/`.
- Behaviour: agents check out the delivery branch in the session folder (`git switch` / `git checkout`).
- Constraint: Cloud Agent VMs already are a dedicated tree; still no extra linked worktree for ordinary packages.

## Classification
- Class: tweak
- Confidence: high
- Why: intentional agent-behaviour delta; not a product defect; docs/skills only

## Workflow
- Template: delta-fast
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
  - sandbox: none
- Chain: architect → implement → test → restructure → review → ship
- Rationale: docs-only skill prose; skip `/test`; keep harden + focused review

## Inputs
- Research: none
- Model: none
- Sandbox: none

## Pass criteria
- none — no executable behaviour

## Work packages
1. Record session-working-tree checkout on delivery + implementation + Cursor spawn.

## Open items
- none

## Tracker
- Provider: markdown
- Task: MD-1
- Sub-tasks: MD-2
- Branch: cursor/local-session-working-tree-0a5d
- PR: https://github.com/marcuskrogh/skills/pull/53
- Classification: tweak
- Workflow: delta-fast

## Next
`/ship MD-1` — Review CLEAN; closeout on the same PR
