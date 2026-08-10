---
name: rework
description: >-
  Rework alignment and lightweight definition for an intentional implementation
  change that must not degrade performance or outcomes. Requires a thin area
  description and a parity bar. Produces REWORK.md and one tracker Task
  (optional Sub-tasks), then hands off to implementation with comparative
  evaluation. Use when replacing or simplifying a backend/control path (or
  similar) while holding measured outcomes. Prefer /define for new work (agent
  classifies as rework and binds parity-iterative). Prefer /refine when
  executable behaviour stays the same with no intentional algorithm change;
  prefer /tweak when intentional behaviour change is acceptable without a
  comparative bar.
disable-model-invocation: true
---

# Rework

Applies [CONCEPT_ALIGNMENT](../concepts/CONCEPT_ALIGNMENT.md) and
[CONCEPT_DEFINITION](../concepts/CONCEPT_DEFINITION.md) to a **bounded rework**
of an existing implementation. Produces an implementation-ready `REWORK.md`
through lightweight alignment. Implementation follows the comparative path in
[../implement/rework.md](../implement/rework.md).

**On invoke:** read those concepts, [../workflow/reference.md](../workflow/reference.md),
[../workflow/delivery.md](../workflow/delivery.md),
[../workflow/tracker-sync.md](../workflow/tracker-sync.md),
[../workflow/handoff.md](../workflow/handoff.md), and
[../tracker/SKILL.md](../tracker/SKILL.md).

## Extensions

| Slot | This skill |
|------|------------|
| **Subject** | Limited area whose implementation should change (algorithm, control law, mapping, internal path) while measured outcomes stay within a declared bar |
| **Probes** | Area boundary; thin description of current vs intended implementation; why rework; **parity bar** (metrics, scenarios, tolerances, how baseline is obtained); acceptance; out of scope; optional parent Story/Task link; optional `/model` when math equivalence needs alignment |
| **Stop condition** | Area, intended rework, parity bar, and acceptance are clear enough to implement with comparative evaluation |
| **Alignment / definition artifact** | `REWORK.md` (path from WORKSPACE) |
| **Readiness prompt** | "Is this enough to implement the rework?" |
| **Opening** | Thin description **required**. Missing area → "What area should be reworked?" Rich (area + change pasted): first question on highest-impact gap (often the parity bar) |
| **Scope guard** | Bounded area; intentional implementation change allowed; **no silent degradation** — parity bar required; keep the define loop short (richness lives in implement comparative eval) |
| **Depth** | Lightweight — fewer questions than full define |
| **Work packages** | Optional Sub-tasks only when packages are truly separate |

## Steps

1. **Resolve context** — Require a thin area description from the invoke or ask once for it; load any related Task/Story and user-provided code pointers. Done when the rework subject (bounded area) and optional parent are identified.
2. **Align and define** — Follow the CONCEPT_ALIGNMENT flow with the definition extensions above. Done when the stop condition holds and the user approves `REWORK.md`.
3. **Persist and track** — Write the artifact, follow delivery continuity, apply the rework row in the tracker sync matrix, and persist the Handoff. Done when the Task, artifact, branch/PR, mirrors, and **Next** agree.

## Artifact

```markdown
# Rework: [title]

## Summary
- …

## Area
- …   # module, controller, mapping, internal path, …

## Current implementation
- …

## Intended implementation
- …   # e.g. replace PID with static map

## Why rework
- …

## Parity bar
- Metrics: …
- Scenarios / fixtures: …
- Tolerances / “worse” definition: …
- Baseline: …   # how current code is measured (branch, seam, recorded runs)
- Candidate: …  # how new code is measured on the same scenarios

## Acceptance criteria
- …   # include: candidate meets parity bar vs baseline; suite green

## Out of scope
- …   # unrelated behaviour changes, unrelated areas, …

## Work packages
1. …   # optional; omit if a single package is enough

## Tracker
- Task: <KEY>
- Sub-tasks: … (if any)
- Branch: <delivery-branch>
- PR: <url or draft url>

## Next
`/implement <KEY>` — Apply per REWORK.md with comparative evaluation (same branch/PR)
```

## Tracker (after approval)

Follow the [rework tracker row](../workflow/tracker-sync.md#matrix) and
[delivery continuity](../workflow/delivery.md). Create one **Task** (ordinary
type — not bug); add Sub-tasks only for genuinely separate packages. A lone
rework needs no Story unless the user requests one. Keep the Task **To Do** and
record `REWORK.md`, branch/PR, optional parent, and **Next** on every configured
durable surface.

## Handoff

```markdown
## Next
`/implement <TASK-KEY>` — Apply per REWORK.md with comparative evaluation on the same delivery branch/PR
```

(Or `/ship <TASK-KEY>` to finish remaining: implement → review-fix → closeout.)
