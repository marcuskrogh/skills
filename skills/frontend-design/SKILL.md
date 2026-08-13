---
name: frontend-design
description: >-
  Frontend design for product surfaces. Applies CONCEPT_FRONTEND: subject,
  tokens, one signature, and a craft floor. Use when designing or reshaping
  user-facing web UI, or when implement packages touch product surfaces.
disable-model-invocation: true
---

# Frontend design

Applies [CONCEPT_FRONTEND](../concepts/CONCEPT_FRONTEND.md) to a **product
surface**. Outcome: a stated **direction** and working UI that matches it.

**On invoke:** read [CONCEPT_FRONTEND](../concepts/CONCEPT_FRONTEND.md),
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
| **Direction** | From the brief when named; otherwise derived from the **subject** |
| **Opening** | State **subject**, audience, job, then the token plan; then build |
| **Readiness prompt** | "Does this direction match what you want, or should we change tokens / signature?" |

## Steps

1. **Ground and plan** — Follow CONCEPT_FRONTEND flow steps 1–3. Done when
   **subject**, **tokens**, and **signature** are stated and the plan is specific
   to this brief.
2. **Build** — Implement the artifact from those tokens. Apply
   [FRONTEND-CRAFT.md](../concepts/FRONTEND-CRAFT.md). Keep CSS specificity
   even: one selector family per property. Done when the UI traces to the plan.
3. **Critique** — Flow step 5, then the readiness prompt. Done when the user
   accepts the **direction** or names the token/signature change.

## Calibration

Source-repo pages under `examples/frontend-design/` (same brief, three stances).
Open to critique **direction**. Calibration only — not a product template.

| File | Stance |
|------|--------|
| `quiet.html` | **Craft as the look** — system type, even space, no signature spectacle |
| `instrument.html` | **Subject vernacular** — chart-table density, tide strip as **signature** |
| `editorial.html` | **Type as signature** — the reading (tide height) is the display |

## Handoff

```markdown
## Next
Revise **direction** from critique, or continue the bound pipeline (`/implement` when this UI is a package).
```
