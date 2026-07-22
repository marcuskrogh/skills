---
name: design
description: >-
  Alignment on a component or system for the main pipeline. Enriches an explore
  Task (or creates a Task) with PLAN.md and Sub-tasks. Persists keys and Next in
  markdown. Use when agreeing on design before coding.
---

# Design

Applies [alignment](../alignment/SKILL.md) to a **specific topic**. Produces `PLAN.md` and Sub-tasks on the **pipeline Task**.

**On invoke:** read [../alignment/SKILL.md](../alignment/SKILL.md), [../workflow/reference.md](../workflow/reference.md), and [../tracker/SKILL.md](../tracker/SKILL.md).

## Extension contract

| Extension | This skill |
|-----------|------------|
| **Subject** | Component, system, feature, or explore Task |
| **Probes** | See [Probes](#probes) |
| **Stop condition** | No obvious divergence points remain for scope, behavior, constraints, and acceptance |
| **Alignment artifact** | `PLAN.md` (path from WORKSPACE) |
| **Readiness prompt** | "Does this plan look complete?" |

### Probes

- Scope boundaries (in / out)
- UX and behavior where multiple valid implementations exist
- Data sources, ownership, and edge cases
- Compatibility with existing code or conventions
- Non-obvious constraints the user cares about
- Acceptance criteria and verification approach
- Pipeline Task key from a prior **explore** session (preferred)

### Opening

| Context | First move |
|---------|------------|
| **Thin** | "What do you want to design?" (or resolve Task key) |
| **Rich** / Task key given | Load Task (+ Story, `ROADMAP.md`); first divergence question |

### Scope guard

- No code, file edits, or implementation during alignment
- No sub-agent delegation — alignment only

## Entry (pipeline)

When the user passes an explore **Task** key:

1. `fetch` the Task and parent Story via tracker.
2. Load `ROADMAP.md`, and `RESEARCH.md` / `MODEL.md` if present.
3. Use Task summary/description as the subject.

## Alignment artifact

```markdown
# Implementation plan: [title]

## Summary
- …

## Scope / Decisions / Constraints
- …

## Acceptance criteria
- …

## Work packages
1. …
2. …

## Open items
- …

## Tracker
- Provider: …
- Story: <KEY> (if linked)
- Task: <KEY>
- Sub-tasks: …

## Next
`/implement <KEY>` — Build per this plan
```

## Tracker (after approval)

Follow one-issue continuity in [../workflow/reference.md](../workflow/reference.md).

### Explore Task provided (preferred)

1. **Update that Task** — do not create a parallel design issue.
2. Create **Sub-tasks** per work package.
3. Write `PLAN.md`; `attach_or_link` path on the Task.
4. Comment Task + Story with plan path, sub-task keys, **Next**.
5. Upsert markdown mirror if enabled.

### Standalone

Create a new **Task** + Sub-tasks, then same artifact/mirror steps.

## Handoff

```markdown
## Next
`/implement <TASK-KEY>` — Build per PLAN.md
```
