# MD-1: Promote Claude Sonnet 5.5 on mid and low rows

| Field | Value |
|-------|-------|
| Type | Task |
| Status | To Do |
| Parent | |
| Children | MD-2 |
| Artifact | docs/agents/PLAN.md |
| PR | |
| Created | 2026-09-29 |

## Summary

Promote Claude Sonnet 5.5 over Claude Sonnet 5 on the mid and low Anthropic catalogue rows that name Sonnet 5, and allow those slugs in the skill validator.

## Acceptance

- Claude Code mid and low use Claude Sonnet 5.5, prefer `claude-sonnet-5-5` / `sonnet`, fallback `claude-sonnet-5`.
- Copilot mid rank 3 names Claude Sonnet 5.5. General mid rank 4 maps the same model.
- `scripts/validate-skills.ps1` exits 0. `cursor.md` and `codex.md` are unchanged.

## Comments

### 2026-09-29
Plan approved by the catalogue owner. Classification tweak, template delta-fast. Branch `md-1-promote-sonnet-5-5`.

## Next
`/architect MD-1` — shape stamp, then the bound chain continues
