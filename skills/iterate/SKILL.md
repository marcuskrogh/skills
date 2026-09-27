---
name: iterate
description: >-
  Iteration on already merged work. Produces ITERATE.md and a new Task and
  branch. Use when shipped work needs another fix cycle. When each turn needs
  visual, plot, or report inspection, the outcome is inspect-loop.
disable-model-invocation: true
---

# Iterate

Applies [CONCEPT_ITERATION](../concepts/CONCEPT_ITERATION.md) and
[CONCEPT_SKILL](../concepts/CONCEPT_SKILL.md), with brief
[CONCEPT_ALIGNMENT](../concepts/CONCEPT_ALIGNMENT.md) when needed.

**On invoke:** read those concepts and [../workflow/SKILL.md](../workflow/SKILL.md).

## Extensions

| Slot | This skill |
|------|------------|
| **Prior context** | Explicit prior key → session just-shipped → latest Done ISSUES row → ask once |
| **Alignment depth** | Skip further questions only when the invoke states the wrong behaviour and the pass criteria. Otherwise one question at a time until both are stated |
| **Iteration artifact** | `ITERATE.md` |
| **Branch + delivery** | WORKSPACE base + **new** Task key. The iterate workflow's later implement step opens the PR |
| **Tracker** | New Task Relates to prior; iterate row in [tracker-sync](../workflow/tracker-sync.md#matrix) |
| **Chain policy** | Each iterate Task Relates to immediate prior (or original) |
| **Inspect-loop** | If each turn needs inspectables (visual, plots, representative comparative reports), outcome `inspect-loop`. Otherwise outcome `ready` |

### Alignment (when needed)

| Slot | This skill |
|------|------------|
| **Subject** | Post-ship delta |
| **Probes** | Symptom vs expected; **pass criteria**; out of scope; environment/constraint that changes the fix |
| **Stop condition** | Enough to implement without guessing |
| **Readiness prompt** | "Implement this fix now?" (default yes when invoke was rich) |

## Steps

Follow the CONCEPT_ITERATION flow. Skill specialisations:

1. **Resolve lineage** — Fetch prior Task, merged PR, and PLAN/BUG/TWEAK/REFINE/REWORK/ITERATE; apply Prior context resolution. If the prior PR is still open, stop: this skill applies only after merge. Done when lineage is identified per the concept stop, or the open-PR stop is reported.
2. **Capture** — Brief CONCEPT_ALIGNMENT when needed. If the delta needs inspect-each-turn on a contained element, record that on the spec. Done when the delta is ready to persist as `ready` or `inspect-loop`.
3. **Persist** — Write `ITERATE.md`; create the related Task (+ optional Sub-tasks); comment prior; upsert ISSUES. Record the outcome. Apply the workflow transition (the iterate workflow continues). Done when the artifact and new Task exist and the transition has been applied.

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
```

## Inputs

The invoke line is the subject, not an upstream spec:

```text
/iterate <description>
/iterate <PRIOR-KEY> <description>
/iterate <PRIOR-KEY>
```

| Input | When present | When absent |
|-------|----------------|-------------|
| Prior shipped Task and merged PR | Apply as lineage | Resolve by the concept's prior-context order; ask once if still unknown |
| Prior definition spec | Apply as context | Continue from the reported problem |
| Delta description | Apply it | Ask once what is still wrong |

## Output

`ITERATE.md` — post-merge delta, pass criteria, and the new Task key. Outcome: `ready`, or `inspect-loop` when each turn needs inspection.

This skill does not name a successor. Apply the workflow transition before the turn ends. The iterate workflow continues into the fix; this skill stops at the spec.
