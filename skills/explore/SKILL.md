---
name: explore
description: >-
  High-level alignment on a project or feature idea. Produces a roadmap and
  tracker Story/Tasks for later design on the main pipeline. Persists keys and
  Next in markdown. Use when exploring scope or prioritising work at project scale.
---

# Explore

Applies [alignment](../alignment/SKILL.md) at **project or feature scale**. Produces `ROADMAP.md` and tracker issues that feed **design**.

**On invoke:** read [../alignment/SKILL.md](../alignment/SKILL.md), [../workflow/reference.md](../workflow/reference.md), and [../tracker/SKILL.md](../tracker/SKILL.md) (loads `WORKSPACE.md` + provider backend).

## Extension contract

| Extension | This skill |
|-----------|------------|
| **Subject** | A project, product area, or feature idea at high level |
| **Probes** | See [Probes](#probes) |
| **Stop condition** | Goals, scope boundaries, major components, priorities, and open questions are clear |
| **Alignment artifact** | `ROADMAP.md` (path from WORKSPACE) |
| **Readiness prompt** | "Does this roadmap capture what you want to tackle next?" |

### Probes

- Goals and success criteria (outcomes, not implementation)
- Scope boundaries — what is in vs out for this exploration
- Major components, systems, or workstreams involved
- Dependencies, risks, and unknowns
- Priority order and sequencing rationale
- Confirm tracker from WORKSPACE (do not re-litigate unless missing)

### Opening

| Context | First move |
|---------|------------|
| **Thin** | "What project or feature idea do you want to explore?" |
| **Rich** | First question on the highest-impact unresolved divergence (scope, priority, or goal) |

### Scope guard

- No detailed component or system design
- No mathematical modelling
- No code or implementation

## Alignment artifact

```markdown
# Roadmap: [title]

## Goals
- …

## Scope
### In / Out
- …

## Suggested phases
| Phase | Topic | Notes | Issue |
|-------|-------|-------|-------|
| 1 | … | … | <KEY> |

## Open questions
- …

## Tracker
- Provider: markdown | jira | github | linear
- Story: <KEY>
- Tasks: <KEY>, …

## Next
`/design <KEY>` — Design the first-priority phase
```

## Tracker (after approval)

1. Resolve provider ops via [../tracker/reference.md](../tracker/reference.md).
2. Create a **Story** (Goals + Scope).
3. For each phase, create a **Task** linked to the Story — pipeline owner for design → ship.
4. Comment on the Story with child keys + **Next**.
5. Update `ROADMAP.md`; upsert markdown mirror if enabled.
6. Report Story/Task keys, URLs (if remote), and **Next**. Session ends.

### Handoff

```markdown
## Next
`/design <TASK-KEY>` — Design phase: <topic>
```

## Examples

User: `/explore` — I want to add forecasting to our energy platform.

Agent: Is forecasting for internal operations, customer-facing products, or both?
