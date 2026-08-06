# Platform: Codex

Disclosed from [PLATFORM-CATALOGS.md](../PLATFORM-CATALOGS.md). Load only when this harness is detected.

OpenAI-only harness.

**Cost split:** Luna for Routine, Terra for Moderate, Sol for Demanding / manager.

## High-capability (ranked)

| Rank | Provider | Model | Slug (prefer) | Fallback |
|------|----------|-------|---------------|----------|
| 1 | OpenAI | GPT-5.6 Sol | `gpt-5.6-sol` | raise reasoning effort on Sol before leaving the row |

## Mid-capability (ranked)

| Rank | Provider | Model | Slug (prefer) | Fallback |
|------|----------|-------|---------------|----------|
| 1 | OpenAI | GPT-5.6 Terra | `gpt-5.6-terra` | — |

## Low-capability (ranked)

| Rank | Provider | Model | Slug (prefer) | Fallback |
|------|----------|-------|---------------|----------|
| 1 | OpenAI | GPT-5.6 Luna | `gpt-5.6-luna` | — |
