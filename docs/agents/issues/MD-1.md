# MD-1: Session working tree for local delivery

| Field | Value |
|-------|-------|
| Type | Task |
| Status | In Review |
| Parent | |
| Children | MD-2 |
| Artifact | docs/agents/PLAN.md |
| PR | https://github.com/marcuskrogh/skills/pull/53 |
| Classification | tweak |
| Workflow | delta-fast |
| Branch | cursor/local-session-working-tree-0a5d |
| Created | 2026-09-04 |

## Summary
Local pipeline work checks out the delivery branch in the folder the operator opened, not in a linked Git worktree.

## Acceptance
- none — no executable behaviour

## Comments

### 2026-09-04
Define + architect recorded. Next: `/implement MD-1`

### 2026-09-04
Implement complete (docs-only; test skipped). Next: `/restructure MD-1`

### 2026-09-04
Restructure: no extra layers; session working tree stays in delivery.md. Next: `/review MD-1`

### 2026-09-04
Focused review CLEAN (spec, checkout rule, Cursor spawn). Published GitHub review skipped (`gh` is read-only here). Next: `/ship MD-1`
