# Review — depth routing

Disclosed reference for [review](SKILL.md). Choose **depth** after the
investigation context pack is ready; then spawn only the workers that depth
requires. Severity stays **fix-biased** per
[CONCEPT_REVIEW](../concepts/CONCEPT_REVIEW.md). Axis detail lives in
[axis-briefs.md](axis-briefs.md) and [checklist.md](checklist.md).

## Choose depth

Pick the **first matching** row. Record `depth: full | focused` and a one-line
reason in the tracker comment.

| Signal | Depth |
|--------|-------|
| User names full / thorough / all-axes | **full** |
| `PLAN.md` feature work with multi-package scope, new modules/layers, wide blast radius, or structural/ADR risk | **full** |
| Diff touches many packages or public API / schema / migration surface as the main change | **full** |
| `BUG.md` / `ITERATE.md` (default) | **focused** |
| `PLAN.md` but small localized slice (few files, one concern, no new layers) | **focused** |
| Ambiguous | **focused** for bug/iterate; **full** for feature `PLAN.md` |

Structural red flags while packing context (new layers, cycles, ADR conflicts) →
promote to **full** even on a bug/iterate Task.

## Worker map

| Depth | Workers | Axes covered |
|-------|---------|--------------|
| **full** | Five parallel `generalPurpose` — one per axis | Spec, Correctness, Integration, Architecture, Standards |
| **focused** | One **Core** worker; add **Integration** when contracts are in blast radius | Core = Spec (if pack non-empty) + Correctness + light Standards in changed hunks; optional second = Integration |

Empty Spec pack → skip Spec content inside Core / skip Spec worker under full; still run the other included axes. Ask once if everything is empty of intent.

### When to add the Integration worker (focused)

Spawn a second worker when any apply: authz, public API/schema, migrations,
multi-service or multi-module contracts, shared config/env secrets, callers
outside the changed paths that must stay compatible. Otherwise one Core worker
is enough.

### Model defaults (focused)

| Worker | Default | Elevate to high when |
|--------|---------|----------------------|
| Core | Mid | Concurrency/races, security, subtle algorithms, unexplained tooling failures, conflicting acceptance |
| Integration | Mid | Authz, migrations, public API/schema breaks, multi-service contracts |

Full-depth per-axis defaults stay in [SKILL.md](SKILL.md).

## Focused briefs

Paste into each `Task` with the manager's context pack. Return the same finding
shape as [axis-briefs.md](axis-briefs.md); tag every finding with its **axis**.
Budgets: **≤25** findings total across Core (split across its axes), **≤800 words**
per worker. Prefer accurate severity over a soft review.

### Core

Include: context pack + Spec checklist (if pack non-empty) + Correctness checklist
+ Standards smell baseline for **changed** hunks only + tooling failures.

1. **Spec** (when pack exists) — each acceptance / repro expectation through the
   diff; missing/wrong → `blocker`; incomplete related surfaces → `should-fix`.
2. **Correctness** — logic, edges, errors, races, tests; unexplained tooling
   failures → `blocker`.
3. **Standards (light)** — actionable named smells or documented convention
   breaches in changed code only. Leave module/layer redesign to a **full**
   Architecture pass (promote depth if the change clearly needs it).

### Integration (optional second)

Include: context pack + Integration checklist + neighbor map. Same brief as
[axis-briefs.md](axis-briefs.md#integration). Do not expand into Architecture.
