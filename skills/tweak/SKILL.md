---
name: tweak
description: >-
  Tweak alignment and lightweight definition for a small intentional change to
  existing behaviour. Produces TWEAK.md and one tracker Task, then hands off to
  implementation. Prefer /define for new work (agent classifies).
disable-model-invocation: true
---

# Tweak

Applies [CONCEPT_ALIGNMENT](../concepts/CONCEPT_ALIGNMENT.md) and
[CONCEPT_DEFINITION](../concepts/CONCEPT_DEFINITION.md) to a **small intentional
delta** on existing behaviour. Produces `TWEAK.md`. Shared persist/track
contract: [../define/overrides.md](../define/overrides.md).

**On invoke:** read [../define/overrides.md](../define/overrides.md).

## Extensions

| Slot | This skill |
|------|------------|
| **Subject** | Small intentional change to existing behaviour (extend a pattern, add a field, adjust a clear edge) |
| **Probes** | Desired change; where it applies; precedent elsewhere in the codebase (if any); **pass criteria**; out of scope; optional parent Story/Task link |
| **Stop condition** | Desired change, where, and pass criteria are clear enough to implement |
| **Alignment / definition artifact** | `TWEAK.md` (path from WORKSPACE) |
| **Readiness prompt** | "Is this enough to implement the tweak?" |
| **Opening** | Thin: "What do you want to tweak?" Rich (change + area pasted): first question on highest-impact gap |
| **Scope guard** | Intentional delta only; keep the loop short; no feature discovery |
| **Depth** | Lightweight |
| **Work packages** | Optional Sub-tasks only when packages are truly separate |

## Artifact

```markdown
# Tweak: [title]

## Summary
- …

## Desired change
- …

## Where
- …

## Precedent
- …   # omit if none

## Pass criteria
- …   # one observable per row; fail if the desired change is unmet

## Out of scope
- …

## Work packages
1. …   # optional; omit if a single commit is enough

## Tracker
- Task: <KEY>
- Sub-tasks: … (if any)
- Branch: <delivery-branch>
- PR: <url or draft url>

## Next
`/implement <KEY>` — Apply per TWEAK.md (same branch/PR)
```
