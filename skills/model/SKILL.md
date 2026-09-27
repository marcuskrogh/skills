---
name: model
description: >-
  Mathematical alignment through LaTeX-only questions. Produces MODEL.md finding
  docs on the delivery branch (no separate PR). Use for dynamical models, OCP,
  estimators, or applied math.
disable-model-invocation: true
---

# Model

Applies [CONCEPT_ALIGNMENT](../concepts/CONCEPT_ALIGNMENT.md) and
[CONCEPT_SKILL](../concepts/CONCEPT_SKILL.md) to **applied mathematics**.
Produces **finding docs** on the delivery branch.

**On invoke:** read [CONCEPT_ALIGNMENT](../concepts/CONCEPT_ALIGNMENT.md),
[CONCEPT_SKILL](../concepts/CONCEPT_SKILL.md),
[format.md](format.md), [reference.md](reference.md), and
[../workflow/SKILL.md](../workflow/SKILL.md). When a claim needs sources and
`RESEARCH.md` is absent, also read [CONCEPT_RESEARCH](../concepts/CONCEPT_RESEARCH.md).

Settles formulation, assumptions, and numerical choices **with the user** — not
product scope, UX, behaviour, or acceptance (`/define`). `RESEARCH.md` orients
questions; it does not choose the model for the user.

## Extensions

| Slot | This skill |
|------|------------|
| **Subject** | Mathematical object (model, OCP, estimator, …) |
| **Probes** | Model class; state/input/output; constraints/objectives; numerical schemes / estimation / discretisation; Task key; `RESEARCH.md` as literature only; `MODEL.md` path |
| **Stop condition** | Mathematical foundations unambiguous **with the user** |
| **Alignment artifact** | `MODEL.md` (path from WORKSPACE) |
| **Readiness prompt** | LaTeX block: "Ready to finalise the model specification?" ([format.md](format.md)) |
| **Format override** | LaTeX-only questions per [format.md](format.md) |
| **Opening** | Thin: one LaTeX block — what mathematical object/problem class? Rich / Task key: load Task + RESEARCH/ROADMAP; first unresolved **math** divergence |
| **Scope guard** | No code unless mathematically essential; no product/UX definition |

## Steps

1. **Resolve context** — Load the Task, Story, ROADMAP, and RESEARCH when present, then identify the first unresolved mathematical divergence. Done when the subject and supportive inputs are known.
2. **Align** — Follow the CONCEPT_ALIGNMENT flow using the extensions and LaTeX format above. Done when the mathematical stop condition holds and the user approves `MODEL.md`.
3. **Persist** — Write `MODEL.md` onto the delivery branch (no PR); when linked, apply the model tracker row. Record outcome `ready`. Apply the workflow transition. Done when the artifact is on the delivery head with Task and mirrors agreed.

## Artifact

Use the definition hierarchy from [format.md](format.md):

```markdown
# Model: [title]

## Problem statement / Notation / Formulation
…

## Assumptions / Algorithmic choices / Numerical considerations
…

## Open items
…

## Role
Math alignment input — not product scope or UX.

## Tracker
- Task: <KEY>
- Research: RESEARCH.md (if any) — supportive literature only
- Branch: <delivery-branch>
- PR: — (model never opens a PR)
```

## Tracker (after approval)

Follow [finding-docs continuity](../workflow/delivery.md#rules) and the
[model tracker row](../workflow/tracker-sync.md#matrix). Commit `MODEL.md` onto
the **delivery** Task’s branch (create the branch if needed; reuse the
downstream delivery head when this is a supportive-only route Task). **Never
open a PR.** Leave delivery-Task status **To Do** unless further along; mark a
supportive-only route Task **Done** at handoff. Record `MODEL.md` and branch; update ROADMAP / PLAN Inputs / RESEARCH Tracker
and the enabled mirror. External artifacts are pushed into the Task.

## Inputs

| Input | When present | When absent |
|-------|----------------|-------------|
| Mathematical object to settle | Apply it | Ask, in LaTeX, what object or problem class |
| `RESEARCH.md` | Apply as literature only. It does not choose the model | When a claim needs sources, apply CONCEPT_RESEARCH in this invocation, write `RESEARCH.md`, then continue |

## Output

`MODEL.md` — formulation, assumptions, and numerical choices agreed with the user. Outcome: `ready`.

This skill does not name a successor. Apply the workflow transition before the turn ends.
