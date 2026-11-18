# Architecture: GPT-6.2 catalogue rows

## Shape
- Lives: the existing platform catalogue pages and the string locks that quote them. The Codex always-on extract is `templates/agent-install/harness/codex.md`.
- Depends on: no new module. The pages stay disclosed from `PLATFORM-CATALOGS.md`.
- Seams: `scripts/test_copilot_catalog.py`, `scripts/validate-skills.ps1`, and `scripts/test-harness-install.sh` lock the rows.
- Will not add: a new platform file, a research brief, a sandbox tree, or rows on `cursor.md` and `claude-code.md`.

## Neighbourhood
- Opened modules/boundaries: `skills/concepts/platforms`, `skills/concepts/PLATFORM-CATALOGS.md`, the Codex install extract, and the three lock scripts.
- Major refinement (or none): none. The tables stay. The cells change.

## Tracker
- Task: MD-1
- Branch: cursor/md-1-gpt-6-2-catalogue-bee8

## Next
`/implement MD-1` — write the row changes
