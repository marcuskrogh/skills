# Iterate: Drop list-only mutation from /test

## Prior work
- Task: MD-2 (campground closeout; closed at ship)
- PR: https://github.com/marcuskrogh/skills/pull/45
- Spec context: shipped `/test` tools (`skills/test/tools.md`, `mutate.py`)

## Problem
`/test` runs `mutate.py`, which only lists candidate mutants (cap 50). It does not apply a mutant or run the suite. Listing without kill/survive does not evaluate tests. That pass is valueless.

## Clarifications
- Operator chose nothing over a real mutation loop for this delta.
- CRAP analysis stays.

## Acceptance criteria
- `skills/test/tools/mutate.py` is gone.
- `/test` does not instruct a mutant-listing pass.
- Bundled CRAP runner and its tests remain.
- Listing candidates without running tests is not a testing pass.

## Out of scope
- Implementing a kill/survive mutation runner.
- Changing CRAP, campground, architect, or review.

## Work packages
1. Remove `mutate.py` and its unit tests; keep `crap.py` tests.
2. Drop mutation from `skills/test/SKILL.md` and `tools.md`.

## Tracker
- Task: MD-1
- Relates: PR #45 (prior MD-2)
- PR: https://github.com/marcuskrogh/skills/pull/46

## Next
`/ship MD-1` — Merge and close out
