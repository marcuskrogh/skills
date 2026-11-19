# Architecture: Copilot ceiling is Gemini 4 Neon

## Shape
- Lives: `skills/concepts/platforms/github-copilot.md` high-capability table and the cost-split paragraph above it. The same rank strings are locked in `scripts/test_copilot_catalog.py` and `scripts/validate-skills.ps1`. The moderate-work sentence lives in `templates/agent-install/harness/copilot.md`.
- Depends on: the catalog rules in `skills/concepts/PLATFORM-CATALOGS.md`. This task does not edit that file. Copilot remains the harness-specific page.
- Seams: the string locks. A wrong rank 3 row fails `scripts/test_copilot_catalog.py` and the Copilot section of `scripts/validate-skills.ps1`.
- Will not add: a new platform file, a price table, a MAI row, or edits to Cursor, Claude Code, Codex, or General.

## Neighbourhood
- Opened modules/boundaries: the existing Copilot catalogue page, its two string locks, and the Copilot install extract.
- Major refinement (or none): none

## Tracker
- Task: MD-1
- Branch: cursor/md-1-copilot-neon-3749
