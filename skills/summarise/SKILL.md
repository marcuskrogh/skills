---
name: summarise
description: >-
  Summarises a pipeline Task (or Story): what it is about, where it sits in the
  feature or bug workflow, which artifacts exist, and what to run next. Use when
  asking status, where am I, or what next. (Bare "next" advances one persisted
  step; bare "ship" finishes remaining work — see workflow continuation keywords.)
---

# Summarise

Read-only status skill for feature and bug pipelines. Does **not** change issues or
artifacts except optionally refreshing the mirror **Next** column if it is stale.

**On invoke:** read [../workflow/reference.md](../workflow/reference.md) and
[../tracker/SKILL.md](../tracker/SKILL.md).

Bare user cues **next** and **ship** are not this skill — they are
[continuation keywords](../workflow/reference.md#continuation-keywords)
(**next** = run persisted Next once; **ship** = run [ship](../ship/SKILL.md)).
Use summarise when the user wants status / "what next" *reported*, not advanced.

## Resolve the subject

1. User provides issue key/URL (`/summarise MD-2`, `/summarise PROJ-200`, `/summarise #42`).
2. Else use the single **active** row in `docs/agents/ISSUES.md` (In Progress / In Review).
3. Else ask once: "Which issue should I summarise?"

`fetch` the issue via the tracker backend. Load linked markdown when present:

| File | Use |
|------|-----|
| `docs/agents/WORKSPACE.md` | Provider + paths |
| `docs/agents/ISSUES.md` | Mirror status / Next |
| `ROADMAP.md` | Phase context / parent Story |
| `PLAN.md` | Feature definition readiness |
| `BUG.md` | Bug-fix readiness |
| `ITERATE.md` | Post-ship iterate readiness |
| `MODEL.md` | Math alignment (not product definition) |
| `RESEARCH.md` | Multi-axis research brief (supportive — not user alignment) |
| PR (if linked) | Implement / review / ship stage |

## Infer workflow stage

Detect **track**: feature if `PLAN.md` / ROADMAP phase; **bug** if `BUG.md` (or bug label/type) without a feature plan; **iterate** if `ITERATE.md` (post-ship follow-up).

Pick the furthest stage that matches evidence:

| Stage | Evidence |
|-------|----------|
| **setup** | No WORKSPACE (tell user to `/setup`) |
| **explore** | Map Story / route Task with no PLAN yet |
| **bug** | `BUG.md` linked; not yet In Progress |
| **iterate** | `ITERATE.md` linked (or Relates to a Done prior Task); building or about to |
| **research** | `RESEARCH.md` linked; define not done — brief is supportive only; Next usually `/define` or `/model` |
| **model** | `MODEL.md` linked; define not done — math aligned; product particulars still need `/define` |
| **define** | Feature Task enriched but plan incomplete; or PLAN exists, not started |
| **implement** | Status In Progress, or branch/PR WIP |
| **review** | Status In Review; PR open (one-shot) |
| **review-fix** | Actively looping review↔fix, or preferred post-implement/iterate stage |
| **fix-forward** | In Review/In Progress + open `REQUEST_CHANGES` / unreplied review threads |
| **ship-ready** | In Review + latest review clean (no blockers) |
| **done** | Status Done / PR merged |

## Reply shape (chat only)

```markdown
# <KEY>: <title>

**Track:** feature | bug | iterate

**About:** <2–4 sentences from issue + PLAN/BUG/ITERATE/ROADMAP>

**Stage:** <stage> — <one line why>

**Artifacts:**
- ROADMAP / PLAN / BUG / ITERATE / MODEL / RESEARCH / PR — present or missing

**Status:** <To Do | In Progress | In Review | Done>

## Next
`/<skill> <KEY>` — <one-line why>
```

If Done: **Next** is the following phase Task from ROADMAP, another bug, `/iterate` when merged work still needs a fix, or "No further work on this Task."

When the Task is ready-to-build or further along but not Done, prefer suggesting
`/ship <KEY>` (or bare `ship`) when the user wants to **finish remaining** work in
one invoke; otherwise suggest the single next step skill (`/implement`,
`/review-fix`, …) — bare `next` runs that one step.
## Rules

- Do not implement, transition, or open PRs.
- Prefer persisted **Next** from issue / mirror / PLAN / BUG when still valid; recompute if status moved past it.
- If WORKSPACE is missing, say so and **Next** = `/setup`.
