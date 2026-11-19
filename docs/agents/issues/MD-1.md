# MD-1: Copilot ceiling is Gemini 4 Neon

| Field | Value |
|-------|-------|
| Type | Task |
| Status | To Do |
| Parent | |
| Children | |
| Artifact | docs/agents/PLAN.md |
| PR | https://github.com/marcuskrogh/skills/pull/76 |
| Created | 2026-11-19 |

## Summary

Gemini 4 Neon becomes the GitHub Copilot preferred ceiling. Gemini 4 Carbon stays the fallback slug on that row. MAI Code 2 and MAI Code 2 Flash do not get a row. The Copilot install extract names GPT-6.1 Terra for moderate work.

## Classification

- Class: tweak
- Confidence: high
- Template: delta-fast
- Parameters: implement.mode single; implement.verify tests; implement.iteration one-shot; test.mode dedicated; harden.mode dedicated; review.mode single; review.depth focused; review.lasers sequential; side_paths none; sandbox none
- Chain: architect → implement → test → restructure → review → ship

## Acceptance

- High rank 3 is Gemini 4 Neon (`gemini-4-neon`) with fallback `gemini-4-carbon`.
- The cost-split sentence and the Opus row name Neon.
- MAI Code 2 and MAI Code 2 Flash are not ranked. The pull request states why.
- The Copilot install extract names GPT-6.1 Terra for moderate work.
- `scripts/test_copilot_catalog.py` and the Copilot locks in `scripts/validate-skills.ps1` pass.
- Cursor, Claude Code, Codex, General, and the catalog index do not gain a Neon or MAI row.

## Comments

### 2026-11-19

Plan pre-approved by Marcus's standing order in the invoke. Do not stop for plan approval. Ticket framework is empty, so the built-in status names stay. Outcome ready. Plan commit `1f1047f`. PR https://github.com/marcuskrogh/skills/pull/76.

MAI Code 2 and MAI Code 2 Flash are not added. GitHub publishes list prices that match GPT-6.1 Terra and GPT-6 Luna. The quality comparison is Microsoft's own bench, and the quoted cost ratio uses the promo price. No independent Artificial Analysis index row was found.

Architect outcome ready. Shape is in `docs/agents/ARCHITECTURE.md`. No new module. Task stays To Do.

## Next
`/implement MD-1` — edit the Copilot ceiling row and its locks
