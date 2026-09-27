---
name: workflow
description: >-
  Workflow contract for pipeline continuity: one delivery branch/PR per Task,
  closed-loop ship, continuation keywords (next vs ship), and pointers to
  disclosed delivery/handoff/tracker/ship refs. Not for user invocation —
  composed by pipeline skills.
disable-model-invocation: true
---

# Workflow

**Shared reference skill.** Users invoke pipeline skills, not this file.

**On invoke:** read [reference.md](reference.md) and [handoff.md](handoff.md).
When a skill finishes or **Next** is resolved, also read [pipelines.md](pipelines.md).
Disclose other refs only when a step needs them: [delivery.md](delivery.md),
[tracker-sync.md](tracker-sync.md), [ship.md](ship.md), [changelog.md](changelog.md).

Pipeline skills point here instead of listing those files. Issue tracker
operations: [../tracker/SKILL.md](../tracker/SKILL.md). Workspace decisions:
[../setup/SKILL.md](../setup/SKILL.md).

A reply that finishes a pipeline skill ends with the **Next** block in
[handoff.md](handoff.md). An open alignment turn is the one question; it does
not include that block and does not start the next skill.
