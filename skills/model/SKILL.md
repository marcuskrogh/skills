---
name: model
description: >-
  Mathematical alignment through LaTeX-only questions. Produces MODEL.md for
  math foundations and links it to a pipeline Task when present. Use for
  dynamical models, OCP, estimators, or applied math.
disable-model-invocation: true
---

# Model

Applies [CONCEPT_ALIGNMENT](../concepts/CONCEPT_ALIGNMENT.md) to **applied
mathematics**. Optional pipeline side path — usually after **research** /
**explore**, before or alongside **define**.

**On invoke:** read [CONCEPT_ALIGNMENT](../concepts/CONCEPT_ALIGNMENT.md),
[format.md](format.md), [reference.md](reference.md), and
[../workflow/reference.md](../workflow/reference.md),
[../workflow/delivery.md](../workflow/delivery.md),
[../workflow/tracker-sync.md](../workflow/tracker-sync.md),
[../workflow/handoff.md](../workflow/handoff.md), and
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

## Steps

1. **Resolve context** — Load the Task, Story, ROADMAP, and RESEARCH when present, then identify the first unresolved mathematical divergence. Done when the subject and supportive inputs are known.
2. **Align** — Follow the CONCEPT_ALIGNMENT flow using the extensions and LaTeX format above. Done when the mathematical stop condition holds and the user approves `MODEL.md`.
3. **Persist and continue** — Write the artifact; when linked, apply delivery continuity and the model tracker row; persist the Handoff. Done when the artifact, Task, branch/PR, mirrors, and **Next** agree where applicable.

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
Math alignment input for `/define`.

## Tracker
- Task: <KEY>
- Research: RESEARCH.md (if any) — supportive literature only

## Next
`/<skill> <KEY>` — <why>
```

## Tracker (after approval)

Follow [delivery continuity](../workflow/delivery.md) when committing and the
[model tracker row](../workflow/tracker-sync.md#matrix). Enrich the pipeline
Task when present; otherwise create one **To Do**. Record `MODEL.md`, branch/PR,
and **Next**; update ROADMAP / PLAN Inputs / RESEARCH Tracker and the enabled
mirror. External artifacts are pushed into the Task.

## Handoff

| Context | Next |
|---------|------|
| Behaviour / UX / scope still open | `/define <KEY>` |
| Plan already complete | `/implement <KEY>` |
| Need literature first | `/research <KEY>` |
