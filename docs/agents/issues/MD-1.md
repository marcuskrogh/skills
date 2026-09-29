# MD-1: Promote Claude Sonnet 5.5 on mid and low rows

| Field | Value |
|-------|-------|
| Type | Task |
| Status | In Review |
| Parent | |
| Children | MD-2 |
| Artifact | docs/agents/PLAN.md |
| PR | https://github.com/marcuskrogh/skills/pull/62 |
| Created | 2026-09-29 |

## Summary

Promote Claude Sonnet 5.5 over Claude Sonnet 5 on the mid and low Anthropic catalogue rows that name Sonnet 5, and allow those slugs in the skill validator.

## Acceptance

- Claude Code mid and low use Claude Sonnet 5.5, prefer `claude-sonnet-5-5` / `sonnet`, fallback `claude-sonnet-5`.
- Copilot mid rank 3 names Claude Sonnet 5.5. General mid rank 4 maps the same model.
- `scripts/validate-skills.ps1` exits 0. `cursor.md` and `codex.md` are unchanged.

## Comments

### 2026-09-29
Plan approved by the catalogue owner. Classification tweak, template delta-fast. Branch `md-1-promote-sonnet-5-5`. Pull request https://github.com/marcuskrogh/skills/pull/62.

### 2026-09-29
`docs/agents/ARCHITECTURE.md` is on the delivery branch. Outcome ready. Task stays To Do.

### 2026-09-29
Implementation is on the branch. `scripts/validate-skills.ps1` was red (10 errors) on the old rows, then green. Sub-task MD-2 is Done. Task stays In Progress.

structure_notes: catalogue tables and one validator function. Names match the rows. No new layer. meets.
crap: evaluated in the testing pass on `scripts/validate-skills.ps1`.
smells_fixed: none
seams: heading slices and the invent-ban line, already in the script
exceptions: none
working_surfaces: none. These files are catalogues and a checker. No startable app.

### 2026-09-29
Testing pass. `scripts/validate-skills.ps1` exits 0. Spec locks live in `Test-PromotedSonnet55` and the Copilot mid needle. They were red (10 errors) before the catalogue text changed. Copilot and General high rows are locked to Claude Opus 5.5. A missing invent-ban line fails instead of throwing. `cursor.md` and `codex.md` have an empty diff against `origin/main`. CRAP: `skills/test/tools/crap.py` parses Python only, so the PowerShell functions were counted by hand. `Test-HighStaysOpus` is a flat or (complexity about 3). `Test-PromotedSonnet55` is a sequence of checks with one loop level. Working surfaces: none.

### 2026-09-29
Restructure pass. The repeated high-row check is `Test-HighStaysOpus`. Catalogue behaviour is unchanged. Validator still exits 0. Task is In Review.

## Next
`/review MD-1` — focused sequential lasers, then code review
