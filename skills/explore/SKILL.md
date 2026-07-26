---
name: explore
description: >-
  High-abstraction idea exploration with the user. Clarifies direction and
  themes — not decisions — then produces a roadmap and tracker Story/Tasks for
  later define, research, or model. Persists keys and Next in markdown. Use when
  pitching or shaping a vague project/feature idea before particulars.
---

# Explore

Applies [CONCEPT_ALIGNMENT](../concepts/CONCEPT_ALIGNMENT.md) at **idea /
initiative scale**. Produces `ROADMAP.md` and tracker issues that feed **define**,
**research**, or **model**.

**On invoke:** read [../concepts/CONCEPT_ALIGNMENT.md](../concepts/CONCEPT_ALIGNMENT.md),
[../workflow/reference.md](../workflow/reference.md), and
[../tracker/SKILL.md](../tracker/SKILL.md) (loads `WORKSPACE.md` + provider backend).

## Intent

Explore is **joint idea-space exploration**. The user may pitch an extremely vague
idea; the agent helps surface themes, directions, and investigation areas — then
stops.

| Explore does | Explore does not |
|--------------|------------------|
| Clarify **direction** and ambition | Lock product / UX / tech decisions |
| Map the **idea space** into themes | Write success criteria, acceptance, or specs |
| Name **investigation** topics for later | Detail components, APIs, data models, or architecture |
| Leave particulars **open** on purpose | Pre-answer what **define** / **model** / **research** should ask |

Particulars belong to later skills. If a question would be useful in `/define`,
`/model`, or `/research`, **do not ask it here**.

## Extension contract

| Extension | This skill |
|-----------|------------|
| **Subject** | A vague or early project, product, or feature idea |
| **Probes** | See [Probes](#probes) |
| **Stop condition** | Direction is clear enough to list investigation themes (phases); particulars remain deliberately open |
| **Alignment artifact** | `ROADMAP.md` (path from WORKSPACE) |
| **Readiness prompt** | "Does this capture the direction and what we should investigate next?" |

### Probes

Stay at the **highest useful abstraction**. Prefer orientation over specification:

- What problem, opportunity, or itch is in play (one sentence level)
- Who or what this is roughly for (audience / context — not personas or UX)
- Ambition and horizon (toy, wedge, platform, research, …) — not milestones
- Competing directions or framings worth choosing among at theme level
- Themes or workstreams to investigate later (names + one-line why)
- Rough priority of those investigations (order only — not estimates or plans)
- What stays unknown on purpose (for define / research / model)

**Do not probe** during explore:

- Detailed in/out scope, edge cases, or acceptance criteria
- Component breakdown, system design, APIs, schemas, or stack choices
- UX flows, copy, metrics definitions, or success formulas
- Implementation sequencing inside a theme
- Anything that would leave `/define` with nothing meaningful to ask

### Opening

| Context | First move |
|---------|------------|
| **Thin** | "What idea do you want to explore?" |
| **Rich** | One question on the highest-leverage **directional** ambiguity (framing, ambition, or which theme matters) — never a particular |

### Scope guard

- No decisions that define/model/research should own
- No detailed component or system definition
- No mathematical modelling
- No code or implementation
- No filling the roadmap with settled requirements — prefer open questions

### Divergence discipline

A divergence point **in explore** is only a choice that changes **which themes
exist** or **which direction** the initiative is heading. Choices that only change
how a theme would later be defined are **out of scope** — park them under Open
questions or on the relevant Task for define/research/model.

When tempted to ask a specific question, rewrite it one level up, or skip it.

## Alignment artifact

```markdown
# Roadmap: [title]

## Direction
- … (1–3 sentences: the idea and where it is aimed — not a spec)

## Themes to investigate
| Phase | Theme | Why it matters | Deferred to | Issue |
|-------|-------|----------------|--------------|-------|
| 1 | … | … | define / research / model | <KEY> |

## Open questions
- … (particulars intentionally unresolved)

## Explicitly deferred
- define — scope, behaviour, acceptance, work packages
- research / model — as needed per theme

## Tracker
- Provider: markdown | jira | github | linear
- Story: <KEY>
- Tasks: <KEY>, …

## Next
`/define <KEY>` — Define the first-priority theme
(or `/research <KEY>` / `/model <KEY>` when the theme needs that first)
```

Keep **Direction** short. Theme rows are investigation labels, not mini-plans.
**Open questions** should be non-empty whenever particulars were skipped on purpose.

## Tracker (after approval)

1. Resolve provider ops via [../tracker/reference.md](../tracker/reference.md).
2. Create a **Story** (Direction + themes summary) — status **To Do**.
3. For each theme, create a **Task** linked to the Story — status **To Do**.
   Task summary/description = theme to investigate, open questions for that theme,
   and a note that particulars are for define/research/model — **not** a pre-baked plan.
4. `comment` on the Story with child keys + **Next**; upsert ISSUES mirror (Story + all Tasks).
5. Update `ROADMAP.md`; report keys/URLs and **Next**. Session ends.

### Tracker duties

| Action | Required |
|--------|----------|
| Create Story + Tasks | yes |
| Link Tasks → Story | yes |
| Status | **To Do** for all new issues |
| Comment + **Next** on Story | yes |
| ISSUES mirror upsert | yes when enabled |
| Close anything | no |

### Handoff

```markdown
## Next
`/define <TASK-KEY>` — Define theme: <topic>
```

Prefer `/research` or `/model` as **Next** when the first theme is clearly
literature- or math-blocked before definition.

## Examples

User: `/explore` — I want to add forecasting to our energy platform.

Agent: Are you exploring forecasting as an internal operations aid, a customer-facing
capability, or still deciding which of those worlds this idea lives in?

*(Not: which models, which data sources, which UI, or acceptance criteria.)*
