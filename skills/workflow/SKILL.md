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

**On invoke:** read [reference.md](reference.md). Disclose branch refs only when
needed: [delivery.md](delivery.md), [handoff.md](handoff.md),
[tracker-sync.md](tracker-sync.md), [ship.md](ship.md), [changelog.md](changelog.md).

Issue tracker operations: [../tracker/SKILL.md](../tracker/SKILL.md).
Workspace decisions: [../setup/SKILL.md](../setup/SKILL.md).
