---
name: tweak
description: >-
  Tweak alignment and lightweight definition for a small intentional change to
  existing behaviour. Produces TWEAK.md and one tracker Task (optional
  Sub-tasks), then hands off to implementation. Use when the change is clear,
  not a defect, and too small for full feature definition. Prefer /define for
  new work (agent classifies). Prefer /refine when the area needs structural or
  descriptive improvement without behaviour change; prefer /rework when the
  implementation changes but measured outcomes must hold.
disable-model-invocation: true
---

# Tweak

Applies [CONCEPT_ALIGNMENT](../concepts/CONCEPT_ALIGNMENT.md) and
[CONCEPT_DEFINITION](../concepts/CONCEPT_DEFINITION.md) to a **small intentional
delta** on existing behaviour. Produces an implementation-ready `TWEAK.md`
through lightweight alignment.

**On invoke:** read those concepts, [../workflow/reference.md](../workflow/reference.md),
[../workflow/delivery.md](../workflow/delivery.md),
[../workflow/tracker-sync.md](../workflow/tracker-sync.md),
[../workflow/handoff.md](../workflow/handoff.md), and
[../tracker/SKILL.md](../tracker/SKILL.md).

## Extensions

| Slot | This skill |
|------|------------|
| **Subject** | Small intentional change to existing behaviour (extend a pattern, add a field, adjust a clear edge) |
| **Probes** | Desired change; where it applies; precedent elsewhere in the codebase (if any); acceptance; out of scope; optional parent Story/Task link |
| **Stop condition** | Desired change, where, and acceptance are clear enough to implement |
| **Alignment / definition artifact** | `TWEAK.md` (path from WORKSPACE) |
| **Readiness prompt** | "Is this enough to implement the tweak?" |
| **Opening** | Thin: "What do you want to tweak?" Rich (change + area pasted): first question on highest-impact gap |
| **Scope guard** | Intentional delta only; keep the loop short; no feature discovery |
| **Depth** | Lightweight — fewer questions than full define |
| **Work packages** | Optional Sub-tasks only when packages are truly separate |

## Steps

1. **Resolve context** — Load any related Task/Story and user-provided code pointers. Done when the tweak subject and optional parent are identified.
2. **Align and define** — Follow the CONCEPT_ALIGNMENT flow with the definition extensions above. Done when the stop condition holds and the user approves `TWEAK.md`.
3. **Persist and track** — Write the artifact, follow delivery continuity, apply the tweak row in the tracker sync matrix, and persist the Handoff. Done when the Task, artifact, branch/PR, mirrors, and **Next** agree.

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

## Acceptance criteria
- …

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

## Tracker (after approval)

Follow the [tweak tracker row](../workflow/tracker-sync.md#matrix) and
[delivery continuity](../workflow/delivery.md). Create one **Task** (ordinary
type — not bug); add Sub-tasks only for genuinely separate packages. A lone
tweak needs no Story unless the user requests one. Keep the Task **To Do** and
record `TWEAK.md`, branch/PR, optional parent, and **Next** on every configured
durable surface.

## Handoff

```markdown
## Next
`/implement <TASK-KEY>` — Apply per TWEAK.md on the same delivery branch/PR
```

(Or `/ship <TASK-KEY>` to finish remaining along the bound chain.)
