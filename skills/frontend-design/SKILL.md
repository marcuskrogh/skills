---
name: frontend-design
description: >-
  Retro-futuristic frontend design for product surfaces. Applies
  CONCEPT_FRONTEND: subject, tokens, one signature, craft floor. Default
  direction is retro-futuristic unless the brief names another look. Use when
  designing or reshaping user-facing web UI, or when implement packages touch
  product surfaces.
disable-model-invocation: true
---

# Frontend design

Applies [CONCEPT_FRONTEND](../concepts/CONCEPT_FRONTEND.md) to a **product
surface**. Outcome: a stated **direction** and working UI that matches it.

**On invoke:** read [CONCEPT_FRONTEND](../concepts/CONCEPT_FRONTEND.md),
[FRONTEND-RETRO.md](../concepts/FRONTEND-RETRO.md),
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
| **Direction** | **Retro-futuristic** unless the brief names another look |
| **Opening** | State **subject**, audience, job, era, then the token plan; then build |
| **Readiness prompt** | "Does this retro-futuristic direction match what you want, or should we change era / tokens / signature?" |

## Steps

1. **Ground and plan** — Follow CONCEPT_FRONTEND flow steps 1–3. Done when
   **subject**, era, **tokens**, and **signature** are stated and the plan is
   specific to this brief.
2. **Build** — Implement the artifact from those tokens. Apply
   [FRONTEND-CRAFT.md](../concepts/FRONTEND-CRAFT.md) and
   [FRONTEND-RETRO.md](../concepts/FRONTEND-RETRO.md). Keep CSS specificity
   even: one selector family per property. Done when the UI traces to the plan.
3. **Critique** — Flow step 5, then the readiness prompt. Done when the user
   accepts the **direction** or names the era/token/signature change.

## Calibration

Source-repo pages under `examples/frontend-design/`:

| File | Subject |
|------|---------|
| `index.html` | Quay instrument (Archivo, Rams shaver / Aromaster) |
| `heating-overview.html` | Heating Assistant dummy: off-white capsules, steel heads, orange switch |
| `heating-room.html` | Dummy living-room climate row with steel-rim analog meter |

Calibration only — not a product template.

## Handoff

```markdown
## Next
Revise era / **signature** from critique, or continue the bound pipeline (`/implement` when this UI is a package).
```
