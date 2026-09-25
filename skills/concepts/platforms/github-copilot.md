# Platform: GitHub Copilot

Disclosed from [PLATFORM-CATALOGS.md](../PLATFORM-CATALOGS.md). Load only when this harness is detected.

Copilot exposes a multi-vendor picker. Prefer the same category logic; use the
IDs the Copilot agent / IDE model picker accepts. **Never** pick Claude Fable 5
or Claude Haiku.

**Cost split:** Luna for Routine; Terra / Sol for Moderate; Grok for Demanding.
Opus 5.5 and GPT-6 Astra are capability ceilings: choose one only after Grok
or Sol is insufficient on the same package.

## High-capability (ranked)

| Rank | Provider | Model | Prefer |
|------|----------|-------|--------|
| 1 | xAI | Grok 4.7 | efficient frontier pick |
| 2 | OpenAI | GPT-6 Sol | efficient OpenAI demanding pick |

## Mid-capability (ranked)

| Rank | Provider | Model | Prefer |
|------|----------|-------|--------|
| 1 | OpenAI | GPT-5.6 Terra | efficient workhorse |
| 2 | OpenAI | GPT-6 Sol | when Terra is absent |
| 3 | Anthropic | Claude Sonnet 5 | when the OpenAI rows are absent |

## Low-capability (ranked)

| Rank | Provider | Model | Prefer |
|------|----------|-------|--------|
| 1 | OpenAI | GPT-6 Luna | value worker |
