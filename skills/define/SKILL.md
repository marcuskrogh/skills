---
name: define
description: >-
  Alignment on a concrete component, system, or pipeline Task before coding.
  Produces PLAN.md, Sub-tasks, and the Task's delivery branch/PR. Use when a
  buildable slice needs user-approved scope, behaviour, and acceptance. Prefer
  /tweak when the change is a small intentional delta on existing behaviour;
  prefer /refine when improving a bounded area without changing behaviour.
disable-model-invocation: true
---

# Define

Applies [CONCEPT_ALIGNMENT](../concepts/CONCEPT_ALIGNMENT.md) and
[CONCEPT_DEFINITION](../concepts/CONCEPT_DEFINITION.md) to a **specific topic**.
Produces `PLAN.md` and Sub-tasks on the **pipeline Task**.

**On invoke:** read those concepts, [../workflow/reference.md](../workflow/reference.md),
[../workflow/delivery.md](../workflow/delivery.md),
[../workflow/tracker-sync.md](../workflow/tracker-sync.md),
[../workflow/handoff.md](../workflow/handoff.md), and
[../tracker/SKILL.md](../tracker/SKILL.md).

## Extensions

| Slot | This skill |
|------|------------|
| **Subject** | Component, system, feature, or explore route (define) Task |
| **Probes** | Scope in/out; behaviour divergences; constraints; acceptance; work packages; fog pointers on this route Task; Task key; how to apply `RESEARCH.md` / `MODEL.md` |
| **Stop condition** | No obvious divergences remain for scope, behaviour, constraints, acceptance — resolved **with the user** |
| **Alignment / definition artifact** | `PLAN.md` (path from WORKSPACE) |
| **Readiness prompt** | "Does this plan look complete?" |
| **Opening** | Thin: "What do you want to define?" (or resolve Task key). Rich / key given: load Task (+ Story, ROADMAP, RESEARCH, MODEL if present); first **definition** divergence with the user |
| **Scope guard** | Stay on this route Task; write approved `PLAN.md` on its delivery branch |
| **Depth** | Full feature definition |
| **Work packages** | Sub-tasks per package |

## Steps

1. **Resolve entry** — Fetch the route Task + Story and load ROADMAP / RESEARCH / MODEL as supportive context. Done when the subject, existing decisions, and unresolved definition divergences are known.
2. **Align and define** — Follow the CONCEPT_ALIGNMENT flow with the definition extensions above. Done when the stop condition holds and the user approves `PLAN.md`.
3. **Persist and track** — Write the artifact, follow delivery continuity, apply the define row in the tracker sync matrix, and persist the Handoff. Done when `PLAN.md`, Sub-tasks, branch/PR, comments, mirrors, and **Next** agree.

## Artifact

```markdown
# Implementation plan: [title]

## Summary
- …

## Scope / Decisions / Constraints
- … (user-aligned in this define session)

## Inputs
- Research: RESEARCH.md (if any)
- Model: MODEL.md (if any)

## Acceptance criteria
- …

## Work packages
1. …
2. …

## Open items
- …

## Tracker
- Provider: …
- Story: <KEY> (if linked)
- Task: <KEY>
- Sub-tasks: …
- Branch: <delivery-branch>
- PR: <url or draft url>

## Next
`/implement <KEY>` — Build per this plan (same branch/PR)
```

(`PLAN.md` may note `/ship <KEY>` as alternate Next.)

## Tracker (after approval)

Follow [delivery continuity](../workflow/delivery.md) and the
[define tracker row](../workflow/tracker-sync.md#matrix). Enrich the explore
route Task when present; otherwise create the pipeline Task. Keep it **To Do**,
create Sub-tasks per work package, and record `PLAN.md`, branch/PR, Sub-task
keys, and **Next** on the Task, parent Story, and enabled mirror.

## Handoff

```markdown
## Next
`/implement <TASK-KEY>` — Build per PLAN.md on the same delivery branch/PR
```

(Or `/ship <TASK-KEY>` to finish remaining: implement → review-fix → closeout.)
