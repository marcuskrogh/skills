---
name: frontend-design
description: >-
  Warm frontend design for product surfaces. Applies CONCEPT_FRONTEND.
  Style guide: FRONTEND-WARM and FRONTEND-ELEMENTS. The first view states
  one fact; the rest opens on a click. Atkinson Hyperlegible, paper and clay,
  rounded sheets, rose only on infeasible plot regions. Use when designing or reshaping user-facing web
  UI, or when implement packages touch product surfaces.
---

# Frontend design

Applies [CONCEPT_FRONTEND](../concepts/CONCEPT_FRONTEND.md) to a **product
surface**. Outcome: a stated **direction** and working UI that matches it.

**On invoke:** read [CONCEPT_FRONTEND](../concepts/CONCEPT_FRONTEND.md),
the style guide [FRONTEND-WARM.md](../concepts/FRONTEND-WARM.md) and
[FRONTEND-ELEMENTS.md](../concepts/FRONTEND-ELEMENTS.md),
[FRONTEND-CRAFT.md](../concepts/FRONTEND-CRAFT.md), and
[CONCEPT_IMPLEMENTATION](../concepts/CONCEPT_IMPLEMENTATION.md) (product
surfaces). User-facing replies follow
[CONCEPT_LANGUAGE](../concepts/CONCEPT_LANGUAGE.md).

Heating Assistant (`marcuskrogh/HeatingAssistant`,
`heatingassistant/app/static/`) is the example of jobs and pages. Read it.
Do not edit it.

## Extensions

| Slot | This skill |
|------|------------|
| **Subject** | The page or product UI in the current brief |
| **Artifact** | The UI files the brief names (app routes, HTML, components) |
| **Stop condition** | Token plan matches the build; **signature** is one; **craft** checklist holds; besides the shell, the first view is one fact |
| **Direction** | **Warm** unless the brief names another look |
| **Opening** | State **subject**, audience, job, then the token plan; then build |
| **Readiness prompt** | "Does this warm direction match what you want, or should we change tokens or the first screen?" |

## Steps

1. **Ground and plan** — Follow CONCEPT_FRONTEND flow steps 1–3. Done when
   **subject**, **tokens**, and **signature** are stated and the plan is
   specific to this brief.
2. **Build** — Implement the artifact from those tokens. Apply
   [FRONTEND-CRAFT.md](../concepts/FRONTEND-CRAFT.md) and the style guide
   ([FRONTEND-WARM.md](../concepts/FRONTEND-WARM.md),
   [FRONTEND-ELEMENTS.md](../concepts/FRONTEND-ELEMENTS.md)). Keep CSS
   specificity even: one selector family per property. Done when the UI traces
   to the plan. Done when, besides the shell, the first view is the one fact
   in [FRONTEND-WARM.md](../concepts/FRONTEND-WARM.md). A chart, a week, a
   form, or a second card of readings on that view is not done.
3. **Critique** — Flow step 5, then the readiness prompt. Done when the user
   accepts the **direction** or names the token or first-screen change.

## Calibration

The style guide is the source of the look. Pages under
`examples/frontend-design/` are an earlier restyle. Do not copy them.

## Inputs

| Input | When present | When absent |
|-------|----------------|-------------|
| Brief / implement package | Apply named files and jobs | Design the current product surface in-repo |
| Token plan already on the Task | Apply it | Write it in this invocation |

## Output

Working UI files plus a stated token plan. Outcome: `ready`.

This skill does not name a successor. The workflow transition
([../workflow/handoff.md](../workflow/handoff.md)) writes **Next** when a
workflow is bound.

## Tracker

Status duties only when this skill runs on a delivery Task. No successor skill.
