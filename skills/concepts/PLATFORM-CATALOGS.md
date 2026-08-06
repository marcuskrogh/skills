# Platform catalogs (delegation)

Disclosed reference for [CONCEPT_DELEGATION](CONCEPT_DELEGATION.md). Load when
scoring difficulty and picking a worker model. Ranks are preference order for
**this skills repo**; WORKSPACE or skill overrides win when present.

## Catalog rules

1. **Cost first** — for each harness, prefer the cheapest model that can do the
   work. In practice this usually means one **cost workhorse** for both
   **low** and **mid**, and a single **premium** model for **high** (see Cursor:
   Composer for Routine/Moderate, Grok for Demanding). Do not introduce extra
   mid-tier brands when the workhorse already covers Moderate.
2. **One model per provider** per category — do not list multiple Claude, GPT, or
   Grok generations side by side. Prefer the current cost-efficient pick for that
   provider; put prior generations only as that row’s fallback slug.
3. **Never Fable 5** — do not select Claude Fable 5 (`fable`, `claude-fable-5`,
   thinking variants, or aliases like `best` that resolve to Fable). It has a
   special data policy this repo avoids.
4. **Never Haiku** — do not select Claude Haiku (any version) for workers or
   managers.
5. Fast / mini / prior-gen variants are **fallbacks for the same row**, not
   separate ranked picks.
6. **Same slug for low and mid** is allowed (and preferred when cost-optimal).
   If low and mid resolve to the same model, an insufficient report escalates
   **directly to high** — do not re-spawn the same model as a no-op mid retry.

### Cursor

When the harness exposes a `model` parameter on sub-agent / `Task` calls.
**Cost split:** Composer handles all Routine and Moderate workers; Grok handles
Demanding workers and is preferred for the manager.

#### High-capability (ranked)

| Rank | Provider | Model | Slug (prefer) | Fallback |
|------|----------|-------|---------------|----------|
| 1 | Cursor / xAI | Cursor Grok 4.5 | `cursor-grok-4.5-high` | `cursor-grok-4.5-high-fast` |

#### Mid-capability (ranked)

| Rank | Provider | Model | Slug (prefer) | Fallback |
|------|----------|-------|---------------|----------|
| 1 | Cursor | Composer 2.5 | `composer-2.5` | `composer-2.5-fast` |

#### Low-capability (ranked)

| Rank | Provider | Model | Slug (prefer) | Fallback |
|------|----------|-------|---------------|----------|
| 1 | Cursor | Composer 2.5 | `composer-2.5` | `composer-2.5-fast` |

### Claude Code

Anthropic-only harness. Use aliases the CLI resolves (`/model`, sub-agent model,
or env defaults). Prefer full IDs when pinning. **Do not** use `fable`, `best`,
or `haiku`.

**Cost split:** Sonnet for Routine and Moderate; Opus for Demanding / manager.

#### High-capability (ranked)

| Rank | Provider | Model | Slug / alias (prefer) | Fallback |
|------|----------|-------|----------------------|----------|
| 1 | Anthropic | Claude Opus 5 | `opus` / `claude-opus-5` | `claude-opus-4-8` |

#### Mid-capability (ranked)

| Rank | Provider | Model | Slug / alias (prefer) | Fallback |
|------|----------|-------|----------------------|----------|
| 1 | Anthropic | Claude Sonnet 5 | `sonnet` / `claude-sonnet-5` | `claude-sonnet-4-6` |

#### Low-capability (ranked)

| Rank | Provider | Model | Slug / alias (prefer) | Fallback |
|------|----------|-------|----------------------|----------|
| 1 | Anthropic | Claude Sonnet 5 | `sonnet` / `claude-sonnet-5` | `claude-sonnet-4-6` |

### Codex (OpenAI)

OpenAI-only harness.

**Cost split:** Luna for Routine, Terra for Moderate, Sol for Demanding / manager.

#### High-capability (ranked)

| Rank | Provider | Model | Slug (prefer) | Fallback |
|------|----------|-------|---------------|----------|
| 1 | OpenAI | GPT-5.6 Sol | `gpt-5.6-sol` | raise reasoning effort on Sol before leaving the row |

#### Mid-capability (ranked)

| Rank | Provider | Model | Slug (prefer) | Fallback |
|------|----------|-------|---------------|----------|
| 1 | OpenAI | GPT-5.6 Terra | `gpt-5.6-terra` | — |

#### Low-capability (ranked)

| Rank | Provider | Model | Slug (prefer) | Fallback |
|------|----------|-------|---------------|----------|
| 1 | OpenAI | GPT-5.6 Luna | `gpt-5.6-luna` | — |

### GitHub Copilot

Copilot exposes a multi-vendor picker. Prefer the same category logic; use the
IDs the Copilot agent / IDE model picker accepts. **Never** pick Claude Fable 5
or Claude Haiku.

**Cost split:** Luna for Routine; Sonnet / Terra for Moderate; Opus / Grok / Sol
only for Demanding.

#### High-capability (ranked)

| Rank | Provider | Model | Prefer |
|------|----------|-------|--------|
| 1 | Anthropic | Claude Opus 5 | elevated coding agent |
| 2 | xAI | Grok 4.5 | when the Copilot catalog exposes it |
| 3 | OpenAI | GPT-5.6 Sol | OpenAI frontier alternative |

#### Mid-capability (ranked)

| Rank | Provider | Model | Prefer |
|------|----------|-------|--------|
| 1 | Anthropic | Claude Sonnet 5 | cost workhorse |
| 2 | OpenAI | GPT-5.6 Terra | OpenAI balanced worker |

