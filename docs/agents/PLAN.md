# Implementation plan: Platform catalogue slug update

## Summary
- Update prefer slugs in the platform catalogues to the locked 2026-09-27 audit.
- The change is which model an agent is told to pick. Cursor, Codex, and the index rules already match the lock and stay as they are.

## Scope / Decisions / Constraints
- In: `skills/concepts/platforms/general.md`, `skills/concepts/platforms/claude-code.md`, `skills/concepts/platforms/github-copilot.md`.
- In: intentional stale prefer-slug references in validators, install scripts, and concepts, if a grep finds them after the catalogue edit.
- Out: `skills/concepts/platforms/cursor.md` and `skills/concepts/platforms/codex.md` except a verify pass. They already match the lock.
- Out: `skills/concepts/PLATFORM-CATALOGS.md` unless an index rule still names a stale prefer slug. Current index rules do not.
- Cursor high stays `grok-4.7-high` only when that slug is in the Task `model` enum. Otherwise `cursor-grok-4.6-high`, then `composer-2.5`. Mid and low stay `composer-2.5`. Composer and Grok only. No `*-fast`. No third-party picker slugs.
- Claude Code stays Anthropic-only. High prefer `claude-opus-5-5` and the `opus` alias. Fallback `claude-opus-5`. Mid and low stay Sonnet 5. Never Fable or Haiku.
- Codex stays OpenAI-only. High `gpt-6-sol`. Low `gpt-6-luna`. Mid stays `gpt-5.6-terra`. Do not add `gpt-6-terra`. Do not move mid onto Sol.
- GitHub Copilot high lists Grok 4.7, GPT-6 Sol, and Claude Opus 5.5 (ceiling, after Grok or Sol). Mid keeps GPT-5.6 Terra and Claude Sonnet 5. Low stays GPT-6 Luna. Never Fable or Haiku.
- General high: keep DeepSeek V4-Pro and Kimi K3. GLM prefer becomes `glm-5.3` (prior `glm-5.2`). Opus and Sol prefer slugs already match.
- General mid: Gemini prefer becomes `gemini-3.8-flash` (prior `gemini-3.6-flash`). Terra stays `gpt-5.6-terra`. Sonnet 5 stays. Qwen prefer becomes `qwen3.8-max` (official Model Studio id; prior Qwen coder instruct remains the fallback). Llama 4 Maverick prefer becomes `muse-spark-1.3` (harness form `meta/muse-spark-1.3` when that is what the harness lists).
- General low: keep `gpt-6-luna`, Gemini 3.5 Flash-Lite, Composer 2.5, and MiniMax M3. Do not promote M3.1-Flash-Preview.
- Do not invent `gpt-6-terra`, Sonnet 5.5, Haiku 5.5, or any Cursor `*-fast` slug.
- Do not invent a Copilot API id the GitHub changelog does not publish. Name the picker models the changelog announces.

## Classification
- Class: tweak
- Confidence: high
- Why: small intentional change to which models the catalogues prefer; not a defect, not a whole-tree structure pass, and not behaviour-preserving docs.

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
- Rationale: one catalogue concern, no new layers. Review stays focused and single. Test and restructure stay on because the prescribed model choice changes.

## Inputs
- Research: none (locked audit `uploads/AUDIT-2026-09-27.md`)
- Model: none
- Sandbox: none

## Pass criteria
- `general.md` prefer slugs are `glm-5.3`, `gemini-3.8-flash`, `qwen3.8-max`, and `muse-spark-1.3` on the rows the audit names, with prior-generation tokens only as fallbacks.
- `claude-code.md` high prefer includes `claude-opus-5-5` and `opus`, fallback `claude-opus-5`, and still forbids Fable and Haiku.
- `github-copilot.md` high lists Grok 4.7, GPT-6 Sol, and Claude Opus 5.5; mid still lists GPT-5.6 Terra and Claude Sonnet 5; low still lists GPT-6 Luna.
- `cursor.md` still allowlists only `composer-2.5`, `grok-4.7-high`, and `cursor-grok-4.6-high`, and still remaps a missing `grok-4.7-high` to `cursor-grok-4.6-high` then `composer-2.5`.
- `codex.md` mid prefer is still `gpt-5.6-terra`.
- A repo grep shows no prefer-slug use of `glm-5.2`, `gemini-3.6-flash`, `qwen3-coder`, or `llama-4-maverick` except as an explicit prior-generation fallback.
- No new `gpt-6-terra`, Sonnet 5.5, Haiku 5.5, or Cursor `*-fast` prefer slug.
- `scripts/validate-skills.ps1` still fails Cursor catalogues that leave the Composer and Grok allowlist.
- The pull request body cites an official URL for each changed slug.

## Work packages
1. Apply the locked slug rows in the platform files, then grep and fix any intentional stale prefer-slug left in validators, scripts, and concepts.

## Open items
- None. Audit decisions stay closed.

## Tracker
- Provider: markdown
- Story: none
- Task: MD-1
- Sub-tasks: MD-2
- Branch: cursor/md-1-platform-slugs-c226
- PR: (opened with this plan)
- Classification: tweak
- Workflow: delta-fast

## Next
`/architect MD-1` — Shape the catalogue edit on this branch before implementation.
