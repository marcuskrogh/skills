# Implementation plan: Prefer GPT-6.1 Sol where GPT-6 Sol is the efficient OpenAI pick

## Summary
- Promote GPT-6.1 Sol (`gpt-6.1-sol`) to the efficient OpenAI demanding prefer where the catalogues still prefer GPT-6 Sol (`gpt-6-sol`).
- Keep `gpt-6-sol` as the prior-generation fallback on those rows. Leave mid Terra, low Luna, Cursor, and Claude Code as they are.

## Scope / Decisions / Constraints
- In: `skills/concepts/platforms/codex.md` high prefer becomes `gpt-6.1-sol`, with `gpt-6-sol` in that row's fallback cell. Mid prefer stays `gpt-5.6-terra`. Low prefer stays `gpt-6-luna`.
- In: `skills/concepts/platforms/github-copilot.md` high rank 2 becomes GPT-6.1 Sol, still the efficient OpenAI demanding pick. Rank 1 stays Grok 4.7. Rank 3 stays Claude Opus 5.5, used only after Grok or the Sol row is insufficient. Mid rank 2 stays GPT-6 Sol.
- In: `skills/concepts/platforms/general.md` high rank 2 becomes GPT-6.1 Sol mapped to `gpt-6.1-sol`, `gpt-6-sol`. Mid rank 2 stays GPT-6 Sol / `gpt-6-sol`.
- In: `skills/concepts/PLATFORM-CATALOGS.md` names GPT-6.1 Sol (`gpt-6.1-sol`) as the efficient OpenAI pick. Cursor first-party rule text stays as written.
- In: `scripts/validate-skills.ps1` locks the new prefer rows the same way neighbouring Sol, Opus, and Sonnet locks work.
- Out: Cursor (`cursor.md`) stays Composer and Grok only. No `*-fast`. No third-party slugs.
- Out: Claude Code stays Anthropic-only. Sonnet 5.5 mid and low, and Opus 5.5 high, stay as merged in PR #62.
- Out: do not add `gpt-6-terra`, Haiku 5.5, or Fable. Do not put `sonnet-5-5` or `claude-sonnet-5-5` back on the invent-ban list.
- Out: do not name a model a harness cannot run. Copilot rows stay prose (no new slug column).
- Evidence checked before this binding: OpenAI API docs list `gpt-6.1-sol` at $2 input and $10 output per 1M tokens, and describe near-Astra performance at a lower cost (https://developers.openai.com/api/docs/models/gpt-6.1-sol). The GPT-6 Sol page uses the same $2/$10 list price and points readers to GPT-6.1 Sol as the newer Sol model (https://developers.openai.com/api/docs/models/gpt-6-sol). Codex CLI `rust-v0.159.1` adds GPT-6.1 Sol as the default model in the bundled catalog; that tag's `models.json` slug is `gpt-6.1-sol` (https://github.com/openai/codex/releases/tag/rust-v0.159.1). GitHub Copilot changelog 2026-09-29 says GPT-6.1 Sol is generally available and rolling out in the picker for Pro+, Max, Business, and Enterprise (https://github.blog/changelog/2026-09-29-gpt-6-1-sol-in-github-copilot/). The launch post https://openai.com/index/introducing-gpt-6-1-sol/ returned HTTP 403 from this environment, so the API docs page is the official page this plan relies on.
- Live repo check: `main` at `abbb1bc` (PR #62). No `gpt-6.1-sol` hits. Open PR #60 is the frontend-design skill draft, not catalogue work.

## Classification
- Class: tweak
- Confidence: high
- Why: small intentional prefer change after a new model shipped, not a defect and not a new product slice

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
- Rationale: one catalogue concern, no new layer; test and restructure stay in the chain because the validator is executable

## Inputs
- Research: none
- Model: none
- Sandbox: none

## Pass criteria
- Codex high prefer slug is `gpt-6.1-sol` and that row's fallback is `gpt-6-sol`.
- Codex mid prefer stays `gpt-5.6-terra`, Codex low prefer stays `gpt-6-luna`, and `gpt-6-terra` is absent.
- GitHub Copilot high rank 2 names GPT-6.1 Sol, rank 1 stays Grok 4.7, and rank 3 stays Claude Opus 5.5.
- General high rank 2 names GPT-6.1 Sol and maps `gpt-6.1-sol` then `gpt-6-sol`. General mid rank 2 stays GPT-6 Sol mapped to `gpt-6-sol`.
- `PLATFORM-CATALOGS.md` names GPT-6.1 Sol (`gpt-6.1-sol`) as an efficient pick, and the Cursor first-party rule is unchanged.
- `scripts/validate-skills.ps1` locks those prefer rows, still bans `gpt-6-terra`, `haiku-5-5`, and `claude-haiku-5`, and does not ban `sonnet-5-5` or `claude-sonnet-5-5`.
- `pwsh -NoProfile -File scripts/validate-skills.ps1` exits 0.
- `skills/concepts/platforms/cursor.md` and `skills/concepts/platforms/claude-code.md` have no diff against `main`.

## Work packages
1. Promote the GPT-6.1 Sol prefer rows and lock them in the validator.

## Open items
- none

## Tracker
- Provider: markdown
- Story:
- Task: MD-1
- Sub-tasks: MD-2
- Branch: cursor/gpt-6-1-sol-prefer-e7ee
- PR: https://github.com/marcuskrogh/skills/pull/63
- Classification: tweak
- Workflow: delta-fast

## Next
`/review MD-1` — focused sequential review of the prefer rows
