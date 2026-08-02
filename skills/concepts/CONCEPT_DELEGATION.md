# Concept: Delegation (value-aware model routing)

**Uninvokable concept.** Skills that spawn sub-agents must instruct the agent to
read this file on invoke (or when composing a skill that delegates). Do not
surface this concept unless a skill references it.

## Purpose

Before every sub-agent spawn, the **manager** (orchestrating agent) evaluates
**task difficulty** and assigns a worker model for **value-efficient** execution.
Routine and well-specified work goes to a capable cheaper model; only genuinely
hard or high-stakes packages use the more competent (costlier) model.

This keeps multi-agent loops (especially **implement**, **review**, and
**review-fix**) from spending premium capacity on work Composer handles well.

## What this is not

- Not a user-invokable workflow by itself
- Not a reason to downgrade the **manager** — orchestration, planning, merge of
  findings, severity promotion, plan revision, and tracker/PR decisions stay on
  the most competent model available to the parent session (currently
  **Cursor Grok 4.5**)
- Not an excuse to skip acceptance criteria, briefs, or verification
- Not a requirement to announce model choice to the user on every spawn (record
  it in the brief / internal plan; mention to the user only when useful)

## Roles

| Role | Who | Model |
|------|-----|-------|
| **Manager** | Invoking / parent agent | Parent session model — **do not** hand orchestration to a cheaper sub-agent. Prefer **Cursor Grok 4.5** when the session can choose. |
| **Worker** | Each `Task` / sub-agent | Chosen per package via [Difficulty → model](#difficulty--model) |

Never spawn a "manager of managers" on Composer to save cost. Value routing
applies to **workers only**.

## Default model catalog (Cursor)

When the harness exposes a `model` parameter on sub-agent / `Task` calls, use
these slugs unless the skill or WORKSPACE overrides them:

| Tier | Model | Slug (prefer) | Fallback |
|------|-------|---------------|----------|
| **Value (default worker)** | Composer 2.5 | `composer-2.5` | `composer-2.5-fast` if the harness only accepts the fast slug |
| **Competent (elevated worker)** | Cursor Grok 4.5 | `cursor-grok-4.5-high` | `cursor-grok-4.5-high-fast` only if high is unavailable |

If the harness **cannot** set a per-sub-agent model, note that once and continue
with the best available worker; still run the difficulty evaluation so briefs and
escalation policy stay consistent.

Other harnesses: map **value** → the project's cheaper capable coding model;
**competent** → the stronger reasoning model. Keep the same bias rules.

## Difficulty evaluation (mandatory before each spawn)

The manager scores each work package / review axis / research axis **before**
calling the sub-agent. Use the **hardest matching signal** — one hard signal is
enough to elevate; absence of hard signals defaults to Composer.

### Signals → tier

| Tier | Typical signals (any one may apply) |
|------|-------------------------------------|
| **Routine** | Localized change; clear acceptance; known repo pattern; docs/comments/rename; smell/standards pass; single-thread fix-forward with an obvious patch; checklist-driven Spec mapping |
| **Moderate** (still **Composer**) | Multi-file but well-specified; standard tests; Integration with clear contracts; most Implementation / Testing packages; most fix-forward batches; parallel review axes without hard risk |
| **Demanding** (**Grok**) | Novel or ambiguous design; cross-cutting correctness (concurrency, races, distributed consistency); security / authz / crypto; subtle algorithms or numerical methods; large structural / Architecture risk (new layers, cycles, ADR conflict); failed prior Composer attempt on the **same** package; high blast-radius public API or migration |

### Bias rule (value first)

When the choice is unclear:

1. Prefer **Composer** over Grok.
2. Prefer **Routine/Moderate → Composer** even if the package is important — importance ≠ difficulty.
3. Elevate to **Grok** only when at least one **Demanding** signal is present, or when re-delegating after an insufficient Composer report.
4. Do **not** elevate "just in case" or because the parent is Grok.

Default stance: **most workers are Composer**; Grok workers are the exception.

## Difficulty → model

| Evaluated tier | Assign |
|----------------|--------|
| Routine | Composer 2.5 |
| Moderate | Composer 2.5 |
| Demanding | Cursor Grok 4.5 |

Record in the internal package plan (and optionally the brief header):

```text
difficulty: routine | moderate | demanding
model: composer-2.5 | cursor-grok-4.5-high
reason: <one short line — the deciding signal>
```

## Escalation

1. First attempt: assign per the table above (bias Composer).
2. If the worker report is **insufficient** (gaps vs acceptance, weak evidence,
   wrong severity, incomplete deliverables) → re-delegate the **same** package
   to **Grok** with named gaps — do not silently absorb large gaps in the
   manager thread.
3. If Grok also fails → manager may do a **narrow** repair or ask the user;
   do not endlessly re-spawn.

Escalation is the main safety valve that makes Composer-default routing safe.

## Spawn contract

Each sub-agent call must include:

1. Full package / axis brief (unchanged skill requirements)
2. Explicit `model` when the harness supports it
3. The difficulty one-liner (so a resumed or re-delegated agent shares context)

Manager duties that **stay** on the parent (Grok): plan drafting, package
ordering, difficulty scoring, merging/deduplicating findings, severity
promotion, tracker transitions, PR publish, verification command ownership,
and **Next** handoff.

## Skill specialisations

Skills **must** apply this concept whenever they use sub-agents. They **may**
publish a default assignment table (e.g. per review axis or work-package type)
that still obeys the bias rule and Demanding elevation signals.

| Skill family | Expectation |
|--------------|-------------|
| **implement** / **iterate** build | Score each work package; default Composer; elevate for Demanding packages and after failed Composer attempts |
| **review** | Score each axis (can differ per axis in one parallel batch); default Composer; elevate axes with Demanding signals |
| **review-fix** | Same routing inside composed review + fix-forward implement; prefer Composer for most fix-forward threads |
| **research** (when axes run as sub-agents) | Default Composer per axis; elevate only for dense formal synthesis / conflicting high-stakes literature |
| **ship** / other composers | Inherit routing from the skills they invoke — do not override toward Grok |
| **explore** / alignment-only | No worker routing unless the skill explicitly delegates |

## Anti-patterns

- Running all workers on Grok because the manager is Grok
- Skipping difficulty evaluation and always passing no `model` (silent premium inherit)
- Elevating every Architecture or Correctness axis "by default" without a Demanding signal
- Downgrading the manager / merge step to Composer to save cost
- Re-implementing large gaps in the manager thread instead of escalating the worker
- Announcing model brands to the user on every spawn when it adds no decision value

## Authoring skills that use this concept

1. Instruct the agent to **read this file** on invoke when the skill delegates.
2. Add a short **Model routing** section (or extension row) with any skill-specific
   default table — still Composer-biased.
3. Link: `[CONCEPT_DELEGATION](../concepts/CONCEPT_DELEGATION.md)`.
