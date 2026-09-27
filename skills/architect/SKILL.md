---
name: architect
description: >-
  Architecture for one Task: record where the work sits (modules, layers,
  seams, dependency direction) in ARCHITECTURE.md. Depth follows the change.
  Use standalone, or when a delivery workflow reaches this step.
disable-model-invocation: true
---

# Architect

Applies [CONCEPT_ARCHITECTURE](../concepts/CONCEPT_ARCHITECTURE.md) and
[CONCEPT_SKILL](../concepts/CONCEPT_SKILL.md) to the **current Task**.
Produces `ARCHITECTURE.md` on the delivery branch. Does not open a pull request.

**On invoke:** read CONCEPT_ARCHITECTURE,
[CONCEPT_SKILL](../concepts/CONCEPT_SKILL.md),
[CONCEPT_STRUCTURE](../concepts/CONCEPT_STRUCTURE.md),
[../concepts/STRUCTURE-CATALOG.md](../concepts/STRUCTURE-CATALOG.md),
and [../workflow/SKILL.md](../workflow/SKILL.md). When the definition spec is
absent, also read [CONCEPT_DEFINITION](../concepts/CONCEPT_DEFINITION.md),
[CONCEPT_ALIGNMENT](../concepts/CONCEPT_ALIGNMENT.md), and
[CONCEPT_CLASSIFICATION](../concepts/CONCEPT_CLASSIFICATION.md).

## Extensions

| Slot | This skill |
|------|------------|
| **Subject** | Shape of this Task’s solution in the existing system |
| **Artifact** | `ARCHITECTURE.md` (path from WORKSPACE) on the delivery branch |
| **Depth** | Shape stamp for bug/tweak; full map for feature/rework/adopt and boundary-moving refine |
| **Stop condition** | A later implement step can place code without guessing modules, layers, or seams |

## Artifact

```markdown
# Architecture: [title]

## Shape
- Lives: <module / layer / package>
- Depends on: <inward ports only>
- Seams: <injectable boundaries tests will use>
- Will not add: <layers, frameworks, types we refuse>

## Neighbourhood
- Opened modules/boundaries: …
- Major refinement (or none): …

## Tracker
- Task: <KEY>
- Branch: …
```

## Inputs

| Input | When present | When absent |
|-------|----------------|-------------|
| Definition spec (`PLAN.md`, `BUG.md`, `TWEAK.md`, `REFINE.md`, `REWORK.md`, `ITERATE.md`, or `ADOPT.md`) | Apply it. Do not reopen settled behaviour | Define it in this invocation (CONCEPT_ALIGNMENT, CONCEPT_DEFINITION, CONCEPT_CLASSIFICATION) and write that spec, then apply it |
| `RESEARCH.md`, `MODEL.md`, `SANDBOX.md` | Apply as supportive context | Continue without them |

## Output

`ARCHITECTURE.md` — shape of this Task. Outcome: `ready`.

This skill does not name a successor. Apply the workflow transition before the turn ends.

## Steps

1. **Resolve inputs** — Apply CONCEPT_SKILL to the definition spec. Create the delivery branch if missing; do not open a PR. Done when the spec exists and the head is known.
2. **Record shape** — Follow CONCEPT_ARCHITECTURE. Bug/tweak: a short **shape stamp**. Feature/rework/adopt/boundary refine: full map. Ask once only on a shape divergence. Done when `ARCHITECTURE.md` is on the delivery branch.
3. **Track** — Comment the path. Keep the Task **To Do**. Record outcome `ready`. Apply the workflow transition. Done when Task, mirror, and user report agree.
