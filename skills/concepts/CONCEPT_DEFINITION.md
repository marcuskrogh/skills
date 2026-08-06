# Concept: Definition

Produce a **concrete, implementable definition** of scoped work so later skills
can build, review, and ship without guesswork. Uninvokable — load only when a
skill's On-invoke pointer fires.

## Intent

Align on **divergences** that affect the **definition**, then persist an artifact
that answers: *what exactly, in/out, how we know done?* Usually reached through
[CONCEPT_ALIGNMENT](CONCEPT_ALIGNMENT.md). Explore wayfinding, literature
research, math modelling, and coding are other skills' jobs.

## Invariants

- **Decisions over option lists** in the final artifact; open items only when the user accepts deferral.
- **Particulars with the user.** Explore route blurbs, `RESEARCH.md`, and `MODEL.md` orient — they do not replace definition probes.
- **Artifact-only during definition.** Production code changes begin in implementation; writing the definition artifact on the delivery branch is allowed when the skill requires it.
- **Proportional depth.** Full for non-trivial features; lightweight for clear defects; confirm gaps only when already implementation-ready.

## Extensions

| Slot | Required | Purpose |
|------|----------|---------|
| **Subject** | must | Kind of thing being defined |
| **Probes** | must | Definition-oriented question areas (skill fills) |
| **Stop condition** | must | When the definition is implementable |
| **Definition artifact** | must | Format and filename (`PLAN.md`, `BUG.md`, …) |
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
| **Acceptance** | How success is verified |
| **Work breakdown** | Ordered packages when more than one unit |
| **Open items** | Named unknowns — not silent assumptions |
