# Architecture: Rank GPT-6.1 Terra as the mid workhorse

## Shape
- Lives: platform catalog docs. The index is `skills/concepts/PLATFORM-CATALOGS.md`. The ranked rows live in `skills/concepts/platforms/codex.md`, `skills/concepts/platforms/github-copilot.md`, and `skills/concepts/platforms/general.md`.
- Depends on: those files only. No code, tests, or install templates.
- Seams: none. There is no executable behaviour to inject.
- Will not add: a new platform file, a new rank, a price or availability sentence, a retirement note, or edits to `platforms/cursor.md`, `platforms/claude-code.md`, or `templates/agent-install/`.

## Neighbourhood
- Opened modules/boundaries: the mid-capability rank-1 row and the cost-split lines that name that row.
- Major refinement: none.

## Tracker
- Task: MD-1
- Branch: cursor/md-1-gpt-6-1-terra-966c
