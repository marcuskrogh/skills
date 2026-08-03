# Concept: Delegation (value-aware model routing)

**Uninvokable concept.** Skills that spawn sub-agents must instruct the agent to
read this file on invoke (or when composing a skill that delegates). Do not
surface this concept unless a skill references it.

## Purpose

Before every sub-agent spawn, the **manager** (orchestrating agent) evaluates
**task difficulty** and assigns a worker model for **value-efficient** execution.
Routine and well-specified work goes to a **low-capability** (value) model;
only genuinely hard or high-stakes packages use a **high-capability**
(competent) model.

This keeps multi-agent loops (especially **implement**, **review**, and
**review-fix**) from spending premium capacity on work a value-tier model
handles well.

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
| **Manager** | Invoking / parent agent | Parent session model — **do not** hand orchestration to a low-capability sub-agent. Prefer the top available **high-capability** model when the session can choose. |
| **Worker** | Each `Task` / sub-agent | Chosen per package via [Difficulty → category → model](#difficulty--category--model) |

Never spawn a "manager of managers" on a low-capability model to save cost.
Value routing applies to **workers only**.

## Categories and ranking

Two categories. Within each, models are **ranked** (1 = prefer first). Selection
is always: **category from difficulty**, then **highest-ranked model in that
category that the harness exposes and the session may use**.

| Category | Alias | Used for |
|----------|-------|----------|
| **Low-capability** | value / default worker | Routine and Moderate packages |
| **High-capability** | competent / elevated worker | Demanding packages; preferred manager; escalation after a weak value-tier pass |

### Selection algorithm

1. **Detect platform** — Cursor, Claude Code, Codex, GitHub Copilot, or other.
2. **Load catalog** — matching platform section below, else [General](#general-any-platform).
   WORKSPACE / skill overrides win when present.
3. **Score difficulty** — [Difficulty evaluation](#difficulty-evaluation-mandatory-before-each-spawn).
4. **Choose category** — Routine/Moderate → low-capability; Demanding → high-capability.
5. **Pick model** — walk the category ranking top-down; use the first slug the
   harness accepts. Prefer the listed primary slug; use the row's fallback only
   when the primary is unavailable.
6. **Pass `model`** when the harness supports per-sub-agent models. If it cannot,
   note that once and continue; still record difficulty so briefs and escalation
   stay consistent.

### Bias rule (value first)

When the choice is unclear:

1. Prefer **low-capability** over high-capability.
2. Prefer **Routine/Moderate → low-capability** even if the package is important —
   importance ≠ difficulty.
3. Elevate to **high-capability** only when at least one **Demanding** signal is
   present, or when re-delegating after an insufficient low-capability report.
4. Do **not** elevate "just in case" or because the parent is high-capability.
5. Within a category, prefer the **highest-ranked available** model — do not
   skip down the list to save cost after the category is chosen.

Default stance: **most workers are low-capability**; high-capability workers are
the exception.

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

#### Low-capability (ranked)

| Rank | Provider | Model | Slug / alias (prefer) | Fallback |
|------|----------|-------|----------------------|----------|
| 1 | Anthropic | Claude Sonnet 5 | `sonnet` / `claude-sonnet-5` | `claude-sonnet-4-6` |

Manager preference: Opus 5. Workers default to Sonnet 5.

### Codex (OpenAI)

OpenAI-only harness.

#### High-capability (ranked)

| Rank | Provider | Model | Slug (prefer) | Fallback |
|------|----------|-------|---------------|----------|
| 1 | OpenAI | GPT-5.6 Sol | `gpt-5.6-sol` | raise reasoning effort on Sol before leaving the row |

#### Low-capability (ranked)

| Rank | Provider | Model | Slug (prefer) | Fallback |
|------|----------|-------|---------------|----------|
| 1 | OpenAI | GPT-5.6 Terra | `gpt-5.6-terra` | `gpt-5.6-luna` only if Terra is unavailable |

Manager preference: Sol. Workers default to Terra.

### GitHub Copilot

Copilot exposes a multi-vendor picker. Prefer the same category logic; use the
IDs the Copilot agent / IDE model picker accepts. **Never** pick Claude Fable 5.

#### High-capability (ranked)

| Rank | Provider | Model | Prefer |
|------|----------|-------|--------|
| 1 | Anthropic | Claude Opus 5 | default elevated coding agent (cost-capable frontier) |
| 2 | xAI | Grok 4.5 | when the Copilot catalog exposes it |
| 3 | OpenAI | GPT-5.6 Sol | OpenAI frontier alternative |

#### Low-capability (ranked)

| Rank | Provider | Model | Prefer |
|------|----------|-------|--------|
| 1 | Anthropic | Claude Sonnet 5 | default value worker |
| 2 | OpenAI | GPT-5.6 Terra | OpenAI balanced worker (`gpt-5.6-luna` / GPT-5 mini only if Terra unavailable) |

### General (any platform)

Use when the harness is not listed above, the catalog is incomplete, or model
IDs differ from the tables.

1. **Exclude** models with special/restrictive data policies (including Claude
   Fable 5 and aliases that resolve to it).
2. **Partition** available models into high-capability (frontier / strongest
   reasoning coding agents) and low-capability (mid-tier / cost-efficient coding
   models that still handle well-specified implementation, review axes, and
   fix-forward).
3. **One model per provider** in each partition — pick the current
   cost-efficient representative; older generations are fallbacks for that row
   only.
4. **Rank** high-capability by capability-per-cost (adequate frontier first;
   do not default to the most expensive option). Rank low-capability by
   cheapest-still-capable.
5. **Apply the same bias and difficulty rules** as platform-specific catalogs.
6. If only one model exists, use it for both manager and workers; still score
   difficulty for briefs and for when a second model appears later.
7. If several vendors are available with no project preference, prefer one
   vendor stack for the session (fewer surprises) and keep workers in the
   low-capability partition whenever difficulty allows.

---

## Difficulty evaluation (mandatory before each spawn)

The manager scores each work package / review axis / research axis **before**
calling the sub-agent. Use the **hardest matching signal** — one hard signal is
enough to elevate; absence of hard signals defaults to **low-capability**.

### Signals → tier

| Tier | Typical signals (any one may apply) |
|------|-------------------------------------|
| **Routine** | Localized change; clear acceptance; known repo pattern; docs/comments/rename; smell/standards pass; single-thread fix-forward with an obvious patch; checklist-driven Spec mapping |
| **Moderate** (still **low-capability**) | Multi-file but well-specified; standard tests; Integration with clear contracts; most Implementation / Testing packages; most fix-forward batches; parallel review axes without hard risk |
| **Demanding** (**high-capability**) | Novel or ambiguous design; cross-cutting correctness (concurrency, races, distributed consistency); security / authz / crypto; subtle algorithms or numerical methods; large structural / Architecture risk (new layers, cycles, ADR conflict); failed prior low-capability attempt on the **same** package; high blast-radius public API or migration |

## Difficulty → category → model

| Evaluated tier | Category | Assign |
|----------------|----------|--------|
| Routine | Low-capability | Top available low-capability model for the platform |
| Moderate | Low-capability | Top available low-capability model for the platform |
| Demanding | High-capability | Top available high-capability model for the platform |

Record in the internal package plan (and optionally the brief header):

```text
platform: cursor | claude-code | codex | github-copilot | general
difficulty: routine | moderate | demanding
category: low-capability | high-capability
model: <slug-or-alias>
reason: <one short line — the deciding signal>
```

## Escalation

1. First attempt: assign per the table above (bias low-capability).
2. If the worker report is **insufficient** (gaps vs acceptance, weak evidence,
   wrong severity, incomplete deliverables) → re-delegate the **same** package
   to a **high-capability** model (top available) with named gaps — do not
   silently absorb large gaps in the manager thread.
3. If the high-capability worker also fails → manager may do a **narrow** repair
   or ask the user; do not endlessly re-spawn.
4. Optional within-category step: if the first low-capability pick used a deep
   cost fallback on the same row and the report is thin, retry once with that
   row’s primary slug before escalating to high-capability.

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
that still obeys the bias rule and Demanding elevation signals.

| Skill family | Expectation |
|--------------|-------------|
| **implement** / **iterate** build | Score each work package; default low-capability; elevate for Demanding packages and after failed value-tier attempts |
| **review** | Score each axis (can differ per axis in one parallel batch); default low-capability; elevate axes with Demanding signals |
| **review-fix** | Same routing inside composed review + fix-forward implement; prefer low-capability for most fix-forward threads |
| **research** (when axes run as sub-agents) | Default low-capability per axis; elevate only for dense formal synthesis / conflicting high-stakes literature |
| **ship** / other composers | Inherit routing from the skills they invoke — do not override toward high-capability |
| **explore** / alignment-only | No worker routing unless the skill explicitly delegates |

## Anti-patterns

- Running all workers on high-capability because the manager is high-capability
- Skipping difficulty evaluation and always passing no `model` (silent premium inherit)
- Elevating every Architecture or Correctness axis "by default" without a Demanding signal
- Downgrading the manager / merge step to low-capability to save cost
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
   default table — still **low-capability-biased**, referring to categories rather
   than a single brand unless documenting an example.
3. Link: `[CONCEPT_DELEGATION](../concepts/CONCEPT_DELEGATION.md)`.
