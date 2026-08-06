---
name: iterate
description: >-
  Iteration on already merged work through a brief delta, a new Task and branch,
  implementation, and a new PR. Use when shipped work needs another fix cycle
  before review-fix.
disable-model-invocation: true
---

# Iterate

Applies [CONCEPT_ITERATION](../concepts/CONCEPT_ITERATION.md), with brief
[CONCEPT_ALIGNMENT](../concepts/CONCEPT_ALIGNMENT.md) when needed and
[CONCEPT_IMPLEMENTATION](../concepts/CONCEPT_IMPLEMENTATION.md) for the fix.

**On invoke:** read those concepts,
[../workflow/reference.md](../workflow/reference.md),
[../workflow/delivery.md](../workflow/delivery.md),
[../workflow/tracker-sync.md](../workflow/tracker-sync.md),
[../workflow/handoff.md](../workflow/handoff.md),
[../tracker/SKILL.md](../tracker/SKILL.md).
Before implementation, read [../implement/SKILL.md](../implement/SKILL.md);
before spawning workers, also read
[CONCEPT_DELEGATION](../concepts/CONCEPT_DELEGATION.md).

## Extensions

| Slot | This skill |
|------|------------|
| **Prior context** | Explicit prior key → session just-shipped → latest Done ISSUES row → ask once. Stop if prior PR still open. |
| **Alignment depth** | Skip if invoke is enough; else ≤ few clarifying questions; stop when fix is implementable |
| **Iteration artifact** | `ITERATE.md` |
| **Branch + delivery** | New branch from WORKSPACE base; **new** PR |
| **Tracker** | New Task linked to prior; → In Progress → In Review |
| **Handoff** | `/review-fix <NEW-KEY>` |
| **Chain policy** | Each iterate Task Relates to immediate prior (or original) |

### Alignment (when needed)

| Slot | This skill |
|------|------------|
| **Subject** | Post-ship delta |
| **Probes** | Symptom vs expected; acceptance; out of scope; environment/constraint that changes the fix |
| **Stop condition** | Enough to implement without guessing |
| **Readiness prompt** | "Implement this fix now?" (default yes when invoke was rich) |

### Implementation

| Slot | This skill |
|------|------------|
| **Spec source** | `ITERATE.md` + new Task (+ prior PLAN/BUG/ITERATE as context) |
| **Branch naming** | WORKSPACE + **new** Task key |
| **Delivery** | Open new PR |
| **Verification** | Tests incl. regression for the delta; lint; non-degradation; [implement testing](../implement/testing.md) |

## Inputs

```text
/iterate <description>
/iterate <PRIOR-KEY> <description>
/iterate <PRIOR-KEY>
```

## Steps

Follow the CONCEPT_ITERATION flow with these specialisations:

1. **Resolve lineage** — Fetch the prior Task, merged PR, and PLAN/BUG/ITERATE artifacts; validate post-merge entry. Done when the prior delivery is identified and confirmed merged, or an open-PR fix-forward handoff is reported.
2. **Capture and persist the delta** — Apply the brief CONCEPT_ALIGNMENT flow when needed, write `ITERATE.md`, and create the new related Task with optional Sub-tasks. Done when the delta is implementable and artifact, lineage comments, tracker, and mirror agree.
3. **Implement on a new delivery head** — Apply CONCEPT_IMPLEMENTATION through [implement](../implement/SKILL.md), using CONCEPT_DELEGATION for workers and the iterate row in the tracker matrix. Done when checks pass, the new PR is ready, and the new Task is **In Review**.
4. **Hand off** — Report the new and prior keys, PR URL, artifact path, and persist **Next**. Done when every configured durable surface points to `/review-fix <NEW-KEY>`.

## Artifact

```markdown
# Iterate: [title]

## Prior work
- Task: <PRIOR-KEY>
- PR: <merged url or n/a>
- Spec context: PLAN.md | BUG.md | prior ITERATE.md | …

## Problem
- …

## Clarifications
- …   # omit if none

## Acceptance criteria
- …

## Out of scope
- …

## Work packages
1. …   # optional

## Tracker
- Task: <NEW-KEY>
- Relates: <PRIOR-KEY>

## Next
`/review-fix <NEW-KEY>` — Review and auto-fix (single pass)
```

## Handoff

```markdown
## Next
`/review-fix <NEW-KEY>` — Review and auto-fix on the new delivery PR
```

## Chaining

After ship on the iterate Task: problems persist → `/iterate` again (another Task +
branch + PR). Relates chain continues.
