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

**On invoke:** read [../workflows/SKILL.md](../workflows/SKILL.md) (catalog only).
Reply from this skill; do not load every pipeline skill.

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
| Want the structure catalog applied across a brownfield codebase | `/adopt` | Characterizes current behaviour into tests, then walks architect → implement → test → restructure → review → ship per area until Done |

### Walk, teach, map

| If you… | Run | What happens |
|---------|-----|----------------|
| Want this map | `/help` | overview only |
| Want the current step or a decision taught | `/explain` | paced teaching |
| Want to be walked through a manual task | `/guide` | one step at a time |

After define, follow persisted **Next** (or bare **next** / **ship**). You do **not** need to remember architect / implement / test / restructure / review /
class-specific entry skills.

Define infers **class** and binds a **template** after alignment —
[CONCEPT_CLASSIFICATION](../concepts/CONCEPT_CLASSIFICATION.md) and
[CLASSIFICATION-CATALOG.md](../concepts/CLASSIFICATION-CATALOG.md). Class
**adopt** walks characterize → architect → implement → test → restructure →
review → ship per area until Done.

### Closed-loop shape

```text
setup → explore? → define (classify + bind) → architect → [sandbox?] → [bound chain: often implement → test → restructure (refactoring) → review → ship]
brownfield structure:  adopt (inventory → [characterize → architect → implement → test → restructure → review → ship] per area until Done)
post-merge fix:  ship → iterate → test → restructure → review → ship
post-merge inspect-loop:  ship → sandbox → implement → test → restructure → review → ship
```

After ship, `/iterate` when tests/review on a new PR suffice; `/sandbox` when
each turn needs visual, plot, or report inspection. The sandbox must match
production in every area that would change that inspection.

### Manual overrides (optional)

Pipeline skills stay **user-invokable** when you want to skip define's classifier
or deviate from Next. Explicit `/skill` wins.

### Meta

| Skill | Role |
|-------|------|
| **workflows** | Model router: foggy → explore, concrete → define; walkthroughs → guide; teaching → explain |
| **help** | Maps skills; does not run delivery |
| **explain** | Teaches the current step and decisions |
| **guide** | Walks a manual task one step at a time |
| **manage-skills** | Install/sync this repo |
| **writing-for-agents** | Author skills/concepts |

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
