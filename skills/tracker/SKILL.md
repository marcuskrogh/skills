---
name: tracker
description: >-
  Shared issue-tracker contract for pipeline skills. Resolves the provider from
  the effective workspace (repo docs/agents/WORKSPACE.md over global
  ~/.agents/WORKSPACE.md): markdown, jira, github, or linear. Not for user
  invocation — composed by explore, define, implement, review, ship, and setup.
disable-model-invocation: true
---

# Tracker

**Shared reference skill.** Users configure the tracker via [setup](../setup/SKILL.md), not this file.

**On invoke:** resolve the **effective workspace**
([../setup/format.md](../setup/format.md) → **Resolution order**), then read
[reference.md](reference.md) and only the matching backend under `backends/`.

If neither workspace layer resolves, hand off to `/setup` before creating issues.
