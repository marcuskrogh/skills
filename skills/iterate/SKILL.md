---
name: iterate
description: >-
  Post-ship follow-up: brief clarifying alignment on a reported issue with already
  merged work, new branch from base, implement the fix, open a new PR, then hand
  off to review-fix. Use when a shipped Task/PR needs another fix cycle; invoke
  again if problems persist after the next ship.
disable-model-invocation: true
---

# Iterate

Applies [CONCEPT_ITERATION](../concepts/CONCEPT_ITERATION.md), with brief
[CONCEPT_ALIGNMENT](../concepts/CONCEPT_ALIGNMENT.md) when needed and
[CONCEPT_IMPLEMENTATION](../concepts/CONCEPT_IMPLEMENTATION.md) for the fix.

**On invoke:** read those concepts, [../concepts/CONCEPT_DELEGATION.md](../concepts/CONCEPT_DELEGATION.md),
[../workflow/reference.md](../workflow/reference.md),
[../implement/SKILL.md](../implement/SKILL.md), and
[../tracker/SKILL.md](../tracker/SKILL.md).

Open PR needs review fixes → `/review-fix` / fix-forward, not iterate. Brand-new
unrelated defect → `/bug`. New feature → `/explore` / `/define`.

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

1. **Resolve prior** — fetch Task; load PLAN/BUG/ITERATE + merged PR. Open PR → stop, redirect to fix-forward.
2. **Brief alignment** — rich invoke: draft artifact; thin: one question at a time until implementable. No full define/bug questionnaire.
3. **Persist** — write `ITERATE.md` (on new branch, or external root + push into Task); create new Task (Relates prior); optional Sub-tasks; comment prior; upsert ISSUES.
4. **Implement** — [implement](../implement/SKILL.md) Build on `<NEW-KEY>`: branch from current base; In Progress → workers via CONCEPT_DELEGATION → verify → **new** PR → In Review. Do not merge or Done.
5. **Tell user** — new key, prior key, PR URL, `ITERATE.md` path, **Next**.

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

## Chaining

After ship on the iterate Task: problems persist → `/iterate` again (another Task +
branch + PR). Relates chain continues.
