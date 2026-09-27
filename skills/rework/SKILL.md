---
name: rework
description: >-
  Rework alignment and lightweight definition for an intentional implementation
  change that must not degrade measured outcomes. Produces REWORK.md and one
  tracker Task with a parity-iterative binding. Prefer /define for new work
  (agent classifies as rework).
disable-model-invocation: true
---

# Rework

Applies [CONCEPT_ALIGNMENT](../concepts/CONCEPT_ALIGNMENT.md) and
[CONCEPT_DEFINITION](../concepts/CONCEPT_DEFINITION.md) to a **bounded rework**.
Produces `REWORK.md`. Comparative verification notes:
[../implement/rework.md](../implement/rework.md). Shared persist/track contract:
[../define/overrides.md](../define/overrides.md). Applies
[CONCEPT_SKILL](../concepts/CONCEPT_SKILL.md).

**On invoke:** read [../define/overrides.md](../define/overrides.md) and
[../implement/rework.md](../implement/rework.md).

## Extensions

| Slot | This skill |
|------|------------|
| **Subject** | Limited area whose implementation should change (algorithm, control law, mapping, internal path) while measured outcomes stay within a declared bar |
| **Probes** | Area boundary; thin description of current vs intended implementation; why rework; **parity bar** (metrics, scenarios, tolerances, how baseline is obtained); **pass criteria**; out of scope; optional parent Story/Task link; optional `/model` when math equivalence needs alignment |
| **Stop condition** | The user has stated the area, intended rework, parity bar, and pass criteria (or explicitly deferred one) and approved the readiness prompt |
| **Alignment / definition artifact** | `REWORK.md` (path from WORKSPACE) |
| **Readiness prompt** | "Is this enough to implement the rework?" |
| **Opening** | Thin description **required**. Missing area → "What area should be reworked?" Rich (area + change pasted): first question on highest-impact gap (often the parity bar) |
| **Scope guard** | Bounded area; intentional implementation change allowed; **no silent degradation** — parity bar required; keep the define loop short (richness lives in implement comparative eval) |
| **Depth** | Lightweight |
| **Work packages** | Optional Sub-tasks only when packages are truly separate |

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

## Pass criteria
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

## Classification
- Class: rework
- Confidence: high
- Why: explicit /rework

## Workflow
- Template: parity-iterative
- Parameters: catalog defaults for parity-iterative (`implement.verify=comparative`, `implement.iteration=until-bar`)
- Chain: delivery chain for that template
```

## Inputs

| Input | When present | When absent |
|-------|----------------|-------------|
| Area and intended implementation change | Apply them | Ask "What area should be reworked?" once |
| Parity bar | Apply it | Align the bar in this invocation before the artifact is approved |

## Output

`REWORK.md` — rework spec, parity bar, and the parity-iterative binding. Outcome: `ready`.

This skill does not name a successor. Apply the workflow transition before the turn ends.
