# Architecture: Promote Claude Sonnet 5.5 on mid and low rows

## Shape
- Lives: the platform catalogue tables in `skills/concepts/platforms/claude-code.md`, `github-copilot.md`, and `general.md`, and the checks in `scripts/validate-skills.ps1`.
- Depends on: the existing table columns and heading slices. No new module.
- Seams: `Test-ClaudeCodeCatalog`, `Test-CopilotCatalog`, and `Test-BannedPlatformSlugs` in `scripts/validate-skills.ps1`.
- Will not add: a slug column on Copilot, new platform files, or edits to `cursor.md`, `codex.md`, or `PLATFORM-CATALOGS.md`. High rows stay Opus 5.5. No Fable. No Haiku.

## Neighbourhood
- Opened modules/boundaries: those three catalogue files and the validator.
- Major refinement (or none): none

## Tracker
- Task: MD-1
- Branch: md-1-promote-sonnet-5-5
- PR: https://github.com/marcuskrogh/skills/pull/62
