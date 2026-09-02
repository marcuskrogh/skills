# Review — depth routing

Disclosed reference for [review](SKILL.md). Choose **depth** after the
investigation context pack is ready; then spawn only the workers that depth
requires. **Laser** mode is chosen per [lasers.md](lasers.md). Severity stays
**fix-biased** per
[CONCEPT_REVIEW](../concepts/CONCEPT_REVIEW.md). Axis detail lives in
[axis-briefs.md](axis-briefs.md) and [checklist.md](checklist.md).

## Choose depth

Pick the **first matching** row. Record `depth: full | focused` and a one-line
reason in the tracker comment. When `PLAN.md` has `## Workflow`, **honor
`review.depth`, `review.mode`, and `review.lasers`** from the binding (do not
re-guess from class vibes). Map `review.mode=multiagent` → workers per **full**;
`review.mode=single` → workers per **focused** (unless depth was explicitly
`full` with single-mode Core-only — still use the depth worker map below).
Sequential vs bundled spawn order: [lasers.md](lasers.md).

| Signal | Depth |
|--------|-------|
| Bound `review.depth=full` (PLAN Workflow) | **full** |
| Bound `review.depth=focused` (PLAN Workflow) | **focused** |
| User names full / thorough / all-axes | **full** |
| `PLAN.md` feature work with multi-package scope, new modules/layers, wide blast radius, or structural/ADR risk (no binding) | **full** |
| Diff touches many packages or public API / schema / migration surface as the main change (no binding) | **full** |
| `BUG.md` / `TWEAK.md` / `REFINE.md` / `REWORK.md` / `ITERATE.md` / `ADOPT.md` (default) | **focused** |
| `PLAN.md` but small localized slice (few files, one concern, no new layers) (no binding) | **focused** |
| Ambiguous | **focused** for bug/tweak/refine/rework/iterate; **full** for unbound feature `PLAN.md` |

Structural red flags while packing context (new layers, cycles, ADR conflicts) →
promote to **full** even on a bug/tweak/refine/rework/iterate Task **unless** the
user explicitly locked a focused binding and reaffirms it.

## Worker map

| Depth | Workers | Axes covered |
|-------|---------|--------------|
| **full** | Five `generalPurpose` — one per axis (parallel when bundled; one-at-a-time when sequential) | Spec, Correctness, Integration, Architecture, Standards |
| **focused** | **Core** + **Architecture** always; add **Integration** when contracts are in blast radius | Core = Spec (if pack non-empty) + Correctness + light Standards in changed hunks; Architecture always; optional Integration |

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
| Architecture | Mid | New layers/modules, cycles, ADR conflicts, large structural shift |

Full-depth per-axis defaults stay in [SKILL.md](SKILL.md).

## Focused briefs

Paste into each `Task` with the manager's context pack. Return the same finding
shape as [axis-briefs.md](axis-briefs.md); tag every finding with its **axis**.
Budgets: **≤25** findings total across Core (split across its axes), **≤800 words**
per worker. Prefer accurate severity over a soft review.

### Core

Include: context pack + Spec checklist (if pack non-empty) + Correctness checklist
+ Standards smell baseline for **changed** hunks only + tooling failures.

1. **Spec** (when pack exists) — each pass-criteria row / repro expectation through the
   diff; missing/wrong → `blocker`; incomplete related surfaces → `should-fix`.
2. **Correctness** — logic, edges, errors, races, tests; unexplained tooling
   failures → `blocker`.
3. **Standards (light)** — actionable named smells, nested-conditional **CRAP**
   above the target, or documented convention breaches in changed code only, per
   [STRUCTURE-CATALOG.md](../concepts/STRUCTURE-CATALOG.md).
   Leave module/layer redesign to the Architecture laser (**always** included
   under focused — small diffs included).

### Architecture (always under focused)

Always include. Small diffs use the same structure catalog. Same brief as
[axis-briefs.md](axis-briefs.md#architecture).

### Integration (optional)

Include: context pack + Integration checklist + neighbor map. Same brief as
[axis-briefs.md](axis-briefs.md#integration). Do not expand into Architecture.
