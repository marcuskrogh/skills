# Platform: General

Disclosed from [PLATFORM-CATALOGS.md](../PLATFORM-CATALOGS.md). Load when the
harness is unknown/incomplete, or is not Cursor / Claude Code / Codex / Copilot.

Map harness IDs onto the rows below; skip unavailable rows. Rank is efficiency
(capability per cost): Grok 4.7, GPT-6 Sol, and Terra before capability ceilings.
Hard exclusions (Fable 5, Haiku) live in the catalog index.

## High-capability (ranked)

| Rank | Provider | Model | Prefer / map to |
|------|----------|-------|-----------------|
| 1 | xAI | Grok 4.7 | `grok-4.7-high`, `grok-4.7`, `cursor-grok-4.6-high` |
| 2 | OpenAI | GPT-6 Sol | `gpt-6-sol`, `gpt-5.6-sol` |
| 3 | DeepSeek | DeepSeek V4-Pro | `deepseek-v4-pro`, `deepseek-chat` Pro equivalent |
| 4 | Z.ai | GLM-5.2 | `glm-5.2`, `glm-5` latest coding |
| 5 | Anthropic | Claude Opus 5.5 | `claude-opus-5-5`, `claude-opus-5` — ceiling; worse efficiency than Grok or Sol |
| 6 | Moonshot | Kimi K3 | `kimi-k3`, `kimi-k3-high`, K2.6 if K3 unavailable |

## Mid-capability (ranked)

| Rank | Provider | Model | Prefer / map to |
|------|----------|-------|-----------------|
| 1 | OpenAI | GPT-5.6 Terra | `gpt-5.6-terra` |
| 2 | OpenAI | GPT-6 Sol | `gpt-6-sol` |
| 3 | Google | Gemini 3.6 Flash | `gemini-3.6-flash` |
| 4 | Anthropic | Claude Sonnet 5 | `sonnet`, `claude-sonnet-5` |
| 5 | Alibaba | Qwen3-Coder | `qwen3-coder`, latest Qwen coder instruct |
| 6 | Meta | Llama 4 Maverick | `llama-4-maverick` or harness Llama 4 coding mid |

## Low-capability (ranked)

| Rank | Provider | Model | Prefer / map to |
|------|----------|-------|-----------------|
| 1 | OpenAI | GPT-6 Luna | `gpt-6-luna`, `gpt-5.6-luna` |
| 2 | Google | Gemini 3.5 Flash-Lite | `gemini-3.5-flash-lite`; `gemma-4` only if Flash-Lite unavailable |
| 3 | Cursor | Composer 2.5 | `composer-2.5` when exposed |
| 4 | MiniMax | MiniMax M3 | `minimax-m3` / latest MiniMax coding throughput SKU |

## Selection notes

1. Walk the category top-down; use the first model the harness exposes.
2. Do not start on GPT-6 Astra or Opus when Grok, Sol, or Terra is available. Astra (`gpt-6-astra`) only after Sol is insufficient.
3. If low has no row, use top mid for Routine, then escalate to high on failure.
4. One available model for the whole session → use it for manager and workers;
   still record difficulty.
5. Self-hosted open weights: treat GPU time as the price signal; stay on the
   highest-ranked available open model that fits hardware.
