# MD-1: Platform catalogue slug update

| Field | Value |
|-------|-------|
| Type | Task |
| Status | In Review |
| Parent | |
| Children | MD-2 |
| Artifact | docs/agents/PLAN.md |
| PR | https://github.com/marcuskrogh/skills/pull/56 |
| Created | 2026-09-27 |

## Summary

Small intentional update of platform-catalogue prefer slugs from the locked 2026-09-27 audit. Class tweak, template delta-fast.

## Classification

- Class: tweak
- Confidence: high
- Why: small intentional change to which models the catalogues prefer

## Workflow

- Template: delta-fast
- Parameters: implement.mode single; implement.verify tests; implement.iteration one-shot; test.mode dedicated; harden.mode dedicated; review.mode single; review.depth focused; review.lasers sequential; side_paths none; sandbox none
- Chain: architect → implement → test → restructure → review → ship

## Acceptance

See pass criteria in `docs/agents/PLAN.md`.

## Comments

### 2026-09-27

Plan written. Classification tweak, template delta-fast. Branch `cursor/md-1-platform-slugs-c226`. PLAN.md at 222f24a. PR https://github.com/marcuskrogh/skills/pull/56.

### 2026-09-27

Shape stamp in `docs/agents/ARCHITECTURE.md`. Task stays To Do. Next: `/implement MD-1`

### 2026-09-27

Build done on the same PR. Spec locks are the new checks in `scripts/validate-skills.ps1`. They failed with 10 errors before the catalogue edit and passed after. Working surfaces: none, this repo has no startable app. Next: `/test MD-1`

### 2026-09-27

Testing pass on the same PR. Task stays In Progress.

Touched paths are markdown catalogues and `scripts/validate-skills.ps1`. `skills/test/tools/crap.py` skips non-Python files. Manual CRAP on `Test-FileContains`: two sequential gates, cyclomatic complexity 3, not nested. At coverage 0 the score is 12. That is a flat gate, not a nested conditional, so it stays.

Gap closed: the Claude Code fallback needle was a substring of `claude-opus-5-5`. It now requires the backticked slug `` `claude-opus-5` ``. A string that only has `` `claude-opus-5-5` `` does not match (checked). General prefer needles are backticked the same way, so `meta/muse-spark-1.3` does not satisfy `muse-spark-1.3`.

`pwsh -NoProfile -File scripts/validate-skills.ps1` passed. Working surfaces: none. Next: `/restructure MD-1`

### 2026-09-27

Restructure pass. Extracted `Get-HeadingSlice`, `Test-SectionLists`, and `Test-LockedPreferSlugs` so the heading slice is one function. Fail and OK lines are unchanged. Validator still passes. Catalogue tables were already one row per model, so they stayed. Task is In Review. Next: `/review MD-1`

```text
structure_notes: extracted the repeated heading slice; catalogue rows already matched neighbour tables; meets campground
crap: flat IndexOf gates; nested file/slug loop is a closed lookup and stays
smells_fixed: duplicated heading slice
seams: none added
exceptions: none
```

```text
tests_added_or_updated: scripts/validate-skills.ps1
spec_locks: pass criteria rows → scripts/validate-skills.ps1 (prefer slugs, stale model-name cells, Copilot high/mid/low, Codex mid, banned invented slugs, existing Cursor allowlist)
how_to_run: pwsh -NoProfile -File scripts/validate-skills.ps1
result: pass
working_surfaces: none — markdown catalogues and a validator script, no startable backend or frontend
coverage_notes: validator covers the locked prefer rows; Cursor allowlist check unchanged and still green
testability_notes: no new seam; the existing validator is the seam
structure_notes: touched catalogue rows and one validator block; names stay the existing table columns; no new module; meets campground on the edited rows
crap: no nested conditional extract; the new checks are flat IndexOf gates
smells_fixed: none
seams: scripts/validate-skills.ps1 (existing)
exceptions: none
```
