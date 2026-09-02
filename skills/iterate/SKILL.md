---
name: iterate
description: >-
  Iteration on already merged work through a brief delta, a new Task and branch,
  implementation, and a new PR. Use when shipped work needs another fix cycle
  before the closeout chain (test, harden, review-fix). Prefer /sandbox when
  each turn needs visual, plot, or report inspection of a contained element.
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
when the delta is an inspect-loop, read [../sandbox/SKILL.md](../sandbox/SKILL.md)
instead. Before spawning workers, also read
[CONCEPT_DELEGATION](../concepts/CONCEPT_DELEGATION.md).

## Extensions

| Slot | This skill |
|------|------------|
| **Prior context** | Explicit prior key → session just-shipped → latest Done ISSUES row → ask once |
| **Alignment depth** | Skip if invoke is enough; else ≤ few clarifying questions; stop when fix is implementable |
| **Iteration artifact** | `ITERATE.md` |
| **Branch + delivery** | WORKSPACE base + **new** Task key; open new PR |
| **Tracker** | New Task Relates to prior; iterate row in [tracker-sync](../workflow/tracker-sync.md#matrix) |
| **Handoff** | `/test <NEW-KEY>` (or `/sandbox` when the delta is an inspect-loop; skip to `/harden` / `/review-fix` when bound) |
| **Chain policy** | Each iterate Task Relates to immediate prior (or original) |
| **Inspect-loop fork** | If each turn needs inspectables (visual, plots, representative comparative reports), run [sandbox](../sandbox/SKILL.md) post-merge instead of implement |

### Alignment (when needed)

| Slot | This skill |
|------|------------|
| **Subject** | Post-ship delta |
| **Probes** | Symptom vs expected; **pass criteria**; out of scope; environment/constraint that changes the fix |
| **Stop condition** | Enough to implement without guessing |
| **Readiness prompt** | "Implement this fix now?" (default yes when invoke was rich) |

### Implementation

| Slot | This skill |
|------|------------|
| **Spec source** | `ITERATE.md` + new Task (+ prior PLAN/BUG/TWEAK/REFINE/REWORK/ITERATE as context) |
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

Follow the CONCEPT_ITERATION flow. Skill specialisations:

1. **Resolve lineage** — Fetch prior Task, merged PR, and PLAN/BUG/TWEAK/REFINE/REWORK/ITERATE; apply Prior context resolution. Done when lineage is identified per the concept stop, or an open-PR fix-forward handoff is reported.
2. **Capture** — Brief CONCEPT_ALIGNMENT when needed. If the delta needs inspect-each-turn on a contained element, run [sandbox](../sandbox/SKILL.md) (post-merge entry) and stop. Done when sandbox owns **Next**, or the delta is a straightforward production fix ready to persist.
3. **Persist and implement** — Write `ITERATE.md`; create related Task (+ optional Sub-tasks); comment prior; upsert ISSUES; run [implement](../implement/SKILL.md) Build on `<NEW-KEY>` with CONCEPT_DELEGATION. Done when checks pass, new PR ready, Task **In Progress**.
4. **Hand off** — Persist **Next** on every configured durable surface. Done when all point to `/test <NEW-KEY>` (or the first remaining closeout step).

## Artifact

```markdown
# Iterate: [title]

## Prior work
- Task: <PRIOR-KEY>
- PR: <merged url or n/a>
- Spec context: PLAN.md | BUG.md | TWEAK.md | REFINE.md | REWORK.md | ADOPT.md | prior ITERATE.md | …

## Problem
- …

## Clarifications
- …   # omit if none

## Pass criteria
- …

## Out of scope
- …

## Work packages
1. …   # optional

## Tracker
- Task: <NEW-KEY>
- Relates: <PRIOR-KEY>

## Next
`/test <NEW-KEY>` — Dedicated testing phase, then harden and code review
```

## Handoff

```markdown
## Next
`/test <NEW-KEY>` — Dedicated testing phase on the new delivery PR
```

When step 2 forked to sandbox, that skill's **Next** applies (`/sandbox` or
`/implement`); do not write the `/test` block above.
