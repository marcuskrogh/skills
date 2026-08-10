---
name: define
description: >-
  Definition front door for concrete work: thin description, alignment,
  agent classification, and workflow binding. Produces PLAN.md (with
  Classification + Workflow), Sub-tasks, and the Task's delivery branch/PR.
  Use for bugs, tweaks, refinements, reworks, and features — the agent infers
  class and binds an efficient workflow. Prefer /explore when the destination
  is foggy; prefer explicit /bug /tweak /refine /rework only as manual overrides.
disable-model-invocation: true
---

# Define

Applies [CONCEPT_ALIGNMENT](../concepts/CONCEPT_ALIGNMENT.md),
[CONCEPT_DEFINITION](../concepts/CONCEPT_DEFINITION.md), and
[CONCEPT_CLASSIFICATION](../concepts/CONCEPT_CLASSIFICATION.md) to a **specific
topic**. Produces `PLAN.md` (including **Classification** + **Workflow**
binding) and Sub-tasks on the **pipeline Task**. After bind, later skills follow
the chain **deterministically** via **Next**.

**On invoke:** read those concepts,
[../concepts/CLASSIFICATION-CATALOG.md](../concepts/CLASSIFICATION-CATALOG.md),
[../workflow/reference.md](../workflow/reference.md),
[../workflow/delivery.md](../workflow/delivery.md),
[../workflow/tracker-sync.md](../workflow/tracker-sync.md),
[../workflow/handoff.md](../workflow/handoff.md), and
[../tracker/SKILL.md](../tracker/SKILL.md).

## Extensions

| Slot | This skill |
|------|------------|
| **Subject** | Concrete work: defect, small delta, structure-only, measured impl swap, or feature slice (explore route Task when present) |
| **Probes** | Thin description of the work; scope in/out; behaviour / parity / preserve-behaviour as class requires; constraints; acceptance; work packages when needed; fog pointers; Task key; RESEARCH/MODEL as supportive only |
| **Stop condition** | Description, scope, acceptance, and class-relevant constraints are clear enough to classify and implement; binding persisted |
| **Alignment / definition artifact** | `PLAN.md` (path from WORKSPACE) — always; class lives in Classification, not a separate BUG/TWEAK file |
| **Readiness prompt** | "Does this plan and workflow binding look right?" |
| **Opening** | Thin description **required**. Missing → "What should we define?" Rich / key given: load Task (+ Story, ROADMAP, RESEARCH, MODEL); first **definition** divergence (often class-critical: defect vs intentional vs structure-only vs measured swap) |
| **Scope guard** | Stay on this Task; no foggy destination mapping (`/explore`); write approved `PLAN.md` on the delivery branch |
| **Depth** | Proportional — lightweight for bug/tweak/refine/rework classes; fuller for feature |
| **Work packages** | Sub-tasks per package when more than one unit; single package OK for small classes |
| **Class catalog** | [CLASSIFICATION-CATALOG.md](../concepts/CLASSIFICATION-CATALOG.md) |
| **Template catalog** | same |
| **Binding rules** | same |
| **Artifact sections** | `## Classification` + `## Workflow` required |
| **Tracker mirror** | Copy class, template, params, chain, and **Next** onto the Task (and Story when linked) |

## Steps

1. **Resolve entry** — Require a thin description or ask once; fetch route Task + Story when present; load ROADMAP / RESEARCH / MODEL as supportive. Done when the subject and unresolved definition divergences are known.
2. **Align and define** — Follow CONCEPT_ALIGNMENT + CONCEPT_DEFINITION with proportional depth (lightweight unless class signals feature-scale). Done when scope, acceptance, and class-relevant constraints are clear enough to classify.
3. **Classify and bind** — Apply CONCEPT_CLASSIFICATION + the catalog: infer **class**, select **template** + **parameters** (efficiency-first), confirm only on costly ambiguity. Done when Classification + Workflow are complete and accepted.
4. **Persist and track** — Write `PLAN.md`, follow delivery continuity, apply the define tracker row, mirror binding fields on the tracker, and set **Next** to the first step of the bound **Chain**. Done when artifact, Sub-tasks, branch/PR, comments, mirrors, and **Next** agree.

## Artifact

```markdown
# Implementation plan: [title]

## Summary
- …

## Scope / Decisions / Constraints
- … (user-aligned in this define session)

## Classification
- Class: bug | tweak | refine | rework | feature | iterate
- Confidence: high | medium
- Why: …

## Workflow
- Template: fix-fast | delta-fast | structure-safe | parity-iterative | feature-standard | feature-heavy
- Parameters:
  - implement.mode: single | multiagent
  - implement.verify: tests | non-regression | comparative
  - implement.iteration: one-shot | until-bar
  - review.mode: single | multiagent
  - review.depth: focused | full
  - side_paths: none | research | model | research+model
- Chain: implement → review-fix → ship
- Rationale: …

## Inputs
- Research: RESEARCH.md (if any)
- Model: MODEL.md (if any)

## Acceptance criteria
- …   # include parity bar metrics when Class is rework

## Work packages
1. …

## Open items
- …

## Tracker
- Provider: …
- Story: <KEY> (if linked)
- Task: <KEY>
- Sub-tasks: …
- Branch: <delivery-branch>
- PR: <url or draft url>
- Classification: <class>
- Workflow: <template>

## Next
`/<first-chain-skill> <KEY>` — <why>
```

(`PLAN.md` may note `/ship <KEY>` as alternate Next once the chain is bound.)

## Tracker (after approval)

Follow [delivery continuity](../workflow/delivery.md) and the
[define tracker row](../workflow/tracker-sync.md#matrix). Enrich the explore
route Task when present; otherwise create the pipeline Task. Keep it **To Do**,
create Sub-tasks per work package, and record `PLAN.md`, **Classification**,
**Workflow** (template + params + chain), branch/PR, Sub-task keys, and **Next**
on the Task, parent Story, and enabled mirror.

## Handoff

Set **Next** to the first skill in the bound **Chain** (usually `/implement`;
`/research` or `/model` when `side_paths` requires it):

```markdown
## Next
`/implement <TASK-KEY>` — Build per PLAN.md workflow binding (same branch/PR)
```

(Or `/ship <TASK-KEY>` to finish remaining along the bound chain.)
