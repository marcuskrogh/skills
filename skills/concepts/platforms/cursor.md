# Platform: Cursor

Disclosed from [PLATFORM-CATALOGS.md](../PLATFORM-CATALOGS.md). Load only when this harness is detected.

When the harness exposes a `model` parameter on sub-agent / `Task` calls.
**Cost split:** Composer handles all Routine and Moderate workers; Grok handles
Demanding workers and is preferred for the manager.

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
