---
name: guide
description: >-
  Guidance through a manual task one step at a time: installation, setup,
  hardware, or coding the user wants walked. Present one step; wait for
  advance (yes, okay, move on) or a block that reevaluates the sequence.
  Prefer /define when the agent should deliver the work; prefer /explain when
  they want teaching without a walkthrough.
disable-model-invocation: true
---

# Guide

Applies [CONCEPT_GUIDANCE](../concepts/CONCEPT_GUIDANCE.md) to a **named task**.

**On invoke:** read CONCEPT_GUIDANCE and
[../workflow/handoff.md](../workflow/handoff.md) (entry context + Next).

## Extensions

| Slot | This skill |
|------|------------|
| **Subject** | The task the user wants walked (coding they perform, setup, installation, hardware, or other manual work) |
| **Stop condition** | Last step advanced, or the user ends the walkthrough |
| **Opening** | Thin: "What should I guide you through?" Rich / task named: form the sequence; one environment question only when the first fork depends on it; else step 1 |
| **Actor default** | User acts on their machine; agent acts in this environment after advance when the step belongs here |
| **Scope guard** | No PLAN/BUG/branch/PR; no `/setup` workspace file; which-skill map is `/help`; teaching without a walkthrough is `/explain` |

## Steps

1. **Resolve subject** — Named task, in-flight work they asked to be walked, or one opener. Done when the subject is known.
2. **Walk** — Follow CONCEPT_GUIDANCE until the stop condition. Done when the sequence is complete or the user ends it.
3. **Hand off** — Resume persisted **Next** of an in-flight Task when one exists; otherwise none. Done when the user has the Next cue.

## Tracker / Handoff

No tracker create, status, or close. Chat **Next** only:

```markdown
## Next
`/<prior-skill> <KEY>` — Resume the in-flight Task
```

When no in-flight Task: `None — walkthrough complete.`
