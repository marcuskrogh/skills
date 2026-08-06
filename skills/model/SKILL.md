---
name: model
description: >-
  Mathematical alignment with LaTeX-only questions. Produces MODEL.md for math
  foundations only — not product definition. Links to a pipeline Task when given
  and updates continuity markdown. Use for dynamical models, OCP, estimators, or
  applied math.
disable-model-invocation: true
---

# Model

Applies [CONCEPT_ALIGNMENT](../concepts/CONCEPT_ALIGNMENT.md) to **applied
mathematics**. Optional pipeline side path — usually after **research** /
**explore**, before or alongside **define**.

**On invoke:** read CONCEPT_ALIGNMENT, [format.md](format.md), [reference.md](reference.md),
[../workflow/reference.md](../workflow/reference.md), and
[../tracker/SKILL.md](../tracker/SKILL.md).

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

## Role in pipeline
Math alignment with the user. Does **not** settle product scope, UX, or acceptance
for `/define`.

## Tracker
- Task: <KEY>
- Research: RESEARCH.md (if any) — supportive literature only

## Next
`/<skill> <KEY>` — <why>
```

## Tracker (after approval)

1. Write `MODEL.md` (external location → external root + push into Task).
2. Pipeline Task: `attach_or_link` + comment + **Next**; no parallel Task; leave status.
3. Standalone: create Task (**To Do**), then same.
4. Committing → [delivery branch continuity](../workflow/reference.md#delivery-branch-continuity-closed-loop); never a model-only PR beside a separate define PR.
5. Update ROADMAP / PLAN Inputs / RESEARCH Tracker when present; upsert ISSUES. Do not close the Task.

## Handoff

| Context | Next |
|---------|------|
| Behaviour / UX / scope still open | `/define <KEY>` |
| Plan already complete | `/implement <KEY>` |
| Need literature first | `/research <KEY>` |
