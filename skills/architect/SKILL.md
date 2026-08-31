---
name: architect
description: >-
  Architecture step after define: record where this Task sits (modules, layers,
  seams, dependency direction) in ARCHITECTURE.md on the delivery branch. Always
  in the bound chain; depth follows the change. Use when the bound chain's
  architect phase is next, or to run that phase explicitly.
disable-model-invocation: true
---

# Architect

Applies [CONCEPT_ARCHITECTURE](../concepts/CONCEPT_ARCHITECTURE.md) to the
**current Task** after definition (and after bound research/model/sandbox).
Produces `ARCHITECTURE.md` on the **same** delivery branch. Does not open a
pull request.

**On invoke:** read CONCEPT_ARCHITECTURE above,
[CONCEPT_STRUCTURE](../concepts/CONCEPT_STRUCTURE.md),
[../concepts/STRUCTURE-CATALOG.md](../concepts/STRUCTURE-CATALOG.md),
[../workflow/reference.md](../workflow/reference.md),
[../workflow/delivery.md](../workflow/delivery.md),
[../workflow/tracker-sync.md](../workflow/tracker-sync.md),
[../workflow/handoff.md](../workflow/handoff.md), and
[../tracker/SKILL.md](../tracker/SKILL.md).

## Extensions

| Slot | This skill |
|------|------------|
| **Subject** | Shape of this Task’s solution in the existing system |
| **Artifact** | `ARCHITECTURE.md` (path from WORKSPACE) on the delivery branch |
| **Depth** | Shape stamp for bug/tweak; full map for feature/rework/adopt and boundary-moving refine |
| **Stop condition** | Implement can place code without guessing modules, layers, or seams |
| **Handoff** | `/implement` (or `/sandbox` when `sandbox=inject` and not yet promotion-ready) |

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

## Next
`/implement <KEY>` — Build to this shape
```

## Steps

1. **Resolve delivery** — Resolve the Task, definition artifact, and delivery
   branch (create the branch if missing; no PR). Done when the spec and head
   are known.
2. **Record shape** — Follow CONCEPT_ARCHITECTURE. Bug/tweak: a short **shape
   stamp**. Feature/rework/adopt/boundary refine: full map. Ask once only on a
   shape divergence. Done when `ARCHITECTURE.md` is on the delivery branch.
3. **Track and hand off** — Comment the path + **Next** `/implement`. Keep the
   Task **To Do**. Done when Task, mirror, and user report agree.

## Handoff

```markdown
## Next
`/implement <TASK-KEY>` — Build to ARCHITECTURE.md (same branch)
```
