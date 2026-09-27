# Architecture: Platform catalogue slug update

## Shape
- Lives: the platform catalogue files under `skills/concepts/platforms/`. General, Claude Code, and GitHub Copilot take the slug rows. Cursor and Codex stay in place when they already match the lock. The index `skills/concepts/PLATFORM-CATALOGS.md` is a neighbour, not a home for new rules.
- Depends on: the locked audit decisions and the existing catalogue table shape. No new module, no new loader, no new ranking type.
- Seams: `scripts/validate-skills.ps1` already checks that `cursor.md` stays on the Composer and Grok allowlist. That check is the seam. Do not add a second validator.
- Will not add: a new platform file, a new index rule, a Copilot API id the changelog does not publish, `gpt-6-terra`, Sonnet 5.5, Haiku 5.5, or any Cursor `*-fast` slug.

## Neighbourhood
- Opened modules/boundaries: `skills/concepts/platforms/general.md`, `claude-code.md`, `github-copilot.md`. Read-only neighbours: `cursor.md`, `codex.md`, `PLATFORM-CATALOGS.md`, `CONCEPT_DELEGATION.md`, `scripts/validate-skills.ps1`, `scripts/install-from-git.sh`.
- Major refinement (or none): none. The tables already have the right columns. Fill the locked cells. A stale prefer slug in a neighbour is fixed in that neighbour only when the grep shows it is an intentional reference.

## Tracker
- Task: MD-1
- Branch: cursor/md-1-platform-slugs-c226

## Next
`/implement MD-1` — Build to this shape
