# MD-1: Rank GPT-6.1 Terra as the mid workhorse

| Field | Value |
|-------|-------|
| Type | Task |
| Status | To Do |
| Parent | |
| Children | |
| Artifact | docs/agents/PLAN.md |
| PR | |
| Created | 2026-11-01 |

## Summary

Replace ranked GPT-5.6 Terra with GPT-6.1 Terra (`gpt-6.1-terra`) in the Codex, GitHub Copilot, General, and catalog-index files. Cursor and Claude Code catalogs stay as they are.

## Classification

- Class: refine
- Confidence: high
- Template: structure-safe
- Parameters: implement.mode single; implement.verify non-regression; implement.iteration one-shot; test.mode skip; harden.mode dedicated; review.mode single; review.depth focused; review.lasers bundled; side_paths none; sandbox none
- Chain: architect → implement → restructure → review → ship

## Acceptance

- none — no executable behaviour

## Comments

### 2026-11-01

Plan approved by the owner. Branch `cursor/md-1-gpt-6-1-terra-966c`. Outcome ready. Ticket framework empty, so the built-in status names stay.

## Next
`/architect MD-1` — record where the catalog edit sits
