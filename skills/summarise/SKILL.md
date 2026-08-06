---
name: summarise
description: >-
  Summarises a pipeline Task (or Story): what it is about, where it sits in the
  feature or bug workflow, which artifacts exist, and what to run next. Use when
  asking status, where am I, or what next. (Bare "next" advances one persisted
  step; bare "ship" finishes remaining work — see workflow continuation keywords.)
disable-model-invocation: true
---

# Summarise

Read-only status for feature/bug/iterate pipelines. Does **not** change issues or
artifacts except optionally refreshing a stale mirror **Next** column.

**On invoke:** read [../workflow/reference.md](../workflow/reference.md) and
[../tracker/SKILL.md](../tracker/SKILL.md).

Bare **next** / **ship** are [continuation keywords](../workflow/reference.md#continuation-keywords),
not this skill — use summarise when the user wants status *reported*.

## Steps

1. **Resolve subject** — key/URL → single active ISSUES row → tracker inference from branch → ask once. `fetch`; load linked artifacts against effective workspace (repo root or external artifact root).
2. **Infer track** — feature (PLAN/ROADMAP), bug (BUG without feature plan), iterate (ITERATE / Relates to Done prior).
3. **Infer furthest stage** from evidence (table below).
4. **Reply** in the shape below. Prefer persisted **Next** when still valid; recompute if status moved past it. Ready-to-build+ → suggest `/ship` when the user wants to finish remaining; else the single next skill. Missing WORKSPACE → **Next** `/setup`.

| Stage | Evidence |
|-------|----------|
| **setup** | No WORKSPACE |
| **explore** | Map Story / route Task, no PLAN yet |
| **bug** | `BUG.md` linked; not yet In Progress |
| **iterate** | `ITERATE.md` (or Relates Done prior); building or about to |
| **research** | `RESEARCH.md`; define not done — Next usually `/define` or `/model` |
| **model** | `MODEL.md`; define not done — math aligned; particulars need `/define` |
| **define** | Feature Task enriched / PLAN exists, not started |
| **implement** | In Progress, or branch/PR WIP |
| **review** | In Review; PR open (one-shot) |
| **review-fix** | Preferred post-implement/iterate stage |
| **fix-forward** | In Review/In Progress + open REQUEST_CHANGES / unreplied threads |
| **ship-ready** | In Review + clean review (no must-fix) |
| **done** | Done / PR merged |

## Reply shape

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

If Done: **Next** = following ROADMAP phase Task, another bug, `/iterate` when merged
work still needs a fix, or "No further work on this Task."

Do not implement, transition, or open PRs.
