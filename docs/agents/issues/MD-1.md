# MD-1: Replace Copilot's Gemini 4 Argon ceiling with Gemini 4 Carbon

| Field | Value |
|-------|-------|
| Type | Task |
| Status | In Progress |
| Parent | |
| Children | |
| Artifact | docs/agents/TWEAK.md |
| PR | |
| Created | 2026-11-14 |

## Summary

GitHub retires Gemini 4 Argon from Copilot on 2026-12-14. Gemini 4 Carbon replaces it as the preferred Copilot ceiling. Gemini 4 Hydrogen does not get a row.

## Acceptance

- Carbon is the preferred Copilot ceiling, slug `gemini-4-carbon`.
- Argon is gone from the Copilot page.
- Hydrogen and the other retiring Copilot models stay off the ranked rows.
- `general.md` and rule 1 in `PLATFORM-CATALOGS.md` still name Argon.

## Comments

### 2026-11-14
Approved tweak recorded. Architecture shape is on the branch. Outcome: ready.
Next: `/implement MD-1`. Build the Copilot ceiling change.

### 2026-11-14
Implement built the Copilot ceiling change. Outcome: built.

tests_added_or_updated: scripts/test_copilot_catalog.py; scripts/validate-skills.ps1
spec_locks: each pass-criteria row maps to scripts/test_copilot_catalog.py. The lock was red on the Argon page (7 checks), then green after the edit.
how_to_run: python3 scripts/test_copilot_catalog.py && python3 scripts/test_pipelines.py
result: pass
working_surfaces: none. This change is catalogue markdown and a file lock. No startable app.
coverage_notes: the lock reads github-copilot.md, general.md, PLATFORM-CATALOGS.md, cursor.md, claude-code.md, and codex.md.
testability_notes: no new seam. The lock is a file read.
structure_notes: touched units are the Copilot high-tier rows and the lock script. Names match the existing catalogue. No new layer.
crap: no nested conditional in the catalogue page. The lock uses one helper. Justified flat checks.
smells_fixed: none
seams: none added
exceptions: two stale mid-row needles in validate-skills.ps1 (GPT-5.6 Terra, and "when Terra is absent") now match the GPT-6.1 Terra rows already on the page. That page text was not part of this behaviour change.

Next: `/test MD-1`. The dedicated test pass checks the lock.
