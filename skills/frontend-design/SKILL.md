---
name: frontend-design
description: >-
  Warm frontend design for product surfaces. Applies CONCEPT_FRONTEND:
  subject, tokens, one signature, craft floor. Default direction is warm
  (simple, uncrowded, cream and terracotta, rounded) unless the brief names
  another look. Use when designing or reshaping user-facing web UI, or when
  implement packages touch product surfaces.
---

# Frontend design

Applies [CONCEPT_FRONTEND](../concepts/CONCEPT_FRONTEND.md) to a **product
surface**. Outcome: a stated **direction** and working UI that matches it.

**On invoke:** read [CONCEPT_FRONTEND](../concepts/CONCEPT_FRONTEND.md),
[FRONTEND-WARM.md](../concepts/FRONTEND-WARM.md),
[FRONTEND-ELEMENTS.md](../concepts/FRONTEND-ELEMENTS.md),
[FRONTEND-CRAFT.md](../concepts/FRONTEND-CRAFT.md), and
[CONCEPT_IMPLEMENTATION](../concepts/CONCEPT_IMPLEMENTATION.md) (product
surfaces). User-facing replies follow
[CONCEPT_LANGUAGE](../concepts/CONCEPT_LANGUAGE.md).

## Extensions

| Slot | This skill |
|------|------------|
| **Subject** | The page or product UI in the current brief |
| **Artifact** | The UI files the brief names (app routes, HTML, components) |
| **Stop condition** | Token plan matches the build; **signature** is one; **craft** checklist holds |
| **Direction** | **Warm** unless the brief names another look |
| **Opening** | State **subject**, audience, job, then the token plan; then build |
| **Readiness prompt** | "Does this warm direction match what you want, or should we change tokens / signature?" |

## Steps

1. **Ground and plan** — Follow CONCEPT_FRONTEND flow steps 1–3. Done when
   **subject**, **tokens**, and **signature** are stated and the plan is
   specific to this brief.
2. **Build** — Implement the artifact from those tokens. Apply
   [FRONTEND-CRAFT.md](../concepts/FRONTEND-CRAFT.md),
   [FRONTEND-WARM.md](../concepts/FRONTEND-WARM.md), and
   [FRONTEND-ELEMENTS.md](../concepts/FRONTEND-ELEMENTS.md). Keep CSS
   specificity even: one selector family per property. Done when the UI traces
   to the plan.
3. **Critique** — Flow step 5, then the readiness prompt. Done when the user
   accepts the **direction** or names the token/signature change.

## Calibration

Source-repo pages under `examples/frontend-design/`:

| File | Subject |
|------|---------|
| `index.html` | Heating Assistant dummy overview: cream board, KPI row, room capsules |
| `heating-room.html` | Dummy living-room climate and a warm time-series plot |

Candidate for a production restyle: Heating Assistant
`heatingassistant/app/static/` (today `industrial.css` / `ha-industrial-panel`).
Calibration only — not a product template.

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
