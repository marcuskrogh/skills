# MD-1: Prefer GPT-6.1 Sol on efficient OpenAI rows

| Field | Value |
|-------|-------|
| Type | Task |
| Status | To Do |
| Parent | |
| Children | MD-2 |
| Artifact | docs/agents/PLAN.md |
| PR | |
| Created | 2026-09-30 |

## Summary
Promote GPT-6.1 Sol (`gpt-6.1-sol`) where Codex high, Copilot high rank 2, and General high rank 2 still prefer GPT-6 Sol. Keep `gpt-6-sol` as the prior fallback. Class: tweak. Template: delta-fast.

## Acceptance
- See pass criteria on `docs/agents/PLAN.md`.

## Comments

### 2026-09-30
Definition bound from the stated catalogue deltas. Classification: tweak. Workflow: delta-fast (implement.mode single, implement.verify tests, implement.iteration one-shot, test.mode dedicated, harden.mode dedicated, review.mode single, review.depth focused, review.lasers sequential, side_paths none, sandbox none). Chain: architect → implement → test → restructure → review → ship.

## Next
`/architect MD-1` — record where the prefer-row edit sits
