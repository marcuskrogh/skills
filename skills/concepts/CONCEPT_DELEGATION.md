# Concept: Delegation (value-aware model routing)

Before every sub-agent spawn, the **manager** scores **task difficulty** and
assigns a **worker** model for value-efficient execution. Uninvokable — load
only when a skill's On-invoke pointer fires (skills that spawn workers).

Catalogs are platform-dependent: detect harness → load
[PLATFORM-CATALOGS.md](PLATFORM-CATALOGS.md) (or General) → pick within category.

## Leading words

- **manager** — orchestrating agent; stays on parent / high-capability
- **worker** — each `Task` / sub-agent; routed low / mid / high
- **Routine / Moderate / Demanding** — difficulty tiers → low / mid / high categories

## Invariants

- **Workers only.** Never hand orchestration, plan merge, severity promotion, tracker/PR, or verification ownership to a low/mid worker.
- **Score before spawn.** Hardest matching signal wins; no Demanding/Moderate signal → Routine (low).
- **Bias down.** When unclear, prefer lower category. Importance ≠ difficulty. Do not elevate "just in case."
- **One-tier escalate.** Insufficient report → re-delegate same package one tier up with named gaps. If low and mid resolve to the same model, escalate directly to high.
- **Pass `model`** when the harness supports it; still record difficulty when it cannot.
- **Platform catalog.** Use the ranked list for the detected harness; General only when unknown/incomplete. Never Fable 5 or Haiku (catalog policy).

## Roles

| Role | Model |
|------|-------|
| **Manager** | Parent / top available high-capability |
| **Worker** | Category from difficulty, then highest-ranked available slug in that category |

## Difficulty → category

| Tier | Signals (any one) | Category |
|------|-------------------|----------|
| **Routine** | Localized; clear acceptance; known pattern; docs/rename; checklist Spec | Low |
| **Moderate** | Multi-file well-specified; standard tests; clear Integration; most Implementation/Testing/fix-forward | Mid |
| **Demanding** | Novel/ambiguous design; concurrency/security/crypto; subtle algorithms; large Architecture risk; prior mid miss on same package; high blast-radius API/migration | High |

If mid is unavailable: Moderate → low, then escalate insufficient work to high.

Record in the package plan:

```text
platform: cursor | claude-code | codex | github-copilot | general
difficulty: routine | moderate | demanding
category: low-capability | mid-capability | high-capability
model: <slug-or-alias>
reason: <one short line — deciding signal>
```

## Spawn contract

Each worker call includes: full brief; `model` when supported; difficulty one-liner.

## Extensions

| Slot | Required | Purpose |
|------|----------|---------|
| **Default table** | may | Per-axis or package-type defaults — still value-biased |
| **Catalog override** | may | WORKSPACE / skill ranked lists replacing repo defaults |

## Skill families

| Family | Expectation |
|--------|-------------|
| **implement** / **iterate** build | Score each package; escalate one tier after fails |
| **review** / **review-fix** | Score each axis (may differ in one batch); low/mid for most fix-forward |
| **research** (axis workers) | Default low/mid; high only for dense conflicting formal synthesis |
| **ship** / composers | Inherit from invoked skills — do not override toward high |
| **explore** / alignment-only | No worker routing unless the skill explicitly delegates |

## Reference

Load [PLATFORM-CATALOGS.md](PLATFORM-CATALOGS.md) when assigning models.
