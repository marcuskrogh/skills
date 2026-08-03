# Concept: Delegation (value-aware model routing)

**Uninvokable concept.** Skills that spawn sub-agents must instruct the agent to
read this file on invoke (or when composing a skill that delegates). Do not
surface this concept unless a skill references it.

## Purpose

Before every sub-agent spawn, the **manager** (orchestrating agent) evaluates
**task difficulty** and assigns a worker model for **value-efficient** execution.
Routine work goes to a **low-capability** model; well-specified but non-trivial
work to a **mid-capability** model; only genuinely hard or high-stakes packages
use a **high-capability** model.

This keeps multi-agent loops (especially **implement**, **review**, and
**review-fix**) from spending premium capacity on work a lower tier handles
well.

Catalogs are **platform-dependent**. Detect the harness, load that platform's
ranked lists, then pick within the correct category. If the platform is unknown
or has no specific section, use [General (any platform)](#general-any-platform).

## What this is not

- Not a user-invokable workflow by itself
- Not a reason to downgrade the **manager** — orchestration, planning, merge of
  findings, severity promotion, plan revision, and tracker/PR decisions stay on
  a **high-capability** model (or the parent session when the harness cannot
  switch)
- Not an excuse to skip acceptance criteria, briefs, or verification
- Not a requirement to announce model choice to the user on every spawn (record
  it in the brief / internal plan; mention to the user only when useful)
- Not a fixed two-model world — each category is a **ranked hierarchy**; pick the
  best available entry, not only the historical Composer / Grok pair

## Roles

| Role | Who | Model |
|------|-----|-------|
| **Manager** | Invoking / parent agent | Parent session model — **do not** hand orchestration to a low- or mid-capability sub-agent. Prefer the top available **high-capability** model when the session can choose. |
| **Worker** | Each `Task` / sub-agent | Chosen per package via [Difficulty → category → model](#difficulty--category--model) |

Never spawn a "manager of managers" on a low- or mid-capability model to save
cost. Value routing applies to **workers only**.

## Categories and ranking

Three categories. Within each, models are **ranked** (1 = prefer first). Selection
is always: **category from difficulty**, then **highest-ranked model in that
category that the harness exposes and the session may use**.

| Category | Alias | Used for |
|----------|-------|----------|
| **Low-capability** | value | Routine packages |
| **Mid-capability** | balanced | Moderate packages; first escalation after a weak low-capability pass |
| **High-capability** | competent / elevated | Demanding packages; preferred manager; escalation after a weak mid-capability pass |

If a platform has **no mid-capability** entry available, treat Moderate as
**low-capability** (still bias down) and escalate insufficient Moderate work to
**high-capability**.

### Selection algorithm

1. **Detect platform** — Cursor, Claude Code, Codex, GitHub Copilot, or other.
2. **Load catalog** — matching platform section below, else [General](#general-any-platform).
   WORKSPACE / skill overrides win when present.
3. **Score difficulty** — [Difficulty evaluation](#difficulty-evaluation-mandatory-before-each-spawn).
4. **Choose category** — Routine → low; Moderate → mid; Demanding → high.
5. **Pick model** — walk the category ranking top-down; use the first slug the
   harness accepts. Prefer the listed primary slug; use the row's fallback only
   when the primary is unavailable.
6. **Pass `model`** when the harness supports per-sub-agent models. If it cannot,
   note that once and continue; still record difficulty so briefs and escalation
   stay consistent.

### Bias rule (value first)

When the choice is unclear:

1. Prefer the **lower** category (low > mid > high).
2. Prefer **Routine → low** and **Moderate → mid** even if the package is
   important — importance ≠ difficulty.
3. Elevate to **high-capability** only when at least one **Demanding** signal is
   present, or when re-delegating after an insufficient mid-capability report
   (or after insufficient low when mid is unavailable).
4. Do **not** elevate "just in case" or because the parent is high-capability.
5. Within a category, prefer the **highest-ranked available** model — do not
   skip down the list to save cost after the category is chosen.

Default stance: **most workers are low- or mid-capability**; high-capability
workers are the exception.

---

## Platform catalogs

Ranks are preference order within the category for **this skills repo**. Adjust
via WORKSPACE or a skill override when a project disagrees.

### Catalog rules

1. **One model per provider** per category — do not list multiple Claude, GPT, or
   Grok generations side by side. Prefer the current cost-efficient pick for that
   provider; put prior generations only as that row’s fallback slug.
2. **Cost-aware** — within a category, rank cheaper capable options above pricier
   peers when they are adequate; prefer standard effort / non-`xhigh` / non-fast
   premium modes as the primary slug; use costlier effort modes only as fallback
   when the primary slug is unavailable.
3. **Never Fable 5** — do not select Claude Fable 5 (`fable`, `claude-fable-5`,
   thinking variants, or aliases like `best` that resolve to Fable). It has a
   special data policy this repo avoids. Use Opus (or the next catalog entry)
   instead.
4. Fast / mini / prior-gen variants are **fallbacks for the same row**, not
   separate ranked picks.

### Cursor

When the harness exposes a `model` parameter on sub-agent / `Task` calls:

#### High-capability (ranked)

| Rank | Provider | Model | Slug (prefer) | Fallback |
|------|----------|-------|---------------|----------|
| 1 | Cursor / xAI | Cursor Grok 4.5 | `cursor-grok-4.5-high` | `cursor-grok-4.5-high-fast` |
| 2 | Anthropic | Claude Opus 5 | `claude-opus-5-thinking-high` | `claude-opus-5-thinking-high-fast` |
| 3 | OpenAI | GPT-5.6 Sol | `gpt-5.6-sol-high` | `gpt-5.6-sol-high-fast` (avoid `xhigh` unless required) |
| 4 | Moonshot | Kimi K3 | `kimi-k3-high` | — |

#### Mid-capability (ranked)

| Rank | Provider | Model | Slug (prefer) | Fallback |
|------|----------|-------|---------------|----------|
| 1 | Anthropic | Claude Sonnet 4.6 | `claude-4.6-sonnet-high-thinking` | — |
| 2 | OpenAI | GPT-5.5 | `gpt-5.5-high` | `gpt-5.5-high-fast` |

#### Low-capability (ranked)

| Rank | Provider | Model | Slug (prefer) | Fallback |
|------|----------|-------|---------------|----------|
| 1 | Cursor | Composer 2.5 | `composer-2.5` | `composer-2.5-fast` |

### Claude Code

Anthropic-only harness. Use aliases the CLI resolves (`/model`, sub-agent model,
or env defaults). Prefer full IDs when pinning. **Do not** use `fable` or `best`
(both can select Fable 5).

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
| 1 | Anthropic | Claude Haiku 4.5 | `haiku` / `claude-haiku-4-5` | — |

Manager preference: Opus 5. Workers: Haiku for Routine, Sonnet for Moderate.

### Codex (OpenAI)

OpenAI-only harness.

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

Manager preference: Sol. Workers: Luna for Routine, Terra for Moderate.

### GitHub Copilot

Copilot exposes a multi-vendor picker. Prefer the same category logic; use the
IDs the Copilot agent / IDE model picker accepts. **Never** pick Claude Fable 5.

#### High-capability (ranked)

| Rank | Provider | Model | Prefer |
|------|----------|-------|--------|
| 1 | Anthropic | Claude Opus 5 | default elevated coding agent (cost-capable frontier) |
| 2 | xAI | Grok 4.5 | when the Copilot catalog exposes it |
| 3 | OpenAI | GPT-5.6 Sol | OpenAI frontier alternative |

#### Mid-capability (ranked)

| Rank | Provider | Model | Prefer |
|------|----------|-------|--------|
| 1 | Anthropic | Claude Sonnet 5 | default balanced worker |
| 2 | OpenAI | GPT-5.6 Terra | OpenAI balanced worker |

#### Low-capability (ranked)

| Rank | Provider | Model | Prefer |
|------|----------|-------|--------|
| 1 | Anthropic | Claude Haiku 4.5 | default value worker |
| 2 | OpenAI | GPT-5.6 Luna | or GPT-5 mini if Luna unavailable |

### General (any platform)

Use when the harness is not listed above, the catalog is incomplete, or model
IDs differ from the tables.

1. **Exclude** models with special/restrictive data policies (including Claude
   Fable 5 and aliases that resolve to it).
2. **Partition** available models into three bands:
   - **High-capability** — frontier / strongest reasoning coding agents
   - **Mid-capability** — balanced everyday coding agents (strong tool use, not
     the cheapest and not the frontier)
   - **Low-capability** — cost-efficient models that still handle well-specified
     Routine implementation, review axes, and obvious fix-forward
3. **One model per provider** in each partition — pick the current
   cost-efficient representative; older generations are fallbacks for that row
   only.
4. **Rank** high-capability by capability-per-cost (adequate frontier first;
   do not default to the most expensive option). Rank mid and low by
   cheapest-still-capable within that band.
5. If a provider has only two usable models, map them to low + high and leave
   mid empty for that provider (Moderate then uses low, with escalation to high).
6. **Apply the same bias and difficulty rules** as platform-specific catalogs.
7. If only one model exists, use it for both manager and workers; still score
   difficulty for briefs and for when more models appear later.
8. If several vendors are available with no project preference, prefer one
   vendor stack for the session (fewer surprises) and keep workers in the
   lowest adequate partition whenever difficulty allows.

---

## Difficulty evaluation (mandatory before each spawn)

The manager scores each work package / review axis / research axis **before**
calling the sub-agent. Use the **hardest matching signal** — one Demanding
signal is enough to elevate to high; one Moderate signal (with no Demanding)
maps to mid; absence of Moderate/Demanding signals defaults to **low-capability**.

### Signals → tier

| Tier | Typical signals (any one may apply) |
|------|-------------------------------------|
| **Routine** (**low-capability**) | Localized change; clear acceptance; known repo pattern; docs/comments/rename; smell/standards pass; single-thread fix-forward with an obvious patch; checklist-driven Spec mapping |
| **Moderate** (**mid-capability**) | Multi-file but well-specified; standard tests; Integration with clear contracts; most Implementation / Testing packages; most fix-forward batches; parallel review axes without hard risk |
| **Demanding** (**high-capability**) | Novel or ambiguous design; cross-cutting correctness (concurrency, races, distributed consistency); security / authz / crypto; subtle algorithms or numerical methods; large structural / Architecture risk (new layers, cycles, ADR conflict); failed prior mid-capability attempt on the **same** package; high blast-radius public API or migration |

## Difficulty → category → model

| Evaluated tier | Category | Assign |
|----------------|----------|--------|
| Routine | Low-capability | Top available low-capability model for the platform |
| Moderate | Mid-capability | Top available mid-capability model (else low, then escalate to high if weak) |
| Demanding | High-capability | Top available high-capability model for the platform |

Record in the internal package plan (and optionally the brief header):

```text
platform: cursor | claude-code | codex | github-copilot | general
difficulty: routine | moderate | demanding
category: low-capability | mid-capability | high-capability
model: <slug-or-alias>
reason: <one short line — the deciding signal>
```

## Escalation

Escalate **one tier at a time** (cost-aware ladder):

1. First attempt: assign per the table above (bias toward the lower category).
2. If the worker report is **insufficient** (gaps vs acceptance, weak evidence,
   wrong severity, incomplete deliverables) → re-delegate the **same** package
   to the **next higher** category (low → mid → high) with named gaps — do not
   silently absorb large gaps in the manager thread.
3. Skip mid only when that catalog is empty for the platform; then low → high.
4. If the high-capability worker also fails → manager may do a **narrow** repair
   or ask the user; do not endlessly re-spawn.
5. Optional within-category step: if the first pick used a deep cost fallback on
   the same row and the report is thin, retry once with that row’s primary slug
   before climbing a tier.

Escalation is the main safety valve that makes value-default routing safe.

## Spawn contract

Each sub-agent call must include:

1. Full package / axis brief (unchanged skill requirements)
2. Explicit `model` when the harness supports it
3. The difficulty one-liner (so a resumed or re-delegated agent shares context)

Manager duties that **stay** on the parent (high-capability): plan drafting,
package ordering, difficulty scoring, merging/deduplicating findings, severity
promotion, tracker transitions, PR publish, verification command ownership,
and **Next** handoff.

## Skill specialisations

Skills **must** apply this concept whenever they use sub-agents. They **may**
publish a default assignment table (e.g. per review axis or work-package type)
that still obeys the bias rule and the Routine / Moderate / Demanding mapping.

| Skill family | Expectation |
|--------------|-------------|
| **implement** / **iterate** build | Score each work package; Routine → low, Moderate → mid, Demanding → high; escalate one tier after failed attempts |
| **review** | Score each axis (can differ per axis in one parallel batch); same three-tier mapping |
| **review-fix** | Same routing inside composed review + fix-forward implement; prefer low/mid for most fix-forward threads |
| **research** (when axes run as sub-agents) | Default low or mid per axis difficulty; elevate to high only for dense formal synthesis / conflicting high-stakes literature |
| **ship** / other composers | Inherit routing from the skills they invoke — do not override toward high-capability |
| **explore** / alignment-only | No worker routing unless the skill explicitly delegates |

## Anti-patterns

- Running all workers on high-capability because the manager is high-capability
- Skipping difficulty evaluation and always passing no `model` (silent premium inherit)
- Treating Moderate as Demanding (or always jumping low → high) when mid exists
- Elevating every Architecture or Correctness axis "by default" without a Demanding signal
- Downgrading the manager / merge step to low- or mid-capability to save cost
- Re-implementing large gaps in the manager thread instead of escalating the worker
- Hard-coding a single brand pair (e.g. only Composer / Grok) when the platform
  catalog lists a ranked hierarchy
- Listing multiple models from the same provider in one category
- Selecting Claude Fable 5 (or `best` / other aliases that resolve to it)
- Using the General catalog on a known platform to ignore its ranking
- Announcing model brands to the user on every spawn when it adds no decision value

## Authoring skills that use this concept

1. Instruct the agent to **read this file** on invoke when the skill delegates.
2. Add a short **Model routing** section (or extension row) with any skill-specific
   default table — still **value-biased** (low/mid before high), referring to
   categories rather than a single brand unless documenting an example.
3. Link: `[CONCEPT_DELEGATION](../concepts/CONCEPT_DELEGATION.md)`.
