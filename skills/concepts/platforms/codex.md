# Platform: Codex

Disclosed from [PLATFORM-CATALOGS.md](../PLATFORM-CATALOGS.md). Load only when this harness is detected.

OpenAI-only harness.

**Cost split:** Luna for Routine, Sol for Moderate, Astra for Demanding / manager.

## High-capability (ranked)

| Rank | Provider | Model | Slug (prefer) | Fallback |
|------|----------|-------|---------------|----------|
| 1 | OpenAI | GPT-6 Astra | `gpt-6-astra` | `gpt-5.6-sol` |

## Mid-capability (ranked)

| Rank | Provider | Model | Slug (prefer) | Fallback |
|------|----------|-------|---------------|----------|
| 1 | OpenAI | GPT-6 Sol | `gpt-6-sol` | `gpt-5.6-terra` |

## Low-capability (ranked)

| Rank | Provider | Model | Slug (prefer) | Fallback |
|------|----------|-------|---------------|----------|
| 1 | OpenAI | GPT-6 Luna | `gpt-6-luna` | `gpt-5.6-luna` |
