---
name: design
description: >-
  Alignment on a component, system, or codebase area for the main pipeline.
  Enriches an explore Task (or creates a Task) with PLAN.md and Sub-tasks for
  implement. Use when agreeing on requirements and design before coding.
---

# Design

Applies [alignment](../alignment/SKILL.md) to a **specific topic**. Produces `PLAN.md` and Sub-tasks on the **pipeline Task** that **implement** will use.

**On invoke:** read [../alignment/SKILL.md](../alignment/SKILL.md), [../workflow/reference.md](../workflow/reference.md), and [../jira/reference.md](../jira/reference.md).

## Extension contract

| Extension | This skill |
|-----------|------------|
| **Subject** | User-described component, system, object, feature, or codebase area — often an explore Task |
| **Probes** | See [Probes](#probes) |
| **Stop condition** | No obvious divergence points remain for scope, behavior, constraints, and acceptance |
| **Alignment artifact** | `PLAN.md` |
| **Readiness prompt** | "Does this plan look complete?" |

### Probes

- Scope boundaries (in / out)
- UX and behavior where multiple valid implementations exist
- Data sources, ownership, and edge cases
- Compatibility with existing code or conventions
- Non-obvious constraints the user cares about
- Acceptance criteria and verification approach
- Pipeline Task key from a prior **explore** session (preferred)
- Jira project key (if not in `JIRA_PROJECT_KEY`)

### Opening

| Context | First move |
|---------|------------|
| **Thin** | "What do you want to design?" (or resolve Task key if only `/design`) |
| **Rich** / Task key given | Load Task (+ Story, `ROADMAP.md`); first question on an unresolved divergence |

### Scope guard

- No code, file edits, or implementation during alignment
- No sub-agent delegation — alignment only

## Entry (pipeline)

When the user passes an explore **Task** key or URL:

1. Fetch the Task and parent Story per [../jira/reference.md](../jira/reference.md).
2. Load `ROADMAP.md` if present for phase context.
3. Treat the Task summary/description as the starting subject — do not re-ask "what are we designing?" unless the Task is empty.

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

## Jira
- Story: PROJ-123 (if linked)
- Task: PROJ-124
- Sub-tasks: PROJ-201, …

## Next
`/implement PROJ-124` — Build per this plan
```

## Jira (after approval)

Follow [../workflow/reference.md](../workflow/reference.md) **one ticket continuity**.

### When an explore Task was provided (preferred)

1. Confirm credentials per [../jira/reference.md](../jira/reference.md).
2. **Update that Task** — do **not** create a parallel design ticket:
   - Description: plan summary, acceptance criteria, path to `PLAN.md`
   - Attach or link `PLAN.md` when useful
3. For each **work package**, create a **Sub-task** under the Task.
4. Write `PLAN.md` to the repo (include Jira keys + **Next**).
5. Comment on the Task and parent Story with plan path, sub-task keys, and **Next**.
6. Report Task URL, sub-task list, and **Next**. Session ends.

### Standalone (no explore Task)

1. Create a **Task** (or **Story** if the project uses stories for features).
2. Create **Sub-tasks** per work package.
3. Write `PLAN.md`; comment with keys and **Next** `/implement <KEY>`.

## Handoff

```markdown
## Next
`/implement <TASK-KEY>` — Build per PLAN.md
```

## Examples

User: `/design` SW-124 — price forecast chart from explore.

Agent: [Loads SW-124 + ROADMAP] Should the forecast replace the existing chart or appear alongside it?
