# Platform: Codex

Disclosed from [PLATFORM-CATALOGS.md](../PLATFORM-CATALOGS.md). Load only when this harness is detected.

OpenAI-only harness.

When the harness exposes a `model` parameter on sub-agent / Task calls, pass
an explicit catalog slug on every spawn of every type. Never omit `model` and
never pass `inherit` — omission lets the platform pick an off-catalog default.

**Cost split:** Luna for Routine, Terra for Moderate, GPT-6.1 Sol for Demanding / manager.
GPT-6 Astra is the capability ceiling, not the efficiency rank: pass
`gpt-6-astra` only after `gpt-6.1-sol` is insufficient on the same package.
`gpt-6-sol` stays the high-row fallback.

**Harness enum.** Pass a slug from the tables below that the harness accepts.
If the prefer slug is absent, pass the row fallback. If no catalog slug is in
the enum, keep the work on the manager.

## High-capability (ranked)

| Rank | Provider | Model | Slug (prefer) | Fallback |
|------|----------|-------|---------------|----------|
| 1 | OpenAI | GPT-6.1 Sol | `gpt-6.1-sol` | `gpt-6-sol` |

## Mid-capability (ranked)

| Rank | Provider | Model | Slug (prefer) | Fallback |
|------|----------|-------|---------------|----------|
| 1 | OpenAI | GPT-5.6 Terra | `gpt-5.6-terra` | `gpt-6-sol` |

## Low-capability (ranked)

| Rank | Provider | Model | Slug (prefer) | Fallback |
|------|----------|-------|---------------|----------|
| 1 | OpenAI | GPT-6 Luna | `gpt-6-luna` | `gpt-5.6-luna` |
