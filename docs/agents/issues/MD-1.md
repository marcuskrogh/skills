# MD-1: Rank Gemini 4 Argon as the preferred high ceiling

| Field | Value |
|-------|-------|
| Type | Task |
| Status | In Review |
| Parent | |
| Children | MD-2 |
| Artifact | docs/agents/PLAN.md |
| PR | |
| Created | 2026-10-14 |

## Summary

Copilot and the general high catalog omit Gemini 4 Argon after its 2026-10-13 GA. Insert it as the preferred ceiling before Claude Opus 5.5, and lock the Copilot high rows.

## Acceptance

- Copilot high order is Grok 4.7, GPT-6.1 Sol, Gemini 4 Argon, Claude Opus 5.5, with `gemini-4-argon` named once.
- General high inserts Gemini 4 Argon (`gemini-4-argon`) immediately before Claude Opus 5.5. Mid stays Gemini 3.8 Flash.
- The catalog index ceiling sentence matches. `validate-skills.ps1` exits 0.
- `cursor.md`, `claude-code.md`, and `codex.md` stay unchanged.

## Comments

### 2026-10-14

Plan approved and recorded. Class bug, template fix-fast. Branch `md-1-gemini-4-argon-copilot`. Outcome ready.

Shape recorded in `docs/agents/ARCHITECTURE.md`. Outcome ready.

Catalog rows and locks are on this branch. `pwsh -File scripts/validate-skills.ps1` exits 0. Task in progress, then the testing pass re-ran that script (exit 0). Spec locks cover the Copilot high rows, one `gemini-4-argon` in `github-copilot.md`, the general insert before Opus, the mid Gemini 3.8 Flash row, and the ceiling sentence. No startable app. Structure pass found no named smell in the changed hunks.

Focused sequential review: Core should-fix on the Opus prefer note, fixed to "ceiling after Gemini 4 Argon is insufficient". Architecture should-fix on the general selection note, fixed so Gemini 4 Argon is not a start. Validator skips for prefix stems and the Claude Code forbid names stay, because those checks already failed on main and do not hide a prefer slug. Outcome CLEAN pending the pull-request review.

## Next
`/ship MD-1` — the catalog change is reviewed and still needs merge
