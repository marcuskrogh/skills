# MD-1: Platform catalogue slug update

| Field | Value |
|-------|-------|
| Type | Task |
| Status | To Do |
| Parent | |
| Children | MD-2 |
| Artifact | docs/agents/PLAN.md |
| PR | https://github.com/marcuskrogh/skills/pull/56 |
| Created | 2026-09-27 |

## Summary

Small intentional update of platform-catalogue prefer slugs from the locked 2026-09-27 audit. Class tweak, template delta-fast.

## Classification

- Class: tweak
- Confidence: high
- Why: small intentional change to which models the catalogues prefer

## Workflow

- Template: delta-fast
- Parameters: implement.mode single; implement.verify tests; implement.iteration one-shot; test.mode dedicated; harden.mode dedicated; review.mode single; review.depth focused; review.lasers sequential; side_paths none; sandbox none
- Chain: architect → implement → test → restructure → review → ship

## Acceptance

See pass criteria in `docs/agents/PLAN.md`.

## Comments

### 2026-09-27

Plan written. Classification tweak, template delta-fast. Branch `cursor/md-1-platform-slugs-c226`. PLAN.md at 222f24a. PR https://github.com/marcuskrogh/skills/pull/56.

### 2026-09-27

Shape stamp in `docs/agents/ARCHITECTURE.md`. Task stays To Do. Next: `/implement MD-1`
