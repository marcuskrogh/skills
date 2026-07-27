---
name: model
description: >-
  Mathematical alignment with LaTeX-only questions. Produces MODEL.md for math
  foundations only — not product definition. Links to a pipeline Task when given
  and updates continuity markdown. Use for dynamical models, OCP, estimators, or
  applied math.
---

# Model

Applies [CONCEPT_ALIGNMENT](../concepts/CONCEPT_ALIGNMENT.md) to **applied
mathematical** topics. Optional side path on the main pipeline — usually after
**research** or **explore**, before or alongside **define**, and before **implement**.

**On invoke:** read [../concepts/CONCEPT_ALIGNMENT.md](../concepts/CONCEPT_ALIGNMENT.md),
[format.md](format.md), [reference.md](reference.md),
[../workflow/reference.md](../workflow/reference.md), and
[../tracker/SKILL.md](../tracker/SKILL.md).

## Intent

Model is **user-agent alignment on mathematics only**. It settles the formulation,
assumptions, and numerical choices the user agrees to — not product scope, UX,
behaviour, or acceptance (those belong to **define**).

| Model does | Model does not |
|------------|----------------|
| Align math foundations with the user | Decide product / UX / acceptance for define |
| Use `RESEARCH.md` as literature orientation | Treat research conclusions as already-agreed math |
| Produce `MODEL.md` as a math constraint for later work | Replace `/define` questioning |

### Relation to research

`RESEARCH.md` is **supportive evidence** — what the literature says. Use it to
frame better math questions. Do **not** assume the brief chose the model class,
objective, constraints, or discretisation for the user. Always ask the user on
mathematical divergence points.

### Relation to define

`MODEL.md` constrains *how the math is stated*. Define still owns *what to build*
(scope, behaviour, acceptance, work packages) and must probe the user on those
particulars even when a model already exists.

## Extension contract

| Extension | This skill |
|-----------|------------|
| **Subject** | User-described mathematical object (model, OCP, estimator, etc.) |
| **Probes** | See [Probes](#probes) |
| **Stop condition** | Mathematical foundations are unambiguous **with the user** |
| **Alignment artifact** | `MODEL.md` (path from WORKSPACE) |
| **Readiness prompt** | LaTeX block: "Ready to finalise the model specification?" (see [format.md](format.md)) |
| **Format override** | LaTeX-only questions per [format.md](format.md) |
| **Scope guard** | No code unless mathematically essential; no product/UX definition |

### Probes

- Model class, state/input/output structure, constraints, objectives
- Numerical schemes, estimation/control choices, discretisation
- Pipeline Task key from **explore** / **define** (preferred)
- Related `RESEARCH.md` if present — as literature context only, not settled answers
- Target path for `MODEL.md` (default from WORKSPACE)

### Opening

| Context | First move |
|---------|------------|
| **Thin** | One LaTeX block: what mathematical object or problem class? |
| **Rich** / Task key | Load Task + `RESEARCH.md` / `ROADMAP.md` if present; first unresolved **math** divergence with the user — never skip because research already ran |

## Alignment artifact

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

Use the **definition hierarchy** from [format.md](format.md).

## Tracker and continuity (after approval)

1. Write `MODEL.md` at the agreed path; commit when appropriate (include issue key).
2. **Pipeline Task provided (preferred):** enrich *that* Task — `attach_or_link` `MODEL.md`, `comment` summary + **Next**. Do **not** create a parallel Task. Leave status unchanged (usually **To Do**).
3. **Standalone:** create a **Task** (**To Do**), link parent Story if any, then same attach/comment.
4. Update shared markdown:
   - `ROADMAP.md` phase notes / artifact column → `MODEL.md`
   - `PLAN.md` if it exists → Inputs / Constraints link to `MODEL.md`
   - `RESEARCH.md` Tracker section if it exists → link `MODEL.md`
   - Upsert `docs/agents/ISSUES.md` mirror
5. Report path, key, and **Next**. Do **not** close the Task.

## Handoff

| Context | Next |
|---------|------|
| Behaviour/UX / scope still open | `/define <KEY>` |
| Plan already complete | `/implement <KEY>` |
| Need literature first | `/research <KEY>` |

```markdown
## Next
`/define <KEY>` — Define product particulars with user; MODEL.md is math input only
```

## Anti-patterns

- Treating `RESEARCH.md` themes as the user's mathematical choices
- Skipping LaTeX alignment questions because a paper or brief "already decided"
- Writing product scope, UX, or acceptance into `MODEL.md`
- Handing off to define in a way that implies definition probes are optional

## Examples

User: `/model` MD-2 — MPC for the CSTR, research in RESEARCH.md.

Agent: [Single LaTeX block — ODE vs SDE vs spatial PDE?]

*(Research may mention common formulations; still ask the user which to adopt.)*
