# Concept: Definition

Produce a **concrete, implementable definition** of scoped work so later skills
can build, review, and ship without guesswork. Uninvokable — load only when a
skill's On-invoke pointer fires.

Answers: *what exactly, in/out, how we know done?* Not roadmap wayfinding,
literature research, math modelling, or coding.

Usually reached **through** [CONCEPT_ALIGNMENT](CONCEPT_ALIGNMENT.md): align on
divergences that affect the definition, then persist the artifact.

## Leading words

- **definition** — unambiguous enough to implement: subject, scope, behaviour,
  constraints, acceptance, work breakdown, named open items

## Invariants

- **Decisions over option lists** in the final artifact; open items only when the user accepts deferral.
- **Particulars with the user.** Explore route blurbs, `RESEARCH.md`, and `MODEL.md` orient — they do not replace definition probes.
- **No production code** during definition (writing the definition artifact on the delivery branch is allowed when the skill requires it).

## Qualities (completion bar)

| Quality | Meaning |
|---------|---------|
| **Subject** | What is being defined |
| **Scope** | Explicit in / out |
| **Behaviour** | Observable outcomes where implementations would diverge |
| **Constraints** | Non-negotiables |
| **Acceptance** | How success is verified |
| **Work breakdown** | Ordered packages when more than one unit |
| **Open items** | Named unknowns — not silent assumptions |

## Extensions

| Slot | Required | Purpose |
|------|----------|---------|
| **Subject** | must | Kind of thing being defined |
| **Probes** | must | Definition-oriented question areas |
| **Stop condition** | must | When the definition is implementable |
| **Definition artifact** | must | Format and filename (`PLAN.md`, `BUG.md`, …) |
| **Readiness prompt** | must | How to confirm with the user |
| **Opening** | may | Thin vs rich / key-driven entry |
| **Scope guard** | may | Exclusions during definition |
| **Depth** | may | Full vs lightweight (features vs clear defects) |
| **Work packages** | may | Whether/how to break into Sub-tasks |

## Depth

| Situation | Depth |
|-----------|-------|
| Non-trivial feature / system change | Full: scope, decisions, acceptance, work packages |
| Clear defect with known repro | Lightweight: symptom, repro, expected/actual, acceptance |
| Already implementation-ready | Confirm gaps only — no ceremony re-definition |

## Default probes

Adapt to subject: scope in/out; UX/behaviour divergences; data ownership and
edges; compatibility; non-obvious constraints; acceptance/verification; prior
artifacts as orientation only.
