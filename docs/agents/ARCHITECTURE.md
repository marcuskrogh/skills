# Architecture: Prefer GPT-6.1 Sol

## Shape
- Lives: prefer rows in `skills/concepts/platforms/codex.md`, `skills/concepts/platforms/github-copilot.md`, and `skills/concepts/platforms/general.md`; the efficient-pick sentence in `skills/concepts/PLATFORM-CATALOGS.md`; locks in `scripts/validate-skills.ps1`.
- Depends on: the existing heading slices and `Test-FileContains` / `Test-SectionLists` helpers. No new module.
- Seams: `scripts/validate-skills.ps1` is the check that locks the pass criteria. No new injectable boundary.
- Will not add: a platform file, a slug column on Copilot, a Cursor or Claude Code edit, or `gpt-6-terra`, Haiku, or Fable.

## Neighbourhood
- Opened modules/boundaries: catalogue index, Codex, Copilot, General, and the validator.
- Major refinement (or none): none

## Tracker
- Task: MD-1
- Branch: cursor/gpt-6-1-sol-prefer-e7ee
- PR: https://github.com/marcuskrogh/skills/pull/63

## Next
`/implement MD-1` — promote the prefer rows and lock them
