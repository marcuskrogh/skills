---
name: summarise
description: >-
  Status summary for a pipeline Task or Story: purpose, track, stage, artifacts,
  and the next valid invoke. Use for status, where-am-I, or what-next questions.
disable-model-invocation: true
---

# Summarise

Read-only status for feature/bug/tweak/refine/iterate pipelines. Does **not** change issues or
artifacts except optionally refreshing a stale mirror **Next** column.

**On invoke:** read [../workflow/reference.md](../workflow/reference.md),
[../workflow/handoff.md](../workflow/handoff.md), and
[../tracker/SKILL.md](../tracker/SKILL.md).

## Steps

1. **Resolve subject** — Resolve key/URL → single active ISSUES row → branch inference → ask once; fetch it and load linked artifacts from the effective workspace. Done when one Task or Story and its available evidence are identified.
2. **Infer track** — Classify feature (PLAN/ROADMAP), bug (BUG without feature plan), tweak (TWEAK), refine (REFINE), or iterate (ITERATE / Relates to Done prior). Done when one track is supported by durable evidence.
3. **Infer furthest stage** — Compare tracker, artifact, branch, PR, and review evidence against the table below. Done when the highest evidenced stage and any inconsistency are named.
4. **Reply** — Use the reply shape below and the Handoff table to validate persisted **Next**; recompute stale Next from current status. Done when the answer reports About, Track, Stage, Artifacts, Status, and one valid **Next** (or no further work).

| Stage | Evidence |
|-------|----------|
| **setup** | No WORKSPACE |
| **explore** | Map Story / route Task, no PLAN yet |
| **bug** | `BUG.md` linked; not yet In Progress |
| **tweak** | `TWEAK.md` linked; not yet In Progress |
| **refine** | `REFINE.md` linked; not yet In Progress |
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

**Track:** feature | bug | tweak | refine | iterate

**About:** <2–4 sentences from issue + PLAN/BUG/TWEAK/REFINE/ITERATE/ROADMAP>

**Stage:** <stage> — <one line why>

**Artifacts:**
- ROADMAP / PLAN / BUG / TWEAK / REFINE / ITERATE / MODEL / RESEARCH / PR — present or missing

**Status:** <To Do | In Progress | In Review | Done>

## Next
`/<skill> <KEY>` — <one-line why>
```

If Done: **Next** = following ROADMAP phase Task, another bug / tweak / refine, `/iterate` when merged
work still needs a fix, or "No further work on this Task."
