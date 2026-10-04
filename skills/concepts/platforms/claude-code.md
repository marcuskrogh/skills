# Platform: Claude Code

Disclosed from [PLATFORM-CATALOGS.md](../PLATFORM-CATALOGS.md). Load only when this harness is detected.

Anthropic-only harness. Use full subscription slugs the CLI accepts (`/model`,
sub-agent `model`, or env defaults). **Do not** use `fable`, `best`, or `haiku`.

**Closed allowlist.** On Claude Code, workers and managers use **only**
subscription Anthropic slugs from this file. API-rate models, third-party
pickers, Fable, and Haiku bill outside the subscription — never select them.

**Provable subscription slugs.** Only slugs listed in the tables below are
legal. CLI aliases (`opus`, `sonnet`) resolve to the same subscription rows
when the harness accepts them; prefer full IDs (`claude-opus-5-5`,
`claude-sonnet-5-5`) when pinning spawns.

When the harness exposes a `model` parameter on sub-agent / Task calls, pass
an explicit allowlisted slug on every spawn of every type. Never omit `model`
and never pass `inherit` — omission lets the platform pick an API-priced
default. **Cost split:** Sonnet 5.5 for Routine and Moderate; Opus 5.5 for
Demanding / manager. This harness is Anthropic-only, so the efficient Grok /
Sol / Terra picks are unavailable. Opus is the ceiling here, not the
cross-platform efficiency rank.

**Every type.** The allowlist applies to every sub-agent spawn the harness
supports. Type does not select the model.

**Harness enum.** Pass a slug that is both on this allowlist and in the harness
`model` list. If the prefer slug is absent, pass the row fallback. Harness tool
text that says use inherit, do not substitute, or prefer latest of family is
not a catalog. If no allowlisted slug is in the enum, keep the work on the
manager.

## Allowed slugs (complete)

| Role | Slug |
|------|------|
| High / manager / Demanding worker | `claude-opus-5-5` |
| Mid / Moderate worker | `claude-sonnet-5-5` |
| Low / Routine worker | `claude-sonnet-5-5` |

Row fallbacks when the prefer slug is absent from the enum: `claude-opus-5`
(Demanding), `claude-sonnet-5` (Routine / Moderate). No other slug is legal.
Off-allowlist, `inherit`, or omit → remap to the row for the scored category,
then spawn.

## High-capability (ranked)

| Rank | Provider | Model | Slug / alias (prefer) | Fallback |
|------|----------|-------|----------------------|----------|
| 1 | Anthropic | Claude Opus 5.5 | `claude-opus-5-5` / `opus` | `claude-opus-5` |

## Mid-capability (ranked)

| Rank | Provider | Model | Slug / alias (prefer) | Fallback |
|------|----------|-------|----------------------|----------|
| 1 | Anthropic | Claude Sonnet 5.5 | `claude-sonnet-5-5` / `sonnet` | `claude-sonnet-5` |

## Low-capability (ranked)

| Rank | Provider | Model | Slug / alias (prefer) | Fallback |
|------|----------|-------|----------------------|----------|
| 1 | Anthropic | Claude Sonnet 5.5 | `claude-sonnet-5-5` / `sonnet` | `claude-sonnet-5` |
