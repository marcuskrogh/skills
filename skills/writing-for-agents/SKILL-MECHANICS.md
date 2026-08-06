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
skill must reach it. Pipeline skills (`explore`, `define`, `implement`, …)
are **user-invoked** in this repo — the human (or bare **Next** / **ship**
continuation) is the index.

Shared reference two user-invoked skills both need lives in a **concept** or
plain disclosed file — not in either skill body copied twice.

## Splitting by invocation

Split off a model-invoked skill when a distinct leading word should trigger it
alone, or another skill must reach it. You pay context load for the new
description — independent reach must earn that.

## Router skills

When user-invoked skills multiply past what you remember, a **router skill**
names the others and when to reach for each. It hints; it cannot fire
user-invoked skills (no description for the agent to follow). Prefer
`/summarise` and workflow **Next** as the lightweight routers already in this
repo before adding another.
