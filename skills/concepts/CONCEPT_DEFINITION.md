# Concept: Definition

Produce a **concrete, implementable definition** of scoped work so later skills
can build, review, and ship without guesswork. Uninvokable — load only when a
skill's On-invoke pointer fires.

## Intent

Align on **divergences** that affect the **definition**, then persist an artifact
that answers: *what exactly, in/out, how we know done?* **Pass criteria** are
how we know done — checkable rows, distinct from the **specification**. Usually
reached through [CONCEPT_ALIGNMENT](CONCEPT_ALIGNMENT.md). Explore wayfinding,
literature research, math modelling, and coding are other skills' jobs.

## Leading words

- **specification** — scope, behaviour, constraints, and decisions: what to
  build. Not the pass-criteria list.
- **pass criteria** — checkable success rows on the definition artifact; each
  row is one observable that implement can **spec-lock**. Distinct from the
  specification.

## Invariants

- **Decisions over option lists** in the final artifact; open items only when the user accepts deferral.
- **Particulars with the user.** Explore route blurbs, `RESEARCH.md`, `MODEL.md`,
  and `SANDBOX.md` orient — they do not replace definition probes.
- **Artifact-only during definition.** Production code changes begin in implementation; writing the definition artifact on the delivery branch is allowed when the skill requires it.
- **Pass criteria.** Align them with the user. Each row is one observable
  success, written so a test can fail if it is unmet. They are not a restatement
  of the specification. Docs-only: `none — no executable behaviour`. A
  definition is not implementable until pass criteria are explicit (or that
  none). Legacy `## Acceptance criteria` rows count as pass criteria.
- **Proportional depth.** Full for non-trivial features; lightweight for clear defects, tweaks, refinements, and reworks; confirm gaps only when already implementation-ready.
- **Classify and bind when the skill requires it.** Skills that apply [CONCEPT_CLASSIFICATION](CONCEPT_CLASSIFICATION.md) persist class + workflow binding on the definition artifact so later stages stay deterministic. **Classification does not replace alignment** — bind only after definition divergences are resolved with the user (proportional depth still applies).

## Extensions

| Slot | Required | Purpose |
|------|----------|---------|
| **Subject** | must | Kind of thing being defined |
| **Probes** | must | Definition-oriented question areas (skill fills) |
| **Stop condition** | must | When the definition is implementable |
| **Definition artifact** | must | Format and filename (`PLAN.md`, `BUG.md`, `TWEAK.md`, `REFINE.md`, `REWORK.md`, `ADOPT.md`, …) |
| **Readiness prompt** | must | How to confirm with the user |
| **Opening** | may | Thin vs rich / key-driven entry |
| **Scope guard** | may | Exclusions during definition |
| **Depth** | may | Full vs lightweight |
| **Work packages** | may | Whether/how to break into Sub-tasks |

## Reference

### Qualities (completion bar)

| Quality | Meaning |
|---------|---------|
| **Subject** | What is being defined |
| **Scope** | Explicit in / out |
| **Behaviour** | Observable outcomes where implementations would diverge |
| **Constraints** | Non-negotiables |
| **Pass criteria** | How success is verified — checkable rows, not a restatement of the spec |
| **Work breakdown** | Ordered packages when more than one unit |
| **Open items** | Named unknowns — not silent assumptions |
