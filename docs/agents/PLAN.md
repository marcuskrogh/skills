# Implementation plan: Copilot ceiling is Gemini 4 Neon

## Summary
- Gemini 4 Neon becomes the GitHub Copilot preferred ceiling (high rank 3). Gemini 4 Carbon stays on that row as the fallback slug.
- MAI Code 2 and MAI Code 2 Flash do not get a ranked row.
- The Copilot install extract names GPT-6.1 Terra for moderate work.
- Marcus's standing order in the invoke pre-approved this plan and said not to stop for plan approval.

## Scope / Decisions / Constraints
- In scope: `skills/concepts/platforms/github-copilot.md`, `templates/agent-install/harness/copilot.md`, `scripts/test_copilot_catalog.py`, and the Copilot row locks in `scripts/validate-skills.ps1` (those locks name the current rank 3 row and would fail if left on Carbon).
- Out of scope: `skills/concepts/platforms/cursor.md`, `skills/concepts/platforms/claude-code.md`, `skills/concepts/platforms/codex.md`, `skills/concepts/platforms/general.md`, and `skills/concepts/PLATFORM-CATALOGS.md`. The index still names Gemini 4 Argon as the cross-platform ceiling. Copilot is the only page that changes.
- High rank 1 stays Grok 4.7. High rank 2 stays GPT-6.2 Sol (`gpt-6.2-sol`, fallback `gpt-6.1-sol`). Mid and low rows stay as they are.
- High rank 3 becomes: Gemini 4 Neon, prefer slug `gemini-4-neon`, fallback slug `gemini-4-carbon`. One Google row in this category. Carbon is the prior generation and is still generally available in Copilot, so it stays the fallback slug on that row.
- The cost-split sentence names Gemini 4 Neon as the preferred capability ceiling. The Opus row says the ceiling applies after Gemini 4 Neon is insufficient.
- No prices, dates, or availability sentences on the catalogue page. Ranks only.
- Rules unchanged: cost-first, catalog-closed, never Claude Fable 5, never Haiku, Copilot may rank more than one vendor.
- Slug: GitHub's supported-models page lists the display name Gemini 4 Neon (`gemini_4_neon`) and does not print a picker token. The Copilot pricing table uses that display name at $3 input, $0.15 cached input, and $15 output per 1M tokens. LiteLLM records the Copilot provider id as `github_copilot/gemini-4-neon`. Google's Carbon API id is `gemini-4-carbon`. The catalogue slug is `gemini-4-neon`.
- Standing price, not the Carbon intro. GitHub's pricing footnote bills Carbon at $2 input and $10 output until 2026-12-01, then $4, $0.20 cached, and $20. Neon has no promo row: $3, $0.15, $15. From 2026-12-01 Neon is the cheaper token price. Google (2026-11-18) says quality close to Carbon, faster starts, fewer unrequested changes, fewer unsupported claims, and about 32% lower cost per task than Carbon at the default high thinking level. Artificial Analysis lists Carbon (high) at index 60 and $7.76 per index task on the $4/$20 price. Google cites Artificial Analysis index 61 for Neon at xhigh. That 61 is Google's citation. The rank does not depend on the one-point gap: at the standing price Neon costs less per token, and Google reports a lower cost per task at similar quality.
- Neon does not pass Grok or GPT-6.2 Sol. Copilot bills Grok 4.7 at $2 input and $6 output, and GPT-6.2 Sol at $2 and $10. Neon at $3 and $15 is the ceiling, not the efficient frontier.
- MAI Code 2 and MAI Code 2 Flash do not get a mid or low row. GitHub publishes prices. Code 2 is $0.50 / $0.025 / $2.50 until 2027-05-17, then $1 / $0.05 / $5. Flash is $0.05 / $0.005 / $0.25 until 2027-05-17, then $0.10 / $0.01 / $0.50. List price matches GPT-6.1 Terra ($1 / $5) and GPT-6 Luna ($0.10 / $0.50). Microsoft's 2026-11-17 announcement says Code 2 reaches about 98% of GPT-6.1 Sol at about 40% of the price, and Flash matches GPT-6 Luna at about 65% of the price. Those pass rates are Microsoft's average of DeepSWE 1.1, Terminal-Bench 2.1, SWE Atlas, and FrontierCode v1.1, with three of the four run on Microsoft's MSBench, and the cost ratio uses the promo price. No Artificial Analysis Intelligence Index row was found for either model. Vendor quality claims do not earn a row. At list price neither model is cheaper than the current mid or low pick.
- Install extract: `templates/agent-install/harness/copilot.md` says "GPT-5.6 Terra or GPT-6 Sol" for moderate work. The catalogue mid prefer is GPT-6.1 Terra. The sentence names GPT-6.1 Terra for moderate work.

## Classification
- Class: tweak
- Confidence: high
- Why: small intentional change to the Copilot preferred ceiling and one stale install sentence

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
- Rationale: one catalogue page, its string locks, and one install sentence; test and harden stay on; review stays focused and sequential

## Inputs
- Research: none
- Model: none
- Sandbox: none

## Pass criteria
- `skills/concepts/platforms/github-copilot.md` high rank 3 is Gemini 4 Neon with prefer slug `gemini-4-neon` and fallback slug `gemini-4-carbon`.
- That file's cost-split sentence names Gemini 4 Neon as the preferred capability ceiling, and the Opus row names the ceiling after Gemini 4 Neon.
- High ranks 1 and 2, and the mid and low rows, stay on Grok 4.7, GPT-6.2 Sol, GPT-6.1 Terra, GPT-6 Sol, Claude Sonnet 5.5, and GPT-6 Luna.
- MAI Code 2 and MAI Code 2 Flash are absent from the Copilot ranked rows. The pull request states why they were not added.
- `templates/agent-install/harness/copilot.md` names GPT-6.1 Terra for moderate work and does not name GPT-5.6 Terra.
- `scripts/test_copilot_catalog.py` locks the rows above and passes. The Copilot locks in `scripts/validate-skills.ps1` match the same rows.
- Cursor, Claude Code, Codex, General, and `PLATFORM-CATALOGS.md` do not gain a Neon or MAI row.

## Work packages
1. Update the Copilot ceiling row, the install extract, and the string locks that name that row.

## Open items
- none

## Tracker
- Provider: markdown
- Story: none
- Task: MD-1
- Sub-tasks: none (single package)
- Branch: cursor/md-1-copilot-neon-3749
- PR: https://github.com/marcuskrogh/skills/pull/76
- Classification: tweak
- Workflow: delta-fast

## Next
`/review MD-1` — focused sequential review of the catalogue diff
