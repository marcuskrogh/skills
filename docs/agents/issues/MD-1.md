# MD-1: Rank GPT-6.1 Terra as the mid workhorse

| Field | Value |
|-------|-------|
| Type | Task |
| Status | In Review |
| Parent | |
| Children | |
| Artifact | docs/agents/PLAN.md |
| PR | https://github.com/marcuskrogh/skills/pull/71 |
| Created | 2026-11-01 |

## Summary

Replace ranked GPT-5.6 Terra with GPT-6.1 Terra (`gpt-6.1-terra`) in the Codex, GitHub Copilot, General, and catalog-index files. Cursor and Claude Code catalogs stay as they are.

## Classification

- Class: refine
- Confidence: high
- Template: structure-safe
- Parameters: implement.mode single; implement.verify non-regression; implement.iteration one-shot; test.mode skip; harden.mode dedicated; review.mode single; review.depth focused; review.lasers bundled; side_paths none; sandbox none
- Chain: architect → implement → restructure → review → ship

## Acceptance

- none — no executable behaviour

## Comments

### 2026-11-01

Plan approved by the owner. Branch `cursor/md-1-gpt-6-1-terra-966c`. Outcome ready. Ticket framework empty, so the built-in status names stay. Plan commit `f901d87`.

Architect outcome ready. Shape is in `docs/agents/ARCHITECTURE.md`. No new module.

Implement outcome built. Single package on the manager (mode single, Routine docs edit).

```text
tests_added_or_updated: none — no executable behaviour
spec_locks: none — no executable behaviour
how_to_run: none — repo has no test or lint command
result: unavailable (no suite)
working_surfaces: none — catalog markdown only
coverage_notes: no executable paths
testability_notes: no seam introduced
structure_notes: revealing names and one-thing rows hold on the edited sentences; meets
crap: no function in the diff; score not applicable
smells_fixed: none
seams: none deliberately
exceptions: none
```

Non-regression: the four files still state the same selection rules. Cursor and Claude Code files are unchanged. Fallbacks `gpt-6-sol` and Copilot/General rank 2 GPT-6 Sol stay.

Restructure outcome ready. Touched units are markdown rows. No catalog breach and no refactoring to apply. Task is In Review.

## Next
`/review MD-1` — focused bundled review of the catalog diff
