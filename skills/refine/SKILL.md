---
name: refine
description: >-
  Refine alignment and lightweight definition for a limited codebase area that
  needs structural or descriptive improvement without changing behaviour.
  Requires a thin area description. Produces REFINE.md and one tracker Task
  (optional Sub-tasks), then hands off to implementation. Use when a class,
  feature slice, README, or other bounded surface is outdated relative to
  current architecture or conventions. Prefer /define for new work (agent
  classifies as refine). Prefer /tweak for intentional behaviour changes
  without a comparative bar; prefer /rework when replacing an implementation
  that must not degrade measured outcomes; prefer /bug for defects.
disable-model-invocation: true
---

# Refine

Applies [CONCEPT_ALIGNMENT](../concepts/CONCEPT_ALIGNMENT.md) and
[CONCEPT_DEFINITION](../concepts/CONCEPT_DEFINITION.md) to a **bounded
refinement** of an existing area. Produces an implementation-ready `REFINE.md`
through lightweight alignment.

**On invoke:** read those concepts, [../workflow/reference.md](../workflow/reference.md),
[../workflow/delivery.md](../workflow/delivery.md),
[../workflow/tracker-sync.md](../workflow/tracker-sync.md),
[../workflow/handoff.md](../workflow/handoff.md), and
[../tracker/SKILL.md](../tracker/SKILL.md).

## Extensions

| Slot | This skill |
|------|------------|
| **Subject** | Limited area (class, module, functionality, README, comments, or similar) whose structure or description is outdated or otherwise needs refinement |
| **Probes** | Area boundary; thin description of what feels outdated or rough; target architecture/conventions to align with; preserve-behaviour constraint (executable behaviour stays the same); acceptance; out of scope; optional parent Story/Task link |
| **Stop condition** | Area, refinement intent, preserve-behaviour bar, and acceptance are clear enough to implement |
| **Alignment / definition artifact** | `REFINE.md` (path from WORKSPACE) |
| **Readiness prompt** | "Is this enough to implement the refinement?" |
| **Opening** | Thin description **required**. Missing area → "What area should be refined?" Rich (area + why pasted): first question on highest-impact gap |
| **Scope guard** | Bounded area only; **no intentional behaviour change** for running code — refine structure, naming, layering, comments, and docs to match current codebase characteristics; keep the loop short |
| **Depth** | Lightweight — fewer questions than full define |
| **Work packages** | Optional Sub-tasks only when packages are truly separate |

## Steps

1. **Resolve context** — Require a thin area description from the invoke or ask once for it; load any related Task/Story and user-provided code pointers. Done when the refine subject (bounded area) and optional parent are identified.
2. **Align and define** — Follow the CONCEPT_ALIGNMENT flow with the definition extensions above. Done when the stop condition holds and the user approves `REFINE.md`.
3. **Persist and track** — Write the artifact, follow delivery continuity, apply the refine row in the tracker sync matrix, and persist the Handoff. Done when the Task, artifact, branch/PR, mirrors, and **Next** agree.

## Artifact

```markdown
# Refine: [title]

## Summary
- …

## Area
- …   # class, module, functionality, README, comments, …

## Why refine
- …   # outdated relative to architecture / conventions / recent work

## Target characteristics
- …   # patterns, layering, naming, docs style to align with

## Preserve behaviour
- Yes — executable behaviour unchanged; structure/docs/comments only
- Verification: …

## Desired refinement
- …

## Acceptance criteria
- …

## Out of scope
- …   # behaviour changes, unrelated areas, …

## Work packages
1. …   # optional; omit if a single commit is enough

## Tracker
- Task: <KEY>
- Sub-tasks: … (if any)
- Branch: <delivery-branch>
- PR: <url or draft url>

## Next
`/implement <KEY>` — Apply per REFINE.md (same branch/PR)
```

## Tracker (after approval)

Follow the [refine tracker row](../workflow/tracker-sync.md#matrix) and
[delivery continuity](../workflow/delivery.md). Create one **Task** (ordinary
type — not bug); add Sub-tasks only for genuinely separate packages. A lone
refine needs no Story unless the user requests one. Keep the Task **To Do** and
record `REFINE.md`, branch/PR, optional parent, and **Next** on every configured
durable surface.

## Handoff

```markdown
## Next
`/implement <TASK-KEY>` — Apply per REFINE.md on the same delivery branch/PR
```

(Or `/ship <TASK-KEY>` to finish remaining along the bound chain.)
