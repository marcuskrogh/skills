---
name: bug
description: >-
  Bug alignment and lightweight definition for a clear defect. Produces BUG.md
  and one tracker Task, then hands off to implementation. Prefer /define for
  new work (agent classifies as bug).
disable-model-invocation: true
---

# Bug

Applies [CONCEPT_ALIGNMENT](../concepts/CONCEPT_ALIGNMENT.md) and
[CONCEPT_DEFINITION](../concepts/CONCEPT_DEFINITION.md) to a **defect**.
Produces `BUG.md`. Shared persist/track contract:
[../define/overrides.md](../define/overrides.md).

**On invoke:** read [../define/overrides.md](../define/overrides.md).

## Extensions

| Slot | This skill |
|------|------------|
| **Subject** | Bug, regression, or incorrect behaviour |
| **Probes** | Symptom; minimal repro; expected vs actual; impact/severity; suspected area (no deep code dive); **pass criteria**; out of scope; optional parent Story/Task link |
| **Stop condition** | Repro, expected/actual, impact, and pass criteria are clear enough to implement |
| **Alignment / definition artifact** | `BUG.md` (path from WORKSPACE) |
| **Readiness prompt** | "Is this enough to implement the fix?" |
| **Opening** | Thin: "What is broken?" Rich (stack/steps pasted): first question on highest-impact gap |
| **Scope guard** | Defect pass criteria and optional lineage only; keep the loop short |
| **Depth** | Lightweight |
| **Work packages** | Optional Sub-tasks only when packages are truly separate |

## Artifact

```markdown
# Bug: [title]

## Summary
- …

## Repro
1. …

## Expected
- …

## Actual
- …

## Impact
- …

## Suspected area
- …

## Pass criteria
- …   # observable that fails if the defect remains

## Out of scope
- …

## Work packages
1. …   # optional; omit if a single fix commit is enough

## Tracker
- Task: <KEY>
- Sub-tasks: … (if any)
- Branch: <delivery-branch>
- PR: <url or draft url>

## Next
`/implement <KEY>` — Fix per BUG.md (same branch/PR)
```
