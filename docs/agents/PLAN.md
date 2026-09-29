# Implementation plan: Promote Claude Sonnet 5.5 on mid and low rows

## Summary
- Promote Claude Sonnet 5.5 (`claude-sonnet-5-5`) over Claude Sonnet 5 on the mid and low Anthropic catalogue rows that name Sonnet 5.
- Update the skill validator so those slugs are allowed, and so the Copilot mid check looks for Claude Sonnet 5.5.

## Scope / Decisions / Constraints
- In: `skills/concepts/platforms/claude-code.md` mid and low rows, and the cost-split line. `skills/concepts/platforms/github-copilot.md` mid rank 3 only. `skills/concepts/platforms/general.md` mid rank 4 only. `scripts/validate-skills.ps1` invent-ban list, Copilot mid needle, and the success line that still calls Sonnet 5.5 invented.
- Claude Code mid and low: model Claude Sonnet 5.5. Prefer `claude-sonnet-5-5` / `sonnet`. Fallback `claude-sonnet-5` (replaces `claude-sonnet-4-6` on those rows). Cost-split line names Sonnet 5.5 for Routine and Moderate.
- GitHub Copilot mid rank 3: name Claude Sonnet 5.5. Rank and the OpenAI-absent note stay. No slug column.
- General mid rank 4: Claude Sonnet 5.5. Prefer/map `claude-sonnet-5-5`, `sonnet`, `claude-sonnet-5`. Rank stays 4.
- Validator: drop `sonnet-5-5` and `claude-sonnet-5-5` from the invent-ban list. Keep `haiku-5-5`, `claude-haiku-5`, and `gpt-6-terra`. Copilot mid needle becomes `Claude Sonnet 5.5`.
- Out: `cursor.md`, `codex.md`, `PLATFORM-CATALOGS.md`. High rows stay Opus 5.5. Never Fable. Never Haiku. Cursor stays Composer and Grok. Claude Code stays Anthropic-only. Codex stays OpenAI-only.
- Sources: https://www.anthropic.com/claude-sonnet-5-5 , https://github.com/anthropics/claude-code/releases/tag/v2.1.284 , https://github.blog/changelog/2026-09-28-claude-sonnet-5-5-in-github-copilot/

## Classification
- Class: tweak
- Confidence: high
- Why: small intentional catalogue delta, not a defect and not a new feature slice

## Workflow
- Template: delta-fast
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
- Rationale: localized catalogue rows, one concern, no new layers; test and restructure stay in the chain

## Inputs
- Research: none
- Model: none
- Sandbox: none

## Pass criteria
- `claude-code.md` mid and low name Claude Sonnet 5.5, prefer `claude-sonnet-5-5` / `sonnet`, and fall back to `claude-sonnet-5`. The cost-split line names Sonnet 5.5 for Routine and Moderate.
- `github-copilot.md` mid rank 3 names Claude Sonnet 5.5. Rank stays 3. The OpenAI-absent note stays. No slug column is added.
- `general.md` mid rank 4 names Claude Sonnet 5.5 and maps `claude-sonnet-5-5`, `sonnet`, `claude-sonnet-5`. Rank stays 4.
- `scripts/validate-skills.ps1` no longer bans `sonnet-5-5` or `claude-sonnet-5-5`, still bans `haiku-5-5`, `claude-haiku-5`, and `gpt-6-terra`, looks for `Claude Sonnet 5.5` in the Copilot mid section, and its success line does not call Sonnet 5.5 invented.
- `scripts/validate-skills.ps1` exits 0.
- `cursor.md` and `codex.md` have an empty diff against `main`. High rows stay Opus 5.5. Fable and Haiku stay excluded. Cursor stays Composer and Grok. Claude Code stays Anthropic-only. Codex stays OpenAI-only.

## Work packages
1. Promote the named Sonnet 5.5 rows and the matching validator checks.

## Open items
- None.

## Tracker
- Provider: markdown
- Story: none
- Task: MD-1
- Sub-tasks: MD-2
- Branch: md-1-promote-sonnet-5-5
- PR: https://github.com/marcuskrogh/skills/pull/62
- Classification: tweak
- Workflow: delta-fast

## Next
`/test MD-1` — dedicated pass on the delivery diff