#### Low-capability (ranked)

| Rank | Provider | Model | Prefer |
|------|----------|-------|--------|
| 1 | OpenAI | GPT-5.6 Luna | value worker (Sonnet is mid-only on Copilot) |

### General (any other harness)

Use when the harness is **not** Cursor, Claude Code, Codex, or GitHub Copilot —
or when those catalogs are incomplete and you must choose among exposed models.

Map harness-specific IDs/aliases onto the rows below. Skip any row the session
cannot call. **Never** select Claude Fable 5 (or aliases that resolve to it) or
Claude Haiku.

Open-weight and third-party models are **first-class** here: when a cheaper
open-weight (or other) model is capable enough for the tier, prefer it over a
costlier closed frontier pick.

#### Price / capability basis (approx. API / hosted list, Aug 2026)

| Band | Model | Why this rank |
|------|-------|---------------|
| High | DeepSeek V4-Pro | Open-weight frontier coding at ~$0.44 / $0.87 — best high-tier price/capability when exposed |
| High | GLM-5.2 (Z.ai) | Top open-weight SWE-bench Pro / long-horizon agents; MIT weights |
| High | Claude Opus 5 | Best closed frontier value (~$5 / $25) among allowed Anthropic highs |
| High | Kimi K3 | Strong open-weight / hosted agentic coding when available |
| High | xAI Grok 4.5 | Strong closed coding agent when exposed |
| High | GPT-5.6 Sol | Closed OpenAI frontier (~$5 / $30) |
| Mid | Gemini 3.6 Flash | Capable mid coding/agents at ~$1.50 / $7.50 — cheapest closed mid |
| Mid | GPT-5.6 Terra | Balanced OpenAI everyday coding (~$2–2.50 / $12–15) |
| Mid | Claude Sonnet 5 | Strong Anthropic mid (~$3 / $15) |
| Mid | Qwen3-Coder | Open-weight coding specialist (Apache); strong self-host / hosted mid |
| Mid | Llama 4 Maverick | Meta open-weight generalist when a coding-capable mid is needed |
| Low | GPT-5.6 Luna | Cheapest capable OpenAI coding worker (~$0.20–1 / $1.20–6) |
| Low | Gemini 3.5 Flash-Lite | High-throughput low-cost Google worker (~$0.30 / $2.50); Gemma 4 if only local open Google weights |
| Low | Composer 2.5 | Dedicated low-cost coding agent when exposed (Cursor-family) |
| Low | MiniMax M3 | Low-cost open / hosted throughput when exposed |

Excluded: Fable 5 (data policy + premium), Haiku (policy), GPT‑5.5 Pro and other
ultra-premium compute SKUs as default workers.

#### High-capability (ranked)

| Rank | Provider | Model | Prefer / map to |
|------|----------|-------|-----------------|
| 1 | DeepSeek | DeepSeek V4-Pro | `deepseek-v4-pro`, `deepseek-chat` Pro equivalent |
| 2 | Z.ai | GLM-5.2 | `glm-5.2`, `glm-5` latest coding |
| 3 | Anthropic | Claude Opus 5 | `opus`, `claude-opus-5` |
| 4 | Moonshot | Kimi K3 | `kimi-k3`, `kimi-k3-high`, K2.6 if K3 unavailable |
| 5 | xAI | Grok 4.5 | `grok-4.5`, `cursor-grok-4.5-high` |
| 6 | OpenAI | GPT-5.6 Sol | `gpt-5.6-sol` |

#### Mid-capability (ranked)

| Rank | Provider | Model | Prefer / map to |
|------|----------|-------|-----------------|
| 1 | Google | Gemini 3.6 Flash | `gemini-3.6-flash` |
| 2 | OpenAI | GPT-5.6 Terra | `gpt-5.6-terra` |
| 3 | Anthropic | Claude Sonnet 5 | `sonnet`, `claude-sonnet-5` |
| 4 | Alibaba | Qwen3-Coder | `qwen3-coder`, latest Qwen coder instruct |
| 5 | Meta | Llama 4 Maverick | `llama-4-maverick` or harness Llama 4 coding mid |

#### Low-capability (ranked)

| Rank | Provider | Model | Prefer / map to |
|------|----------|-------|-----------------|
| 1 | OpenAI | GPT-5.6 Luna | `gpt-5.6-luna` |
| 2 | Google | Gemini 3.5 Flash-Lite | `gemini-3.5-flash-lite`; `gemma-4` only if Flash-Lite unavailable and local/private Google open weights are the option |
| 3 | Cursor | Composer 2.5 | `composer-2.5` when exposed |
| 4 | MiniMax | MiniMax M3 | `minimax-m3` / latest MiniMax coding throughput SKU |

#### General selection notes

1. Walk the chosen category top-down; use the first model the harness exposes.
2. **One model per provider** already applied — do not add a second generation
   from the same vendor beside the ranked pick (use it only as that row’s fallback).
3. Prefer **open-weight / cheaper hosted** rows when they meet the tier’s needs;
   do not skip to a closed frontier model out of habit.
4. If **low** has no available row, use the top available **mid** for Routine,
   then escalate to **high** on failure.
5. If only one model exists in the whole session, use it for manager and workers;
   still record difficulty for when more models appear.
6. Prefer staying on one vendor stack for a given batch of workers when several
   options are equally available and cost-comparable.
7. Self-hosted open weights: treat inference cost (GPU time) as the price signal —
   still prefer the highest-ranked **available** open model in the tier that fits
   hardware, rather than silently upgrading to a paid closed API.
8. Apply the same difficulty bias and escalation ladder as platform-specific
   catalogs.

