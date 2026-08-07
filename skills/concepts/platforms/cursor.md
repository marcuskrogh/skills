# Platform: Cursor

Disclosed from [PLATFORM-CATALOGS.md](../PLATFORM-CATALOGS.md). Load only when this harness is detected.

**Closed allowlist.** On Cursor, workers and managers use **only** Composer and
Grok. Every other slug in the harness picker (Claude, GPT, Kimi, Fable, …)
bills the **API budget** instead of the internal budget — never select them,
including for Cloud Agents, Desktop, and CLI.

**Detect Cursor when** any of: Cursor Desktop / Cloud / CLI session; Task /
sub-agent tool exposes `composer-*` or `cursor-grok-*` slugs; agent identity
names Cursor Grok / Composer. Do **not** fall through to General while on
Cursor.

When the harness exposes a `model` parameter on sub-agent / `Task` calls, pass
an explicit allowlisted slug on every worker spawn. **Cost split:** Composer
handles all Routine and Moderate workers; Grok handles Demanding workers and
is preferred for the manager.

## Allowed slugs (complete)

| Role | Prefer | Fallback only |
|------|--------|---------------|
| High / manager / Demanding worker | `cursor-grok-4.5-high` | `cursor-grok-4.5-high-fast` |
| Mid / Moderate worker | `composer-2.5` | `composer-2.5-fast` |
| Low / Routine worker | `composer-2.5` | `composer-2.5-fast` |

No other slug is legal on this platform. Off-allowlist request → remap to the
row for the scored category, then spawn.

## High-capability (ranked)

| Rank | Provider | Model | Slug (prefer) | Fallback |
|------|----------|-------|---------------|----------|
| 1 | Cursor / xAI | Cursor Grok 4.5 | `cursor-grok-4.5-high` | `cursor-grok-4.5-high-fast` |

## Mid-capability (ranked)

| Rank | Provider | Model | Slug (prefer) | Fallback |
|------|----------|-------|---------------|----------|
| 1 | Cursor | Composer 2.5 | `composer-2.5` | `composer-2.5-fast` |

## Low-capability (ranked)

| Rank | Provider | Model | Slug (prefer) | Fallback |
|------|----------|-------|---------------|----------|
| 1 | Cursor | Composer 2.5 | `composer-2.5` | `composer-2.5-fast` |
