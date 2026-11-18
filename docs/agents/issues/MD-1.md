# MD-1: GPT-6.2 catalogue rows

| Field | Value |
|-------|-------|
| Type | Task |
| Status | In Review |
| Parent | |
| Children | MD-2 |
| Artifact | docs/agents/PLAN.md, docs/agents/ARCHITECTURE.md |
| PR | |
| Created | 2026-11-18 |

## Summary

Replace GPT-6.1 Sol with GPT-6.2 Sol as the Codex high pick and the Copilot high rank 2. Replace GPT-6 Astra with GPT-6.2 Astra as the ceiling. Keep GPT-6.1 Terra on the mid row.

## Acceptance

See pass criteria in `docs/agents/PLAN.md`.

## Comments

### 2026-11-18
Define outcome `ready`. Class tweak, template delta-fast. Owner pre-approved the plan in the catalogue routine. Branch `cursor/md-1-gpt-6-2-catalogue-bee8`.

### 2026-11-18
Architect outcome `ready`. Shape stamp in `docs/agents/ARCHITECTURE.md`. No new module.

### 2026-11-18
Implement outcome `built`. Single package on the manager. Codex high prefer is `gpt-6.2-sol` with fallback `gpt-6.1-sol`. Copilot high rank 2 is GPT-6.2 Sol. Ceiling text uses GPT-6.2 Astra. Mid Terra rows stayed. Codex install extract matches `codex.md`, including moderate `gpt-6.1-terra`.

structure_notes: existing tables and lock functions; no new module; meets the catalog
crap: no functions added; markdown and string locks
smells_fixed: none

### 2026-11-18
Test outcome `ready`. `python3 scripts/test_copilot_catalog.py`, `python3 scripts/test_pipelines.py`, `bash scripts/test-harness-install.sh`, and `scripts/validate-skills.ps1` passed. Spec locks cover the new Sol and Astra rows. The validator's three stale Terra locks (mid row still said GPT-5.6 Terra, and any backtick in the Copilot mid section counted as a new slug column) now match the GPT-6.1 Terra rows this change keeps.

### 2026-11-18
Restructure outcome `ready`. Touched units are catalogue tables and flat assertion lists. No extract. Task is In Review.

### 2026-11-18
Core laser should-fix: the index lock named `gpt-6.2-sol` and did not name GPT-6.2 Astra. Added that needle, and an omit for `GPT-6 Astra`, in `scripts/validate-skills.ps1` and `scripts/test_copilot_catalog.py`. Checks passed again. The backtick-to-slug-column lock change stays. It is the correction that lets the validator accept the existing Copilot mid slug.

## Next
`/review MD-1` — focused sequential lasers, then the pull-request review
