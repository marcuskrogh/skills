# Implementation plan: GPT-6.2 catalogue rows

## Summary
- Replace GPT-6.1 Sol with GPT-6.2 Sol as the Codex high pick and the Copilot high rank 2. The API price is the same, and OpenAI describes 6.2 Sol as smarter and more token-efficient.
- Replace GPT-6 Astra with GPT-6.2 Astra as the capability ceiling in Codex, Copilot, General, and the catalogue index.
- Keep GPT-6.1 Terra as the mid workhorse. Keep Copilot rank 1 on Grok 4.7 and rank 3 on Gemini 4 Carbon.
- The owner pre-approved this plan in the 2026-11-18 catalogue routine. The readiness prompt is treated as answered so the run does not stop at that gate.

## Scope / Decisions / Constraints

In:

- `skills/concepts/platforms/codex.md`
- `skills/concepts/platforms/github-copilot.md`
- `skills/concepts/platforms/general.md`
- `skills/concepts/PLATFORM-CATALOGS.md`
- `templates/agent-install/harness/codex.md` (the Codex always-on extract names the slugs this change replaces)
- `scripts/validate-skills.ps1`, `scripts/test_copilot_catalog.py`, and `scripts/test-harness-install.sh` where they lock those rows

Out:

- `skills/concepts/platforms/cursor.md` and `skills/concepts/platforms/claude-code.md`
- Codex and Copilot mid and low rows, except the Codex install extract's moderate slug (below)
- Fable, Haiku, and any fast or Ultrafast slug
- `templates/agent-install/harness/copilot.md` (it does not name GPT-6.1 Sol or GPT-6 Astra; demanding stays Grok 4.7)

Decisions, checked on 2026-11-18:

- Slugs are `gpt-6.2-sol` and `gpt-6.2-astra`.
  - OpenAI API: [GPT-6.2 Sol](https://developers.openai.com/api/docs/models/gpt-6.2-sol), [GPT-6.2 Astra](https://developers.openai.com/api/docs/models/gpt-6.2-astra), [pricing](https://developers.openai.com/api/docs/pricing).
  - Announcement: [Introducing GPT-6.2 Astra and Sol](https://openai.com/index/introducing-gpt-6-2-astra-sol/). Available in ChatGPT Work, Codex, and the API. Codex CLI uses `codex --model gpt-6.2-sol` and `/model` ([Models](https://learn.chatgpt.com/docs/models)).
  - Copilot: both are GA for Pro+, Max, Business, and Enterprise ([changelog](https://github.blog/changelog/2026-11-17-openais-gpt-6-2-astra-and-gpt-6-2-sol-now-available/)). List prices are on [Models and pricing](https://docs.github.com/en/copilot/reference/copilot-billing/models-and-pricing). Those docs use the display names. This catalogue already writes Copilot OpenAI rows with the API slug (`gpt-6.1-terra`). Use `gpt-6.2-sol` and `gpt-6.2-astra` the same way.
- Short-context price per 1M tokens: GPT-6.2 Sol $2 input / $0.10 cached / $10 output, the same as GPT-6.1 Sol. GPT-6.2 Astra $8 / $0.40 / $40, 20% below GPT-6 Astra ($10 / $1 / $50) on input and output. GPT-6.1 Terra $1 / $5. Copilot Grok 4.7 $2 / $6. Gemini 4 Carbon $2 / $10 through 2026-12-01, then $4 / $20. Opus 5.5 $4 / $20.
- OpenAI: GPT-6.2 Sol is within 0.5 points of GPT-6.2 Astra on FrontierCode 2.0 at about one fifth the cost. GPT-6.2 Astra beats GPT-6 Astra on the benchmarks in the announcement.
- The mid row stays. Terra remains the cheaper workhorse. GPT-6 Sol stays the mid fallback when Terra is absent.
- Copilot order stays Grok 4.7, then Sol, then Gemini 4 Carbon, then Opus 5.5. Carbon stays the preferred ceiling. Grok's output price stays below Sol. Carbon's promotional token price matches Sol until 2026-12-01 and then doubles, so it does not become the efficient pick.
- The Codex install extract currently prefers `gpt-5.6-terra` for moderate work. That slug is not the prefer slug in `codex.md` (`gpt-6.1-terra`). Set the extract to `gpt-6.1-terra` while updating the demanding slug and the ceiling, so the always-on line matches the platform file.

Constraints: cost-first, catalog-closed, never Fable, never Haiku, Codex stays OpenAI-only, Copilot may rank more than one vendor, no `*-fast` or Ultrafast slug.

## Classification
- Class: tweak
- Confidence: high
- Why: a small intentional change to which model the catalogues prefer, after the 2026-11-17 release. The previous rows were the right rows when they were written.

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
- Rationale: one catalogue concern and existing string locks. Test and restructure stay in the chain. The official pages were checked before this plan, so there is no research side path.

## Inputs
- Research: none. Sources are cited under Decisions.
- Model: none
- Sandbox: none

## Pass criteria
- `codex.md` high prefer slug is `gpt-6.2-sol` and the fallback slug is `gpt-6.1-sol`.
- `codex.md` says to pass `gpt-6.2-astra` only after `gpt-6.2-sol` is insufficient.
- `codex.md` mid prefer slug stays `gpt-6.1-terra`.
- `github-copilot.md` high rank 1 stays Grok 4.7, rank 2 is GPT-6.2 Sol, rank 3 stays Gemini 4 Carbon, and rank 4 stays Claude Opus 5.5.
- `github-copilot.md` still says Gemini 4 Carbon is the preferred capability ceiling, and the other named ceiling is GPT-6.2 Astra.
- `github-copilot.md` mid rank 1 stays GPT-6.1 Terra.
- `general.md` high rank 2 prefer slug is `gpt-6.2-sol`, with `gpt-6.1-sol` as the prior slug on that row.
- `PLATFORM-CATALOGS.md` rule 1 names `gpt-6.2-sol` as the efficient OpenAI pick and GPT-6.2 Astra as a ceiling.
- `cursor.md` and `claude-code.md` do not gain `gpt-6.2-sol` or `gpt-6.2-astra`.
- The Codex install extract prefers `gpt-6.2-sol` for demanding work and `gpt-6.2-astra` as the ceiling.
- `python3 scripts/test_copilot_catalog.py` passes.
- `bash scripts/test-harness-install.sh` passes.
- `scripts/validate-skills.ps1` passes.

## Work packages
1. Update the catalogue rows, the Codex install extract, and the string locks that name the old Sol and Astra picks.

## Open items
- `templates/agent-install/harness/copilot.md` still says GPT-5.6 Terra or GPT-6 Sol for moderate work. Left as a follow-up. Demanding stays Grok 4.7.
- Copilot's own docs publish display names. `gpt-6.2-sol` is the OpenAI model id, used here in the same way as `gpt-6.1-terra`.

## Tracker
- Provider: markdown
- Story: none
- Task: MD-1
- Sub-tasks: MD-2
- Branch: cursor/md-1-gpt-6-2-catalogue-bee8
- PR:
- Classification: tweak
- Workflow: delta-fast

## Next
`/architect MD-1` — record where the row edits sit
