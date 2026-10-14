# Architecture: Rank Gemini 4 Argon as the preferred high ceiling

## Shape
- Lives: the high table in `skills/concepts/platforms/github-copilot.md`, the high table in `skills/concepts/platforms/general.md`, the ceiling sentence in `skills/concepts/PLATFORM-CATALOGS.md`, and the Copilot high-row locks in `scripts/validate-skills.ps1`.
- Depends on: the existing ranked tables and `Test-SectionLists` row locks. No new module.
- Seams: exact Copilot high-row strings in `scripts/validate-skills.ps1`. `pwsh -File scripts/validate-skills.ps1` is the check.
- Will not add: rows or slugs in `cursor.md`, `claude-code.md`, or `codex.md`. No prefer slug other than `gemini-4-argon` for this model. No Claude Fable 5, Claude Haiku, `cursor-grok-4.7`, bare `grok-*` prefer, or `*-fast`.

## Neighbourhood
- Opened modules/boundaries: platform catalogs and the validator that locks them.
- Major refinement (or none): none. The Copilot cost-split paragraph names the ceilings, so that paragraph names Gemini 4 Argon as the preferred ceiling without a second copy of the slug.

## Tracker
- Task: MD-1
- Branch: md-1-gemini-4-argon-copilot
