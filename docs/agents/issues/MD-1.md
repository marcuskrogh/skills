# MD-1: Prefer GPT-6.1 Sol on efficient OpenAI rows

| Field | Value |
|-------|-------|
| Type | Task |
| Status | In Review |
| Parent | |
| Children | MD-2 |
| Artifact | docs/agents/PLAN.md |
| PR | https://github.com/marcuskrogh/skills/pull/63 |
| Created | 2026-09-30 |

## Summary
Promote GPT-6.1 Sol (`gpt-6.1-sol`) where Codex high, Copilot high rank 2, and General high rank 2 still prefer GPT-6 Sol. Keep `gpt-6-sol` as the prior fallback. Class: tweak. Template: delta-fast.

## Acceptance
- See pass criteria on `docs/agents/PLAN.md`.

## Comments

### 2026-09-30
Definition bound from the stated catalogue deltas. Classification: tweak. Workflow: delta-fast (implement.mode single, implement.verify tests, implement.iteration one-shot, test.mode dedicated, harden.mode dedicated, review.mode single, review.depth focused, review.lasers sequential, side_paths none, sandbox none). Chain: architect → implement → test → restructure → review → ship.

### 2026-09-30
Shape stamp in `docs/agents/ARCHITECTURE.md`. Task stays To Do. PR: https://github.com/marcuskrogh/skills/pull/63

### 2026-09-30
Package MD-2 built. Prefer rows and validator locks are on the branch. `pwsh -NoProfile -File scripts/validate-skills.ps1` exited 0. The new prefer locks were red on the previous rows, then green after the edit.

tests_added_or_updated: scripts/validate-skills.ps1
spec_locks: pass criteria rows → Test-PromotedGpt61Sol and the Copilot high needle in scripts/validate-skills.ps1
how_to_run: pwsh -NoProfile -File scripts/validate-skills.ps1
result: pass
working_surfaces: none — catalogue markdown and a local validator, no startable app
coverage_notes: prefer rows, index sentence, invent-ban, and untouched Cursor/Claude Code slug absence
testability_notes: no new seam; existing heading slices

### 2026-09-30
Testing pass. `pwsh -NoProfile -File scripts/validate-skills.ps1` exited 0 on the delivery head. Each pass-criteria row maps to a lock in `Test-PromotedGpt61Sol` or the Copilot high needle. `cursor.md` and `claude-code.md` have no diff against `main`. CRAP on `Test-PromotedGpt61Sol`: a handful of null checks, the function runs in the validator, score stays under 8. No working surface.

### 2026-09-30
Restructure pass. Split the Copilot high lock labels so rank 1 and rank 3 do not reuse the rank 2 prefix. No catalogue behaviour change. Validator exit 0. No other catalog breach on the touched rows. Task is In Review.

## Next
`/review MD-1` — focused sequential review of the prefer rows
