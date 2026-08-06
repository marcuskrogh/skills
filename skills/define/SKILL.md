---
name: define
description: >-
  Define a component, system, or pipeline Task before coding via user-agent
  alignment. Enriches an explore route/define Task (or creates a Task) with
  PLAN.md, Sub-tasks, and the Task’s delivery branch/PR for closed-loop ship.
  Explore charts the foggy map; research/model add supportive inputs — define owns
  particulars and always questions the user. Persists keys and Next in markdown.
  Use when agreeing on a definition before implementation.
disable-model-invocation: true
---

# Define

Applies [CONCEPT_ALIGNMENT](../concepts/CONCEPT_ALIGNMENT.md) and
[CONCEPT_DEFINITION](../concepts/CONCEPT_DEFINITION.md) to a **specific topic**.
Produces `PLAN.md` and Sub-tasks on the **pipeline Task**.

**On invoke:** read those concepts, [../workflow/reference.md](../workflow/reference.md),
and [../tracker/SKILL.md](../tracker/SKILL.md).

## Extensions

| Slot | This skill |
|------|------------|
| **Subject** | Component, system, feature, or explore route (define) Task |
| **Probes** | CONCEPT_DEFINITION defaults + fog pointers on this route Task; Task key from explore; how to apply `RESEARCH.md` / `MODEL.md` — ask, do not assume |
| **Stop condition** | No obvious divergences remain for scope, behaviour, constraints, acceptance — resolved **with the user** |
| **Alignment / definition artifact** | `PLAN.md` (path from WORKSPACE) |
| **Readiness prompt** | "Does this plan look complete?" |
| **Opening** | Thin: "What do you want to define?" (or resolve Task key). Rich / key given: load Task (+ Story, ROADMAP, RESEARCH, MODEL if present); first **definition** divergence with the user |
| **Scope guard** | No production code; no worker delegation; stay on this route step (no map-level wayfinding); writing `PLAN.md` on the delivery branch after approval is required |
| **Depth** | Full feature definition |
| **Work packages** | Sub-tasks per package |

Prior artifacts (`ROADMAP.md`, `RESEARCH.md`, `MODEL.md`) **orient** — they do not
replace probes. If literature or math is still missing, hand off to `/research` or
`/model`, then return and still probe the user.

## Steps

1. **Entry (route Task key)** — `fetch` Task + Story; load ROADMAP / RESEARCH / MODEL as supportive context; treat Task body as the route step (particulars still open unless answered in this session). Done when alignment can start.
2. **Align** — CONCEPT_ALIGNMENT + CONCEPT_DEFINITION. Done when stop condition + readiness approval hold.
3. **Persist + track** — below. Done when PLAN.md, Sub-tasks, branch/PR, comments, and **Next** are written.

## Artifact

```markdown
# Implementation plan: [title]

## Summary
- …

## Scope / Decisions / Constraints
- … (user-aligned in this define session)

## Inputs (supportive — not substitutes for decisions above)
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

Follow one-issue continuity, [delivery branch continuity](../workflow/reference.md#delivery-branch-continuity-closed-loop),
and the [tracker sync matrix](../workflow/reference.md#tracker-sync-matrix-mandatory).

**Explore route Task (preferred):** update that Task (stay **To Do**); create Sub-tasks
per package; reuse or create delivery branch + draft PR (same PR implement will use —
never a second define-only PR); external artifact location → write under external root
and push content into Task, still create branch for delivery; `attach_or_link` +
comment Task/Story with path, branch, PR, Sub-task keys, **Next**; upsert ISSUES mirror.

**Standalone:** create Task + Sub-tasks (**To Do**), then same artifact/branch/PR steps.

| Action | Required |
|--------|----------|
| Enrich Task / create Sub-tasks | yes |
| Start or reuse delivery branch + draft PR | yes when committing PLAN.md |
| Task status | remain **To Do** |
| Comments + branch/PR + **Next** | Task + Story |
| ISSUES mirror | yes when enabled |
| Close Task / second PR for define alone | **no** |

## Handoff

```markdown
## Next
`/implement <TASK-KEY>` — Build per PLAN.md on the same delivery branch/PR
```

(Or `/ship <TASK-KEY>` to finish remaining: implement → review-fix → closeout.)
