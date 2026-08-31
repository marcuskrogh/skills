# MD-1: Drop list-only mutation from /test

| Field | Value |
|-------|-------|
| Type | Task |
| Status | In Review |
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

### 2026-08-31 (test)
CRAP on opened `tests.py` units: shape flat; scores 2–12 with coverage 0 (no XML) — evaluated, no cap. `crap.py` was not opened. Mutation listing tests removed with the tool. Remaining tests assert CRAP shape and formula. Working surfaces: none. `python skills/test/tools/tests.py` OK. Next: `/restructure MD-1`

### 2026-08-31 (restructure)
Touched units (`CrapTests`, `/test` skill and `tools.md`) meet the catalog. No extract, rename, or split. Neighbour `crap.py` unchanged and not worse. Next: `/review MD-1`

### 2026-08-31 (review)
Depth: focused; lasers: sequential (ITERATE.md, localized delta). Found / fixed / discarded: 0 / 0 / 0. CLEAN. Next: `/ship MD-1`
