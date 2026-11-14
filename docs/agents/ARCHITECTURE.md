# Architecture: Copilot ceiling is Gemini 4 Carbon

## Shape
- Lives: `skills/concepts/platforms/github-copilot.md` (cost-split paragraph and high tier) and the Copilot ceiling rows in `scripts/validate-skills.ps1`
- Depends on: the catalog rules already in `PLATFORM-CATALOGS.md`. Those rules stay as they are. The Google prefer cell uses the Copilot picker id.
- Seams: `scripts/test_copilot_catalog.py` reads the Copilot page and the files this tweak must leave alone
- Will not add: a Hydrogen row, a new platform file, or edits to `cursor.md`, `claude-code.md`, `codex.md`, `general.md`, or rule 1 in `PLATFORM-CATALOGS.md`

## Neighbourhood
- Opened modules/boundaries: the GitHub Copilot platform page and its existing catalogue lock
- Major refinement (or none): none

## Tracker
- Task: MD-1
- Branch: cursor/md-1-copilot-carbon-5a46
