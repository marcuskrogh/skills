---
name: explain
description: >-
  Explanation of the current workflow step, coding choices, interfaces,
  numerical considerations, or recent agent output, in simple terms. Long
  explanations are paced: one beat per turn, wait for advance. Prefer /help
  for which skill to run; prefer /guide for a step-by-step task walkthrough.
disable-model-invocation: true
---

# Explain

Applies [CONCEPT_EXPLANATION](../concepts/CONCEPT_EXPLANATION.md) to the **current
subject**.

**On invoke:** read CONCEPT_EXPLANATION and
[../workflow/handoff.md](../workflow/handoff.md) (entry context + Next). Load
in-flight Task artifacts when the subject is the current workflow step.

## Extensions

| Slot | This skill |
|------|------------|
| **Subject** | Current workflow step, named decision, interface, numerical point, or recent agent output |
| **Stop condition** | No remaining beats, or the user ends the explanation |
| **Opening** | Thin: "What should I explain?" Rich / in-flight / last output: form beats; present the first (or the whole explanation when it fits one beat) |
| **Sources** | User text; in-flight PLAN/BUG/TWEAK/REFINE/REWORK/ROADMAP and persisted Next; last agent output; named code or docs |
| **Scope guard** | No PLAN/BUG/branch/PR; which-skill map is `/help`; walkthrough is `/guide` |

## Steps

1. **Resolve subject** — User wording, current workflow step, last agent output, or one opener. Load **Sources** when they bear on the subject. Done when the subject is known.
2. **Teach** — Follow CONCEPT_EXPLANATION until the stop condition. Done when remaining beats are exhausted or the user ends it.
3. **Hand off** — Resume persisted **Next** of an in-flight Task when one exists; otherwise none. Done when the user has the Next cue.

## Tracker / Handoff

No tracker create, status, or close. Chat **Next** only:

```markdown
## Next
`/<prior-skill> <KEY>` — Resume the in-flight Task
```

When no in-flight Task: `None — explanation complete.`
