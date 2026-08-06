# Platform: General

Disclosed from [PLATFORM-CATALOGS.md](../PLATFORM-CATALOGS.md). Load when the
harness is unknown/incomplete, or is not Cursor / Claude Code / Codex / Copilot.

Map harness IDs onto the rows below; skip unavailable rows. Prefer cheaper
open-weight / hosted picks that meet the tier. Hard exclusions (Fable 5, Haiku)
live in the catalog index.

## High-capability (ranked)

| Rank | Provider | Model | Prefer / map to |
|------|----------|-------|-----------------|
| 1 | DeepSeek | DeepSeek V4-Pro | `deepseek-v4-pro`, `deepseek-chat` Pro equivalent |
| 2 | Z.ai | GLM-5.2 | `glm-5.2`, `glm-5` latest coding |
| 3 | Anthropic | Claude Opus 5 | `opus`, `claude-opus-5` |
| 4 | Moonshot | Kimi K3 | `kimi-k3`, `kimi-k3-high`, K2.6 if K3 unavailable |
| 5 | xAI | Grok 4.5 | `grok-4.5`, `cursor-grok-4.5-high` |
| 6 | OpenAI | GPT-5.6 Sol | `gpt-5.6-sol` |

## Mid-capability (ranked)

| Rank | Provider | Model | Prefer / map to |
|------|----------|-------|-----------------|
| 1 | Google | Gemini 3.6 Flash | `gemini-3.6-flash` |
| 2 | OpenAI | GPT-5.6 Terra | `gpt-5.6-terra` |
| 3 | Anthropic | Claude Sonnet 5 | `sonnet`, `claude-sonnet-5` |
| 4 | Alibaba | Qwen3-Coder | `qwen3-coder`, latest Qwen coder instruct |
| 5 | Meta | Llama 4 Maverick | `llama-4-maverick` or harness Llama 4 coding mid |

## Low-capability (ranked)

| Rank | Provider | Model | Prefer / map to |
|------|----------|-------|-----------------|
| 1 | OpenAI | GPT-5.6 Luna | `gpt-5.6-luna` |
| 2 | Google | Gemini 3.5 Flash-Lite | `gemini-3.5-flash-lite`; `gemma-4` only if Flash-Lite unavailable |
| 3 | Cursor | Composer 2.5 | `composer-2.5` when exposed |
| 4 | MiniMax | MiniMax M3 | `minimax-m3` / latest MiniMax coding throughput SKU |

## Selection notes

1. Walk the category top-down; use the first model the harness exposes.
2. Prefer open-weight / cheaper hosted rows when they meet the tier.
3. If low has no row, use top mid for Routine, then escalate to high on failure.
4. One available model for the whole session → use it for manager and workers;
   still record difficulty.
5. Self-hosted open weights: treat GPU time as the price signal; stay on the
   highest-ranked available open model that fits hardware.
