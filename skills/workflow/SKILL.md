---
name: workflow
description: >-
  Shared pipeline contract for feature work, bug fixes, and post-ship iterate,
  including one delivery branch/PR per Task (closed-loop ship), ship as remaining-
  workflow orchestrator after define, continuation keywords (next = one step,
  ship = finish remaining), review-fix single pass, research/model side paths, and
  summarise. Markdown continuity and pluggable trackers. Not for user invocation —
  composed by those skills.
disable-model-invocation: true
---

# Workflow

**Shared reference skill.** Users invoke pipeline skills, not this file.

When a main-pipeline skill needs ticket continuity, artifact ownership, next-step
handoff rules, **continuation keywords** (`next` vs `ship`), or **delivery branch /
closed-loop ship** rules, read [reference.md](reference.md).

Issue tracker operations: [../tracker/SKILL.md](../tracker/SKILL.md).
Workspace decisions: [../setup/SKILL.md](../setup/SKILL.md) → repo
`docs/agents/WORKSPACE.md` layered over global `~/.agents/WORKSPACE.md`.
