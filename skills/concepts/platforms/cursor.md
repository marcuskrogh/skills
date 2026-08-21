# Platform: Cursor

Disclosed from [PLATFORM-CATALOGS.md](../PLATFORM-CATALOGS.md). Load only when this harness is detected.

**Closed allowlist.** On Cursor, workers and managers use **only** Composer and
Grok. Every other slug in the harness picker (Claude, GPT, Gemini, Kimi, Fable, …)
bills the **API budget** instead of the internal budget — never select them,
including for Cloud Agents, Desktop, and CLI.

**No fast variants.** Never pass any `*-fast` SKU. Use the standard prefer
slugs only.

**Detect Cursor when** any of: Cursor Desktop / Cloud / CLI session; Task /
sub-agent tool exposes `composer-*` or `cursor-grok-*` slugs; agent identity
names Cursor Grok / Composer. Do **not** fall through to General while on
Cursor.

When the harness exposes a `model` parameter on sub-agent / `Task` calls, pass
an explicit allowlisted slug on every spawn of every type. **Cost split:**
Composer handles all Routine and Moderate workers; Grok handles Demanding
workers and is preferred for the manager.

**Every type.** The allowlist applies to every `Task` spawn: `generalPurpose`,
`explore`, `computerUse`, `videoReview`, `cursor-guide`, `best-of-n-runner`,
and any later type. Type does not select the model. `computerUse` and
`videoReview` receive `composer-2.5` or `cursor-grok-4.6-high` like any other
worker.

**Manager path.** GUI walkthroughs and image or video checks the manager can
do with RecordScreen or Read stay on the manager. A spawned `computerUse` or
`videoReview` Task still receives the catalog slug.

**Harness enum.** Pass a slug that is both on this allowlist and in the harness
Task `model` enum. If the category prefer slug is absent from the enum, pass
the other allowlisted slug the enum contains (`composer-2.5`). Fast and
third-party slugs stay illegal even when the enum lists them.

## Allowed slugs (complete)

| Role | Slug |
|------|------|
| High / manager / Demanding worker | `cursor-grok-4.6-high` |
| Mid / Moderate worker | `composer-2.5` |
| Low / Routine worker | `composer-2.5` |

No other slug is legal on this platform. Off-allowlist or `*-fast` request →
remap to the row for the scored category, then spawn.

## High-capability (ranked)

| Rank | Provider | Model | Slug |
|------|----------|-------|------|
| 1 | Cursor / xAI | Cursor Grok 4.6 | `cursor-grok-4.6-high` |

## Mid-capability (ranked)

| Rank | Provider | Model | Slug |
|------|----------|-------|------|
| 1 | Cursor | Composer 2.5 | `composer-2.5` |

## Low-capability (ranked)

| Rank | Provider | Model | Slug |
|------|----------|-------|------|
| 1 | Cursor | Composer 2.5 | `composer-2.5` |
