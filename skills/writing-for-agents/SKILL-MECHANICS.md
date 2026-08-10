# Skill mechanics

Skill-specific branch of [`writing-for-agents`](SKILL.md): frontmatter,
invocation, and routers. Universal writing rules stay in `SKILL.md`.

## Invocation

Two choices, trading the two loads:

- **Model-invoked** — keeps a model-facing `description` (always-loaded
  context pointer). Agent can fire it; other skills can reach it. Omit
  `disable-model-invocation`. Write trigger branches into the description.
- **User-invoked** — set `disable-model-invocation: true`. Description becomes
  human-facing (one-line summary; strip trigger lists from the always-loaded
  cut if you also keep a short human blurb). Zero context load; human is the
  index.

Pick model-invocation only when the agent must discover the skill, or another
skill must reach it.

In this repo:

| Kind | Invocation | Examples |
|------|------------|----------|
| **Router** | model-invoked | `workflows`, `writing-for-agents`, `help` |
| **Pipeline / meta** | user-invoked | `explore`, `define`, `implement`, `manage-skills`, … |
| **Composed reference** | user-invoked (not for humans) | `workflow`, `tracker`, `jira` |

Pipeline skills stay user-invoked so their descriptions do not spend context load
every turn. Discovery of “which pipeline?” is `workflows`' job.

Shared reference two user-invoked skills both need lives in a **concept** or
plain disclosed file — not in either skill body copied twice.

## Splitting by invocation

Split off a model-invoked skill when a distinct leading word should trigger it
alone, or another skill must reach it. You pay context load for the new
description — independent reach must earn that.

## Router skills

A **router** restores discoverability without loading every user-invoked skill:

1. **Model-invoked description** lists the work-request branches that should
   fire it (build, fix, investigate, ship, foggy initiative, …).
2. **Body** is a catalog + inference steps — not a copy of each pipeline skill.
3. **Hand-off** is progressive disclosure: after choosing a workflow, **read and
   follow** the target skill (composition). User-invoked skills have no agent
   description, but an explicit “read `../bug/SKILL.md` and run it” pointer still
   reaches them.

Do not build a router that only *hints* at skill names for the human to type
when the goal is autonomous routing — that spends cognitive load and fails the
discovery job. Hint-only routers belong where the human must stay the index.

This repo’s router: [`workflows`](../workflows/SKILL.md). Continuity contract
(not a router): [`workflow`](../workflow/SKILL.md) + `reference.md`. Status
report without advancing work: [`summarise`](../summarise/SKILL.md). Human
navigation map without starting delivery: [`help`](../help/SKILL.md).
