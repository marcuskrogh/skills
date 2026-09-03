---
name: refine
description: >-
  Refine alignment and lightweight definition for a limited area that needs
  refactoring or descriptive improvement without changing behaviour. Produces
  REFINE.md and one tracker Task. Prefer /adopt for a whole tree; prefer
  /define for new work (agent classifies as refine).
disable-model-invocation: true
---

# Refine

Applies [CONCEPT_ALIGNMENT](../concepts/CONCEPT_ALIGNMENT.md) and
[CONCEPT_DEFINITION](../concepts/CONCEPT_DEFINITION.md) to a **bounded
refinement**. Produces `REFINE.md`. Shared persist/track contract:
[../define/overrides.md](../define/overrides.md).

**On invoke:** read [../define/overrides.md](../define/overrides.md).

## Extensions

| Slot | This skill |
|------|------------|
| **Subject** | Limited area (class, module, functionality, README, comments, or similar) whose structure or description is outdated or otherwise needs refinement |
| **Probes** | Area boundary; thin description of what feels outdated or rough; target architecture/conventions to align with; preserve-behaviour constraint (executable behaviour stays the same); **pass criteria**; out of scope; optional parent Story/Task link |
| **Stop condition** | Area, refinement intent, preserve-behaviour bar, and pass criteria are clear enough to implement |
| **Alignment / definition artifact** | `REFINE.md` (path from WORKSPACE) |
| **Readiness prompt** | "Is this enough to implement the refinement?" |
| **Opening** | Thin description **required**. Missing area → "What area should be refined?" Rich (area + why pasted): first question on highest-impact gap |
| **Scope guard** | Bounded area only; **no intentional behaviour change** for running code — refine structure, naming, layering, comments, and docs to match current codebase characteristics; keep the loop short |
| **Depth** | Lightweight |
| **Work packages** | Optional Sub-tasks only when packages are truly separate |

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

## Pass criteria
- …   # structure/docs outcome that a review or check can fail; docs-only: none — no executable behaviour

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
