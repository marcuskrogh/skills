# Platform: GitHub Copilot

Disclosed from [PLATFORM-CATALOGS.md](../PLATFORM-CATALOGS.md). Load only when this harness is detected.

Copilot exposes a multi-vendor picker. Prefer the same category logic; use the
IDs the Copilot agent / IDE model picker accepts. **Never** pick Claude Fable 5
or Claude Haiku.

**Cost split:** Luna for Routine; Sonnet / Terra for Moderate; Opus / Grok / Sol
only for Demanding.

## High-capability (ranked)

| Rank | Provider | Model | Prefer |
|------|----------|-------|--------|
| 1 | Anthropic | Claude Opus 5 | elevated coding agent |
| 2 | xAI | Grok 4.6 | when the Copilot catalog exposes it |
| 3 | OpenAI | GPT-5.6 Sol | OpenAI frontier alternative |

## Mid-capability (ranked)

| Rank | Provider | Model | Prefer |
|------|----------|-------|--------|
| 1 | Anthropic | Claude Sonnet 5 | cost workhorse |
| 2 | OpenAI | GPT-5.6 Terra | OpenAI balanced worker |

## Low-capability (ranked)

| Rank | Provider | Model | Prefer |
|------|----------|-------|--------|
| 1 | OpenAI | GPT-5.6 Luna | value worker (Sonnet is mid-only on Copilot) |
