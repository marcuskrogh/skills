# Platform: Claude Code

Disclosed from [PLATFORM-CATALOGS.md](../PLATFORM-CATALOGS.md). Load only when this harness is detected.

Anthropic-only harness. Use aliases the CLI resolves (`/model`, sub-agent model,
or env defaults). Prefer full IDs when pinning. **Do not** use `fable`, `best`,
or `haiku`.

**Cost split:** Sonnet for Routine and Moderate; Opus for Demanding / manager.

## High-capability (ranked)

| Rank | Provider | Model | Slug / alias (prefer) | Fallback |
|------|----------|-------|----------------------|----------|
| 1 | Anthropic | Claude Opus 5 | `opus` / `claude-opus-5` | `claude-opus-4-8` |

## Mid-capability (ranked)

| Rank | Provider | Model | Slug / alias (prefer) | Fallback |
|------|----------|-------|----------------------|----------|
| 1 | Anthropic | Claude Sonnet 5 | `sonnet` / `claude-sonnet-5` | `claude-sonnet-4-6` |

## Low-capability (ranked)

| Rank | Provider | Model | Slug / alias (prefer) | Fallback |
|------|----------|-------|----------------------|----------|
| 1 | Anthropic | Claude Sonnet 5 | `sonnet` / `claude-sonnet-5` | `claude-sonnet-4-6` |

