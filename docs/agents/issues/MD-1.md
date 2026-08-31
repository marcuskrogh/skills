# MD-1: Drop list-only mutation from /test

| Field | Value |
|-------|-------|
| Type | Task |
| Status | In Progress |
| Parent | |
| Children | |
| Artifact | docs/agents/ITERATE.md |
| PR | https://github.com/marcuskrogh/skills/pull/46 |
| Relates | https://github.com/marcuskrogh/skills/pull/45 |
| Created | 2026-08-31 |

## Summary
Remove identification-only mutation from the `/test` phase. The bundled runner listed mutants and never ran tests. Keep CRAP.

## Acceptance
- `mutate.py` deleted; no `/test` step lists mutants without running the suite.
- CRAP tools and tests still ship.
- No kill/survive mutation runner in this Task.

## Comments

### 2026-08-31
Iterate from merged PR #45. Delivery PR: https://github.com/marcuskrogh/skills/pull/46. Next: `/test MD-1`
