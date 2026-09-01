# Architecture: First-party Cursor subagents on Mobile Cloud

## Shape
- Lives: `skills/concepts/platforms/cursor.md` (allowlist + detection + enum remap); `skills/concepts/CONCEPT_DELEGATION.md` and `PLATFORM-CATALOGS.md` (routing invariants); always-on pointers (`AGENTS.md`, `CLAUDE.md`, `.cursor/rules/github-skills.mdc`, `templates/agent-install/*`); regression seam `scripts/validate-skills.ps1`.
- Depends on: existing catalog-closed Composer + Grok rows; validate-skills allowlist (no backtick-wrapped picker SKUs in `cursor.md`).
- Seams: string checks in `validate-skills.ps1` (Mobile, inherit forbidden, no General-on-incomplete, pointer remap).
- Will not add: new platform files, new allowlisted slugs, a spawn helper module, or a General exception for Cursor.

## Neighbourhood
- Opened modules/boundaries: Cursor platform catalog + always-on agent pointers (same neighbourhood as #28 / sandbox catalog-closed).
- Major refinement (or none): none — tighten detection and spawn contract in place.

## Tracker
- Task: MD-1
- Branch: cursor/first-party-cloud-subagents-5fab

## Next
`/test MD-1` — Dedicated testing phase (validate-skills regression)
