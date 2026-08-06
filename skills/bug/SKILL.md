---
name: bug
description: >-
  Bug alignment and lightweight definition for a clear defect. Produces BUG.md
  and one tracker Task (optional Sub-tasks), then hands off to implementation.
  Use when the fix is the work and no feature discovery is needed. Prefer
  /tweak for small intentional changes that are not defects.
disable-model-invocation: true
---

# Bug

Applies [CONCEPT_ALIGNMENT](../concepts/CONCEPT_ALIGNMENT.md) and
[CONCEPT_DEFINITION](../concepts/CONCEPT_DEFINITION.md) to a **defect**.
Produces an implementation-ready `BUG.md` through lightweight alignment.

**On invoke:** read those concepts, [../workflow/reference.md](../workflow/reference.md),
[../workflow/delivery.md](../workflow/delivery.md),
[../workflow/tracker-sync.md](../workflow/tracker-sync.md),
[../workflow/handoff.md](../workflow/handoff.md), and
[../tracker/SKILL.md](../tracker/SKILL.md).

## Extensions

| Slot | This skill |
|------|------------|
| **Subject** | Bug, regression, or incorrect behaviour |
| **Probes** | Symptom; minimal repro; expected vs actual; impact/severity; suspected area (no deep code dive); fix acceptance; out of scope; optional parent Story/Task link |
| **Stop condition** | Repro, expected/actual, impact, and fix acceptance are clear enough to implement |
| **Alignment / definition artifact** | `BUG.md` (path from WORKSPACE) |
| **Readiness prompt** | "Is this enough to implement the fix?" |
| **Opening** | Thin: "What is broken?" Rich (stack/steps pasted): first question on highest-impact gap |
| **Scope guard** | Defect acceptance and optional lineage only; keep the loop short |
| **Depth** | Lightweight — fewer questions than full define |
| **Work packages** | Optional Sub-tasks only when packages are truly separate |

## Steps

1. **Resolve context** — Load any related Task/Story and user-provided code pointers. Done when the defect subject and optional parent are identified.
2. **Align and define** — Follow the CONCEPT_ALIGNMENT flow with the definition extensions above. Done when the stop condition holds and the user approves `BUG.md`.
3. **Persist and track** — Write the artifact, follow delivery continuity, apply the bug row in the tracker sync matrix, and persist the Handoff. Done when the Task, artifact, branch/PR, mirrors, and **Next** agree.

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

## Acceptance criteria
- …

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

## Tracker (after approval)

Follow the [bug tracker row](../workflow/tracker-sync.md#matrix) and
[delivery continuity](../workflow/delivery.md). Create one **Task** using the
provider's bug type/label (or `[Bug]` prefix); add Sub-tasks only for genuinely
separate packages. A lone bug needs no Story unless the user requests one.
Keep the Task **To Do** and record `BUG.md`, branch/PR, optional parent, and
**Next** on every configured durable surface.

## Handoff

```markdown
## Next
`/implement <TASK-KEY>` — Fix per BUG.md on the same delivery branch/PR
```

(Or `/ship <TASK-KEY>` to finish remaining: implement → review-fix → closeout.)
