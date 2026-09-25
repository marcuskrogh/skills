# Platform: Codex

Disclosed from [PLATFORM-CATALOGS.md](../PLATFORM-CATALOGS.md). Load only when this harness is detected.

OpenAI-only harness.

**Cost split:** Luna for Routine, Terra for Moderate, Sol for Demanding / manager.
GPT-6 Astra is the capability ceiling, not the efficiency rank: pass
`gpt-6-astra` only after `gpt-6-sol` is insufficient on the same package.

## High-capability (ranked)

| Rank | Provider | Model | Slug (prefer) | Fallback |
|------|----------|-------|---------------|----------|
| 1 | OpenAI | GPT-6 Sol | `gpt-6-sol` | `gpt-5.6-terra` |

## Mid-capability (ranked)

| Rank | Provider | Model | Slug (prefer) | Fallback |
|------|----------|-------|---------------|----------|
| 1 | OpenAI | GPT-5.6 Terra | `gpt-5.6-terra` | `gpt-6-sol` |

## Low-capability (ranked)

| Rank | Provider | Model | Slug (prefer) | Fallback |
|------|----------|-------|---------------|----------|
| 1 | OpenAI | GPT-6 Luna | `gpt-6-luna` | `gpt-5.6-luna` |
