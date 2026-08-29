---
name: help
description: >-
  Help choosing skills and workflows. Summarises front doors (explore, define),
  how classification binds a workflow, and how Next walks delivery — without
  starting work. Use when asking which skill to run, how workflows relate, or
  for a navigation overview. Prefer /explain to teach a current step; prefer
  /guide to walk through a task.
---

# Help

Human-facing map of this skills set. **Maps** choices; does **not** create
issues, write specs, or advance a Task. For autonomous routing, the agent uses
[workflows](../workflows/SKILL.md); for status of an in-flight Task, use
[summarise](../summarise/SKILL.md); for teaching the current step, use
[explain](../explain/SKILL.md); for a paced walkthrough, use
[guide](../guide/SKILL.md).

**On invoke:** read [CONCEPT_LANGUAGE](../concepts/CONCEPT_LANGUAGE.md),
[../workflows/SKILL.md](../workflows/SKILL.md) (catalog only)
and [../workflow/reference.md](../workflow/reference.md) (stage ownership). Reply
from this skill; do not load every pipeline skill.

## Steps

1. **Orient** — If the user named a situation, point at **explore** or **define**
   (or **adopt** / **guide** / **explain** / a continuation); if they asked for an overview, give the short map.
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
| Feel a big/foggy goal but not the steps | `/explore` | `ROADMAP.md` + route Tasks; research/model/sandbox = artifacts on the delivery branch → `/define` |
| Have concrete work (bug, tweak, refine, rework, feature, …) | `/define` | Align → agent **classifies** → binds **workflow** → `PLAN.md` + **Next** |

### Whole-repo structure

| If you… | Run | What happens |
|---------|-----|----------------|
| Want the structure catalog applied across a brownfield codebase | `/adopt` | Inventory → sequence → apply frontier → `ADOPT.md` + **Next** `/test` |

### Walk, teach, map

| If you… | Run | What happens |
|---------|-----|----------------|
| Want this map | `/help` | overview only |
| Want the current step or a decision taught | `/explain` | paced teaching |
| Want to be walked through a manual task | `/guide` | one step at a time |

After define, follow persisted **Next** (or bare **next** / **ship**). You do **not** need to remember implement / test / harden / review-fix /
class-specific entry skills.

### What define binds (agent-side)

Define applies [CONCEPT_CLASSIFICATION](../concepts/CONCEPT_CLASSIFICATION.md):
infers **class** (bug / tweak / adopt / refine / rework / feature / …), selects a
**template** (fix-fast, parity-iterative, feature-heavy, …) and **parameters**
(single vs multiagent implement/review, verify mode, **test and harden as the
floor**, review depth and lasers, optional research/model side paths, optional
sandbox inspect-loop), then walks that chain almost deterministically.
Class **adopt** binds Chain `adopt → test → harden → review-fix → ship`.

### Closed-loop shape

```text
setup → explore? → define (classify + bind) → [sandbox?] → [bound chain: often implement → test → harden → review-fix → ship]
brownfield structure:  adopt → test → harden → review-fix → ship
post-merge fix:  ship → iterate → test → harden → review-fix → ship
post-merge inspect-loop:  ship → sandbox → implement → test → harden → review-fix → ship
```

After ship, `/iterate` when tests/review on a new PR suffice; `/sandbox` when
each turn needs visual, plot, or report inspection. The sandbox must match
production in every area that would change that inspection.

### Manual overrides (optional)

All pipeline skills stay **user-invokable** when you want to deviate from Next
or skip define’s classifier: `/bug`, `/tweak`, `/refine`, `/rework`,
`/adopt`, `/sandbox`, `/implement`, `/test`, `/harden`, `/review`, `/review-fix`, `/ship`, `/research`,
`/model`, `/summarise`, `/guide`, `/explain`, …

### Meta

| Skill | Role |
|-------|------|
| **workflows** | Model router: foggy → explore, concrete → define; walkthroughs → guide; teaching → explain |
| **help** | Maps skills; does not run delivery |
| **explain** | Teaches the current step and decisions |
| **guide** | Walks a manual task one step at a time |
| **manage-skills** | Install/sync this repo |
| **writing-for-agents** | Author skills/concepts |

User-facing replies follow [CONCEPT_LANGUAGE](../concepts/CONCEPT_LANGUAGE.md).
`/setup` can persist `Agent language: general` for all operator-directed agent
prose in the workspace.

## Choose-one reply shape

```markdown
**Suggested:** `/explore` or `/define` or `/adopt` or `/guide` or `/explain` — <one line why>

**Then:** follow **Next** on the Task (bound workflow), or wait for okay after each walkthrough or explanation step

**Manual override (optional):** `/<skill>` — <only if they asked to skip the front door>
```

## Overview reply shape

Present **Front doors** + **Whole-repo structure** + **Walk, teach, map** + **Closed-loop shape**; mention manual overrides only
briefly. End with:

```markdown
## Next
`/define` or `/explore` or `/adopt` or `/guide` or `/explain` — <if clear>, or say what you’re trying to do.
```
