---
name: bug
description: >-
  Fast bug-report alignment that replaces explore and define for defects.
  Produces BUG.md and a single tracker Task (optional Sub-tasks), then hands off
  to implement → review → ship. Use when fixing a bug without a full feature pipeline.
disable-model-invocation: true
---

# Bug

Applies [CONCEPT_ALIGNMENT](../concepts/CONCEPT_ALIGNMENT.md) and
[CONCEPT_DEFINITION](../concepts/CONCEPT_DEFINITION.md) to a **defect**.
Lightweight alternative to **explore** + **define** for the
[bug fix workflow](../workflow/reference.md#bug-fix-workflow).

**On invoke:** read those concepts, [../workflow/reference.md](../workflow/reference.md),
and [../tracker/SKILL.md](../tracker/SKILL.md).

## Extensions

| Slot | This skill |
|------|------------|
| **Subject** | Bug, regression, or incorrect behaviour |
| **Probes** | Symptom; minimal repro; expected vs actual; impact/severity; suspected area (no deep code dive); fix acceptance; out of scope; optional parent Story/Task link |
| **Stop condition** | Repro, expected/actual, impact, and fix acceptance are clear enough to implement |
| **Alignment / definition artifact** | `BUG.md` (path from WORKSPACE) |
| **Readiness prompt** | "Is this enough to implement the fix?" |
| **Opening** | Thin: "What is broken?" Rich (stack/steps pasted): first question on highest-impact gap |
| **Scope guard** | Defects only — features redirect to `/explore` or `/define`; no implementation during alignment; keep the loop short |
| **Depth** | Lightweight — fewer questions than full define |
| **Work packages** | Optional Sub-tasks only when packages are truly separate |

Post-ship follow-up on work that just merged → prefer `/iterate` over `/bug` → `/implement`.

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

1. Create **Task** (bug type/label when supported; else `[Bug]` prefix).
2. Description = summary + repro + expected/actual + acceptance; `attach_or_link` `BUG.md`.
3. Optional Sub-tasks only when packages are separate; prefer none for small fixes.
4. Status **To Do**.
5. Delivery branch + draft PR when committing `BUG.md` ([delivery branch continuity](../workflow/reference.md#delivery-branch-continuity-closed-loop)); external artifact location → write under external root, push into Task, still create branch for the fix.
6. `comment` path + branch + PR + **Next**; upsert ISSUES mirror; link parent if any.
7. Report key/URL, branch/PR, **Next**. Session ends.

No Story for a lone bug unless the user asks.

| Action | Required |
|--------|----------|
| Create Task (+ optional Sub-tasks) | yes |
| Start delivery branch + draft PR when committing BUG.md | yes |
| Status | **To Do** |
| Comment + branch/PR + **Next** | yes |
| ISSUES mirror | yes when enabled |
| Close / second bug-only PR | **no** |

## Handoff

```markdown
## Next
`/implement <TASK-KEY>` — Fix per BUG.md on the same delivery branch/PR
```

(Or `/ship <TASK-KEY>` to finish remaining: implement → review-fix → closeout.)
