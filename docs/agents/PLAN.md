# Implementation plan: Rank GPT-6.1 Terra as the mid workhorse

## Summary
- Replace the ranked mid-capability row GPT-5.6 Terra with GPT-6.1 Terra (`gpt-6.1-terra`) in the platform catalogs that name that row.
- Owner approved this plan in a prior session. This file records that approval.

## Scope / Decisions / Constraints
- In scope: `skills/concepts/PLATFORM-CATALOGS.md`, `skills/concepts/platforms/codex.md`, `skills/concepts/platforms/github-copilot.md`, `skills/concepts/platforms/general.md`.
- Out of scope: `skills/concepts/platforms/cursor.md`, `skills/concepts/platforms/claude-code.md`, `templates/agent-install/`. Cursor workers stay first-party Composer and Grok. Claude Code stays Anthropic-only.
- Mid rank 1 becomes GPT-6.1 Terra. Prefer slug `gpt-6.1-terra`.
- Existing fallbacks stay: Codex fallback `gpt-6-sol`; Copilot rank 2 GPT-6 Sol; General rank 2 GPT-6 Sol.
- Cost-split lines name the new generation: Codex "GPT-6.1 Terra for Moderate"; Copilot "GPT-6.1 Terra / Sol for Moderate"; General "Grok 4.7, GPT-6.1 Sol, and GPT-6.1 Terra".
- `PLATFORM-CATALOGS.md` uses `gpt-6.1-terra` wherever it names the Terra slug.
- Other prose mentions of Terra in these four files that mean the ranked mid row stay consistent with GPT-6.1 Terra.
- No price, date, or availability sentences. No retirement note.
- Rules unchanged: cost-first, catalog-closed, never Fable 5, never Haiku, Codex OpenAI-only, Copilot multi-vendor with no Fable or Haiku.

## Classification
- Class: refine
- Confidence: high
- Why: bounded catalogue docs; executable behaviour unchanged

## Workflow
- Template: structure-safe
- Parameters:
  - implement.mode: single
  - implement.verify: non-regression
  - implement.iteration: one-shot
  - test.mode: skip
  - harden.mode: dedicated
  - review.mode: single
  - review.depth: focused
  - review.lasers: bundled
  - side_paths: none
  - sandbox: none
- Chain: architect → implement → restructure → review → ship
- Rationale: docs-only refine; test skipped; harden stays dedicated; focused single review

## Inputs
- Research: none
- Model: none
- Sandbox: none

## Pass criteria
- none — no executable behaviour

## Work packages
1. Replace ranked GPT-5.6 Terra with GPT-6.1 Terra in the four in-scope catalog files, including cost-split lines and Terra prose that names the ranked mid row.

## Open items
- none

## Tracker
- Provider: markdown
- Story: none
- Task: MD-1
- Sub-tasks: none (single package)
- Branch: cursor/md-1-gpt-6-1-terra-966c
- PR: pending
- Classification: refine
- Workflow: structure-safe

## Next
`/review MD-1` — focused bundled review of the catalog diff
