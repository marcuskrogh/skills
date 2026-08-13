---
name: help
description: >-
  Help choosing skills and workflows. Summarises front doors (explore, define),
  how classification binds a workflow, and how Next walks delivery — without
  starting work. Use when asking which skill to run, how workflows relate, or
  for a navigation overview of this skills set.
---

# Help

Human-facing map of this skills set. **Explains** choices; does **not** create
issues, write specs, or advance a Task. For autonomous routing, the agent uses
[workflows](../workflows/SKILL.md); for status of an in-flight Task, use
[summarise](../summarise/SKILL.md).

**On invoke:** read [CONCEPT_LANGUAGE](../concepts/CONCEPT_LANGUAGE.md),
[../workflows/SKILL.md](../workflows/SKILL.md) (catalog only)
and [../workflow/reference.md](../workflow/reference.md) (stage ownership). Reply
from this skill; do not load every pipeline skill.

## Steps

1. **Orient** — If the user named a situation, point at **explore** or **define**
   (or a continuation); if they asked for an overview, give the short map.
   Done when the reply matches overview vs choose-one.
2. **Reply** — Use the shapes below; keep it scannable. Done when the user knows
   the front door and that **Next** carries the rest.
3. **Stop** — Do not start setup/explore/define/implement unless they explicitly
   ask to begin that work after help. Done when the answer ends on a suggested
   invoke or “say what you’re trying to do.”

## Short map

### Front doors (what to remember)

| If you… | Run | What happens |
|---------|-----|----------------|
| Have no workspace yet | `/setup` | `WORKSPACE.md` |
| Feel a big/foggy goal but not the steps | `/explore` | `ROADMAP.md` + route Tasks; research/model = finding docs on the delivery branch → `/define` |
| Have concrete work (bug, tweak, refine, rework, feature, …) | `/define` | Align → agent **classifies** → binds **workflow** → `PLAN.md` + **Next** |
| Want this map | `/help` | overview only |

After define, follow persisted **Next** (or bare **next** / **ship**). You do
**not** need to remember implement / review-fix / class-specific entry skills.

### What define binds (agent-side)

Define applies [CONCEPT_CLASSIFICATION](../concepts/CONCEPT_CLASSIFICATION.md):
infers **class** (bug / tweak / refine / rework / feature / …), selects a
**template** (fix-fast, parity-iterative, feature-heavy, …) and **parameters**
(single vs multiagent implement/review, verify mode, review depth), then walks
that chain almost deterministically.

### Closed-loop shape

```text
setup → explore? → define (classify + bind) → [bound chain: often implement → review-fix → ship]
post-merge fix:  ship → iterate → review-fix → ship
```

### Manual overrides (optional)

All pipeline skills stay **user-invokable** when you want to deviate from Next
or skip define’s classifier: `/bug`, `/tweak`, `/refine`, `/rework`,
`/implement`, `/review`, `/review-fix`, `/ship`, `/research`, `/model`,
`/summarise`, …

### Meta

| Skill | Role |
|-------|------|
| **workflows** | Model router: foggy → explore, else → define (continuations honored) |
| **help** | Explains; does not run delivery |
| **manage-skills** | Install/sync this repo |
| **writing-for-agents** | Author skills/concepts |
| **frontend-design** | Product-surface UI: **direction**, **signature**, **craft** |

User-facing replies follow [CONCEPT_LANGUAGE](../concepts/CONCEPT_LANGUAGE.md).
`/setup` can persist `Agent language: general` for all operator-directed agent
prose in the workspace.

## Choose-one reply shape

```markdown
**Suggested:** `/explore` or `/define` — <one line why>

**Then:** follow **Next** on the Task (bound workflow)

**Manual override (optional):** `/<skill>` — <only if they asked to skip the front door>
```

## Overview reply shape

Present **Front doors** + **Closed-loop shape**; mention manual overrides only
briefly. End with:

```markdown
## Next
`/define` or `/explore` — <if clear>, or say what you’re trying to do.
```
