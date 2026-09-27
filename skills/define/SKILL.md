---
name: define
description: >-
  Definition front door for concrete work. Interviews the user
  (CONCEPT_ALIGNMENT) before classification and workflow binding. A short
  description starts the interview; it does not approve the plan. Produces
  PLAN.md (with Classification + Workflow), Sub-tasks, and the Task's
  delivery branch/PR. Prefer /explore when the destination is foggy; prefer
  explicit /bug /tweak /refine /rework only as manual overrides. Prefer
  /adopt when the whole existing tree should meet the structure catalog.
disable-model-invocation: true
---

# Define

Applies [CONCEPT_ALIGNMENT](../concepts/CONCEPT_ALIGNMENT.md),
[CONCEPT_DEFINITION](../concepts/CONCEPT_DEFINITION.md), and
[CONCEPT_CLASSIFICATION](../concepts/CONCEPT_CLASSIFICATION.md) to a **specific
topic**. Produces `PLAN.md` (including **Classification** + **Workflow**
binding) and Sub-tasks on the **pipeline Task**.

Applies [CONCEPT_SKILL](../concepts/CONCEPT_SKILL.md).

**On invoke:** read those concepts,
[CONCEPT_SKILL](../concepts/CONCEPT_SKILL.md),
[../concepts/CLASSIFICATION-CATALOG.md](../concepts/CLASSIFICATION-CATALOG.md),
and [../workflow/SKILL.md](../workflow/SKILL.md).

## Extensions

| Slot | This skill |
|------|------------|
| **Subject** | Concrete work: defect, small delta, brownfield whole-tree structure, bounded structure-only, measured impl swap, or feature slice (explore route Task when present) |
| **Probes** | Thin description; scope in/out; behaviour divergences (or preserve-behaviour / parity bar as class requires); constraints; **pass criteria** (checkable success rows, distinct from the specification); work packages; fog pointers on this route Task; Task key; how to apply RESEARCH/MODEL/SANDBOX — same definition probe set as classic define, proportional depth |
| **Stop condition** | Scope, behaviour (or parity/preserve-behaviour), constraints, and pass criteria are stated by the user or explicitly deferred; the user approved the readiness prompt; then class + workflow binding are persisted |
| **Alignment / definition artifact** | `PLAN.md` (path from WORKSPACE) — always; class lives in Classification, not a separate BUG/TWEAK file |
| **Readiness prompt** | "Does this plan and workflow binding look right?" |
| **Opening** | Thin description **required**. Missing → "What should we define?" Any unstated probe → one question on that probe. Every in-play probe already stated in the user's words → artifact + readiness prompt, then stop |
| **Scope guard** | Stay on this Task; no foggy destination mapping (`/explore`); write approved `PLAN.md` on the delivery branch; **do not skip alignment** to rush classify/bind |
| **Depth** | Proportional per CONCEPT_DEFINITION. A provisional class selects full vs lightweight only. Lightweight still runs CONCEPT_ALIGNMENT on unsettled probes. Full when the provisional class is feature, the class is ambiguous, or a definition probe is unstated |
| **Work packages** | Sub-tasks per package when more than one unit; single package OK for small classes |
| **Class catalog** | [CLASSIFICATION-CATALOG.md](../concepts/CLASSIFICATION-CATALOG.md) |
| **Template catalog** | same |
| **Binding rules** | same |
| **Artifact sections** | `## Classification` + `## Workflow` required (in addition to full plan body) |
| **Tracker mirror** | Copy class, template, params, and chain onto the Task (and Story when linked). The workflow appends **Next** |

## Steps

1. **Resolve entry** — Require a thin description or ask once; fetch route Task + Story when present; load ROADMAP / RESEARCH / MODEL / SANDBOX as supportive. Form a provisional class only to choose full vs lightweight. Done when the subject and which probes are still unstated are known.
2. **Align and define** — Follow CONCEPT_ALIGNMENT + CONCEPT_DEFINITION until every in-play probe is user-settled. Done when scope, behaviour/parity/preserve-behaviour, constraints, and pass criteria are stated by the user or explicitly deferred, and the turn has waited for those answers.
3. **Classify, bind, and confirm** — Apply CONCEPT_CLASSIFICATION + the catalog on that agreed description: final **class**, **template** + **parameters** (efficiency-first), confirm only on costly ambiguity. Present `PLAN.md` (Classification + Workflow included) and the readiness prompt. Done when the user approves the prompt — without reopening settled definition decisions unless the binding exposes a new divergence.
4. **Persist and track** — Write `PLAN.md` only after that approval. Follow delivery continuity, apply the define tracker row, and mirror binding fields on the tracker. Record outcome `ready`. Apply the workflow transition. Done when artifact, Sub-tasks, branch/PR, comments, and mirrors agree.

## Artifact

```markdown
# Implementation plan: [title]

## Summary
- …

## Scope / Decisions / Constraints
- … (user-aligned in this define session — deep alignment when Depth is full)

## Classification
- Class: bug | tweak | adopt | refine | rework | feature | iterate
- Confidence: high | medium
- Why: …

## Workflow
- Template: fix-fast | delta-fast | structure-safe | parity-iterative | feature-standard | feature-heavy
- Parameters:
  - implement.mode: single | multiagent
  - implement.verify: tests | non-regression | comparative
  - implement.iteration: one-shot | until-bar
  - test.mode: skip | dedicated
  - harden.mode: skip | dedicated
  - review.mode: single | multiagent
  - review.depth: focused | full
  - review.lasers: bundled | sequential
  - side_paths: none | research | model | research+model
  - sandbox: none | inject
- Chain: architect → implement → test → restructure → review → ship   # adopt: characterize → architect → implement → test → restructure → review → ship
- Rationale: …

## Inputs
- Research: RESEARCH.md (if any)
- Model: MODEL.md (if any)
- Sandbox: SANDBOX.md (if any)

## Pass criteria
- …   # one observable per row; fail if unmet. Distinct from Scope. Docs-only: none — no executable behaviour. Parity bar metrics when Class is rework.

## Work packages
1. …

## Open items
- …

## Tracker
- Provider: …
- Story: <KEY> (if linked)
- Task: <KEY>
- Sub-tasks: …
- Branch: <delivery-branch>
- PR: <url or draft url>
- Classification: <class>
- Workflow: <template>
```

## Tracker (after approval)

Follow [delivery continuity](../workflow/delivery.md) and the
[define tracker row](../workflow/tracker-sync.md#matrix). Enrich the explore
route Task when present; otherwise create the pipeline Task. Keep it **To Do**,
create Sub-tasks per work package, and record `PLAN.md`, **Classification**,
**Workflow** (template + params + chain), branch/PR, and Sub-task keys on the
Task, parent Story, and enabled mirror. The workflow appends **Next**.

## Inputs

| Input | When present | When absent |
|-------|----------------|-------------|
| Thin description | Apply it as the subject | Ask "What should we define?" once |
| `ROADMAP.md` | Apply destination and fog as context | Continue without a map |
| `RESEARCH.md` | Apply as evidence, not as decisions | Continue without literature |
| `MODEL.md` | Apply as the formulation | Continue without a math spec |
| `SANDBOX.md` | Apply the element, bar, and promote map as context | Continue without a sandbox |

## Output

`PLAN.md` — definition spec, classification, and workflow binding. Outcome: `ready`.

This skill does not name a successor. Apply the workflow transition before the turn ends. Class **adopt** uses the adopt workflow.
