---
name: help
description: >-
  Help choosing skills and workflows. Summarises the catalog, when to use each
  path, and how pipelines connect — without starting delivery work. Use when
  asking which skill to run, how workflows relate, what bug vs tweak vs refine
  vs rework means, or for a navigation overview of this skills set.
---

# Help

Human-facing map of this skills set. **Explains** choices; does **not** create
issues, write specs, or advance a Task. For autonomous routing into a path, the
agent uses [workflows](../workflows/SKILL.md); for status of an in-flight Task,
use [summarise](../summarise/SKILL.md).

**On invoke:** read [../workflows/SKILL.md](../workflows/SKILL.md) (catalog only)
and [../workflow/reference.md](../workflow/reference.md) (stage ownership). Reply
from this skill; do not load every pipeline skill.

## Steps

1. **Orient** — If the user named a situation, point at one primary workflow; if
   they asked for an overview, give the short map below. Done when the reply
   matches overview vs choose-one.
2. **Reply** — Use the shapes below; keep it scannable. Done when the user can
   pick a `/skill` or see that `/workflows` will route for them.
3. **Stop** — Do not start setup/explore/define/implement unless they explicitly
   ask to begin that work after help. Done when the answer ends on a suggested
   invoke or “say what you’re trying to do.”

## Short map

### Pick a delivery entry

| If you… | Run | Produces |
|---------|-----|----------|
| Have no workspace yet | `/setup` | `WORKSPACE.md` |
| Feel a big/foggy goal but not the steps | `/explore` | `ROADMAP.md` + route Tasks |
| Have a concrete feature slice to pin down | `/define` | `PLAN.md` |
| Have a defect to fix | `/bug` | `BUG.md` |
| Want a **small intentional** behaviour change | `/tweak` | `TWEAK.md` |
| Want **structure/docs** improved, **same** runtime behaviour | `/refine` | `REFINE.md` |
| Want an **implementation swap** with **no performance/outcome degradation** | `/rework` | `REWORK.md` |
| Need literature/evidence before deciding | `/research` | `RESEARCH.md` |
| Need math formulation aligned with you | `/model` | `MODEL.md` |
| Have an approved PLAN/BUG/TWEAK/REFINE/REWORK/ITERATE | `/implement` | code on the Task PR |
| Have merged work that’s still wrong | `/iterate` | `ITERATE.md` + new PR |
| Want findings only on an In Review PR | `/review` | review comments |
| Want review → fix → CLEAN on that PR | `/review-fix` | CLEAN PR |
| Want remaining work finished through merge | `/ship` (or bare **ship**) | Done |
| Want status / what Next is | `/summarise` | report only |
| Want this map / which skill | `/help` | this overview |

### Closed-loop shapes

```text
Feature (foggy):  setup → explore → … → define → implement → review-fix → ship
Bug:              setup → bug → implement → review-fix → ship
Tweak:            setup → tweak → implement → review-fix → ship
Refine:           setup → refine → implement → review-fix → ship
Rework:           setup → rework → implement (comparative eval) → review-fix → ship
Post-merge fix:   ship → iterate → review-fix → ship
```

Bare **next** runs the Task’s persisted Next once; bare **ship** finishes remaining
through Done.

### Lightweight siblings (don’t confuse these)

| Skill | Changes behaviour? | Verification emphasis |
|-------|--------------------|------------------------|
| **bug** | Fixes wrong behaviour | Repro + regression |
| **tweak** | Yes — small intentional delta | Acceptance + tests |
| **refine** | No — structure/naming/docs only | Behaviour unchanged |
| **rework** | Yes — internal/algorithm change | **Baseline vs candidate** vs parity bar |

### Side paths (enrich a feature Task; don’t replace define)

| Skill | Role |
|-------|------|
| **research** | Multi-axis evidence → orients later define |
| **model** | Math with the user → orients later define |

### Meta (this repo / authoring)

| Skill | Role |
|-------|------|
| **workflows** | Model router: infers path and **runs** it |
| **help** | Explains choices; does not run delivery |
| **manage-skills** | Install/sync/maintain this skills repo |
| **writing-for-agents** | How to author skills/concepts |

## Choose-one reply shape

When the user described work:

```markdown
**Suggested:** `/<skill>` — <one line why>

**Not:** `/<other>` — <one line why not>

**Then:** <typical Next chain in one line>
```

Ask one clarifying question only when two entries would cause material rework
(e.g. refine vs rework when it is unclear whether the algorithm itself changes).

## Overview reply shape

When they want the map: present **Pick a delivery entry** + **Lightweight
siblings**; add closed-loop shapes only if useful. End with:

```markdown
## Next
`/<skill>` — <if one is clear>, or say what you’re trying to do and I’ll point
at one path (or let workflows route it).
```
