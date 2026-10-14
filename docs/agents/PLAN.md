# Implementation plan: Rank Gemini 4 Argon as the preferred high ceiling

## Summary
- GitHub Copilot made Gemini 4 Argon generally available on 2026-10-13 for Pro+, Max, Business, and Enterprise. Copilot lists it as Powerful. Promotional price until 2026-12-01 is $2 input, $0.10 cached input, and $10 output per 1M tokens. Google model id is `gemini-4-argon`. Google list price after that date is $4 input and $20 output per 1M tokens.
- CursorBench Medium is 52.8% for Gemini 4 Argon and 52.5% for Claude Opus 5.5. Rank stays cost-first on token price. This task does not switch to cost-per-task ranking.
- The high catalogs still place Claude Opus 5.5 as the first ceiling after the efficient picks. Gemini 4 Argon is missing.

## Scope / Decisions / Constraints
- In: `skills/concepts/platforms/github-copilot.md` high order becomes Grok 4.7, GPT-6.1 Sol, Gemini 4 Argon (preferred ceiling, name `gemini-4-argon` once), then Claude Opus 5.5. Keep display names and a prefer note.
- In: `skills/concepts/platforms/general.md` high keeps Grok 4.7, GPT-6.1 Sol, DeepSeek V4-Pro, and GLM-5.3, then inserts Gemini 4 Argon (`gemini-4-argon`) immediately before Claude Opus 5.5. Mid stays Gemini 3.8 Flash.
- In: `skills/concepts/PLATFORM-CATALOGS.md` updates only the ceiling sentence so Gemini 4 Argon is the preferred ceiling.
- In: `scripts/validate-skills.ps1` locks the new Copilot high rows and exits 0.
- Out: `cursor.md`, `claude-code.md`, and `codex.md` stay unchanged.
- Out: no Claude Fable 5, no Claude Haiku, no `cursor-grok-4.7`, no bare `grok-*` prefer slug, no `*-fast`.
- Catalogue tip at definition: `92272df` (PR #66).

## Classification
- Class: bug
- Confidence: high
- Why: the high catalogs omit a GA ceiling that the efficiency order should list before Claude Opus 5.5.

## Workflow
- Template: fix-fast
- Parameters:
  - implement.mode: single
  - implement.verify: tests
  - implement.iteration: one-shot
  - test.mode: dedicated
  - harden.mode: dedicated
  - review.mode: single
  - review.depth: focused
  - review.lasers: sequential
  - side_paths: none
  - sandbox: none
- Chain: architect → implement → test → restructure → review → ship
- Rationale: one localized catalog defect, so the manager implements once. Test and restructure stay in the chain. Review stays focused and sequential.

## Inputs
- Research: none
- Model: none
- Sandbox: none

## Pass criteria
- `github-copilot.md` high order is Grok 4.7, GPT-6.1 Sol, Gemini 4 Argon, Claude Opus 5.5, and the file names `gemini-4-argon` once.
- `general.md` high order keeps Grok 4.7, GPT-6.1 Sol, DeepSeek V4-Pro, GLM-5.3, then Gemini 4 Argon (`gemini-4-argon`) immediately before Claude Opus 5.5. The mid row stays Gemini 3.8 Flash.
- `PLATFORM-CATALOGS.md` ceiling sentence names Gemini 4 Argon (`gemini-4-argon`) as the preferred ceiling. No other sentence in that file changes.
- `scripts/validate-skills.ps1` locks those Copilot high rows and exits 0.
- `cursor.md`, `claude-code.md`, and `codex.md` have an empty diff.

## Work packages
1. Update the Copilot high rows, the general high insert, the ceiling sentence, and the Copilot row locks.

## Open items
- After 2026-12-01 the Argon list price is $4 input and $20 output per 1M tokens, the same list price as Claude Opus 5.5. This task does not re-rank for that date.

## Tracker
- Provider: markdown
- Story: none
- Task: MD-1
- Sub-tasks: MD-2
- Branch: md-1-gemini-4-argon-copilot
- PR: pending on this branch
- Classification: bug
- Workflow: fix-fast

## Next
`/ship MD-1` — the catalog change is reviewed and still needs merge
