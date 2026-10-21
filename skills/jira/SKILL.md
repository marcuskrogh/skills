---
name: jira
description: >-
  Jira REST details for the tracker jira backend. Prefer the tracker skill and
  WORKSPACE.md provider selection. Not for user invocation.
disable-model-invocation: true
---

# Jira

**Backend detail** for provider `jira`. Pipeline skills should enter through
[../tracker/SKILL.md](../tracker/SKILL.md) and [../tracker/backends/jira.md](../tracker/backends/jira.md).

API patterns: [reference.md](reference.md).

An active ticket framework ([../workflow/inject.md](../workflow/inject.md))
supplies types, statuses, and templates. With no framework, `docs/agents/jira.md`
still replaces this reference for project-specific types and transitions.
