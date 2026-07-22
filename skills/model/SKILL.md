---
name: model
description: >-
  Mathematical alignment with LaTeX-only questions. Produces MODEL.md in the repository,
  a Jira Task with the spec attached and summarised, optionally linked to explore or
  design tickets. Use for dynamical models, OCP, estimators, or applied math specs.
---

# Model

Applies [alignment](../alignment/SKILL.md) to **applied mathematical** topics. Produces `MODEL.md` in the repo and a Jira Task.

**On invoke:** read [../alignment/SKILL.md](../alignment/SKILL.md), [format.md](format.md), [reference.md](reference.md), and [../tracker/SKILL.md](../tracker/SKILL.md).

## Extension contract

| Extension | This skill |
|-----------|------------|
| **Subject** | User-described mathematical object (model, OCP, estimator, etc.) |
| **Probes** | See [Probes](#probes) |
| **Stop condition** | Mathematical foundations are unambiguous |
| **Alignment artifact** | `MODEL.md` in the repository |
| **Readiness prompt** | LaTeX block: "Ready to finalise the model specification?" (see [format.md](format.md)) |
| **Format override** | LaTeX-only questions per [format.md](format.md) |
| **Scope guard** | No code unless mathematically essential to clarify the model |

### Probes

- Model class, state/input/output structure, constraints, objectives
- Numerical schemes, estimation/control choices, discretisation
- Parent issue key from **explore** or **design** (optional)
- Confirm tracker from WORKSPACE
- Target repo path for `MODEL.md` (default from WORKSPACE / project convention)

### Opening

| Context | First move |
|---------|------------|
| **Thin** | One LaTeX block: what mathematical object or problem class? |
| **Rich** | One LaTeX block on the first unresolved divergence |

## Alignment artifact

Write `MODEL.md`:

```markdown
# Model: [title]

## Problem statement / Notation / Formulation
…

## Assumptions / Algorithmic choices / Numerical considerations
…

## Open items
…

## Jira
- Task: PROJ-300
```

Use the **definition hierarchy** from [format.md](format.md).

## Jira and repository (after approval)

1. Write `MODEL.md` to the repository at the agreed path.
2. **Commit** `MODEL.md` on the current branch (or a dedicated docs branch if the user specifies). Include Jira key in commit message when the ticket exists.
3. Per tracker backend: create a **Task**, link parent if any, `attach_or_link` `MODEL.md`, comment with path + SHA.
4. Update `MODEL.md` tracker section with key/URL; upsert markdown mirror if enabled.
5. Commit tracker section update if needed.
6. Report key/URL and file path. Session ends.

`MODEL.md` in the repo is the versioned source of truth; the tracker holds the work item for later **implement**.

## Examples

User: `/model` an MPC for our CSTR, parent SW-40.

Agent: [Single LaTeX block — ODE vs SDE vs spatial PDE?]
