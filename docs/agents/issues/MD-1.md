# MD-1: First-party Cursor subagents on Mobile Cloud

| Field | Value |
|-------|-------|
| Type | Task |
| Status | In Review |
| Parent | |
| Children | MD-2, MD-3 |
| Artifact | docs/agents/PLAN.md |
| Branch | cursor/first-party-cloud-subagents-5fab |
| PR | https://github.com/marcuskrogh/skills/pull/48 |
| Classification | bug |
| Workflow | fix-fast |
| Created | 2026-09-01 |

## Summary
Applying skills in a Cursor Cloud environment started from Mobile sometimes spawns third-party `Task` workers (Other Models) instead of Composer / Grok.

## Acceptance
- Mobile and Cloud-from-Mobile detect as Cursor; incomplete enums do not fall through to General.
- Every Cursor `Task` spawn passes `composer-2.5` or `cursor-grok-4.6-high`; missing prefer slug → `composer-2.5`; never inherit or picker slugs.
- `validate-skills.ps1` locks the rule.

## Classification
- Class: bug
- Template: fix-fast
- Chain: architect → implement → test → restructure → review → ship

## Next
`/review MD-1` — Lasers then fix then code review

## Comments

### 2026-09-01
Define complete. PLAN.md on delivery branch. Next: `/architect MD-1`.

### 2026-09-01
Architect + implement: catalog, pointers, and validate-skills checks on this branch. Next: `/test MD-1`.

### 2026-09-01
Test: `pwsh scripts/validate-skills.ps1` green (Mobile / inherit / no-General-on-incomplete). Working surfaces: none. Next: `/restructure MD-1`.

### 2026-09-01
Restructure: campground on CONCEPT_DELEGATION assign-model step (enum remap). Task In Review. Next: `/review MD-1`.
