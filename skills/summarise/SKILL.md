---
name: summarise
description: >-
  Summarises a pipeline Task (or Story): what it is about, where it sits in
  setup → explore → design → implement → review → ship, which artifacts exist,
  and what the user should run next. Use when asking status, where am I, or what next.
---

# Summarise

Read-only status skill for the main pipeline. Does **not** change issues or artifacts
except optionally refreshing the mirror **Next** column if it is stale vs the issue.

**On invoke:** read [../workflow/reference.md](../workflow/reference.md) and
[../tracker/SKILL.md](../tracker/SKILL.md).

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
| `PLAN.md` | Design readiness |
| `MODEL.md` | Model spec |
| `RESEARCH.md` | Research brief |
| PR (if linked) | Implement / review / ship stage |

## Infer workflow stage

Pick the furthest stage that matches evidence:

| Stage | Evidence |
|-------|----------|
| **setup** | No WORKSPACE (tell user to `/setup`) |
| **explore** | Story only / Task with no PLAN |
| **research** | `RESEARCH.md` linked; design not done |
| **model** | `MODEL.md` linked; design not done |
| **design** | Task enriched but no/incomplete plan packages → still designing; or PLAN exists, not started |
| **implement** | Status In Progress, or branch/PR WIP |
| **review** | Status In Review; PR open |
| **fix-forward** | In Review/In Progress + open `REQUEST_CHANGES` / unreplied review threads |
| **ship-ready** | In Review + latest review clean (no blockers) |
| **done** | Status Done / PR merged |

Side paths **research** / **model** are stages *within* a phase, not replacements for the main chain.

## Reply shape (chat only)

Keep it short — no essay:

```markdown
# <KEY>: <title>

**About:** <2–4 sentences from issue + PLAN/ROADMAP summary>

**Stage:** <stage> — <one line why>

**Artifacts:**
- ROADMAP / PLAN / MODEL / RESEARCH / PR — present or missing

**Status:** <To Do | In Progress | In Review | Done>

## Next
`/<skill> <KEY>` — <one-line why>
```

If Done: **Next** is the following phase Task from ROADMAP, or "No further work on this Task."

## Rules

- Do not implement, transition, or open PRs.
- Prefer persisted **Next** from issue / mirror / PLAN when still valid; recompute if status clearly moved past it.
- If WORKSPACE is missing, say so and **Next** = `/setup`.
