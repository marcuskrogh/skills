# Implementation plan: First-party Cursor subagents on Mobile Cloud

## Summary
Skills that spawn `Task` workers on Cursor must stay on Composer and Grok. A Cloud Agent started from Mobile sometimes billed **Other Models** because detection omitted Mobile, an incomplete Task enum fell through to General, and harness `inherit` / picker-list guidance selected third-party models.

## Scope / Decisions / Constraints
- **In:** Cursor platform catalog, CONCEPT_DELEGATION, PLATFORM-CATALOGS, always-on pointers, `validate-skills.ps1` regression checks.
- **Out:** Changing non-Cursor platform files; allowing fast SKUs; adding third-party slugs to the Cursor allowlist.
- **Behaviour:** Every Cursor `Task` spawn (Desktop, Cloud, CLI, Mobile, including Cloud started from Mobile) passes an allowlisted slug. Missing prefer slug → `composer-2.5`. Never inherit, omit `model`, or pick a picker model. Incomplete enum stays on Cursor, not General.
- **Constraints:** Do not backtick-wrap forbidden picker SKUs in `cursor.md` (validate-skills allowlist). Keep always-on pointers short.

## Classification
- Class: bug
- Confidence: high
- Why: Wrong worker models on Cursor Mobile Cloud; expected first-party-only spawn is known.

## Workflow
- Template: fix-fast
- Parameters:
  - implement.mode: single
  - implement.verify: tests
  - implement.iteration: one-shot
  - test.mode: dedicated
  - harden.mode: dedicated
  - review.mode: single
  - review.depth: focused
  - review.lasers: sequential
  - side_paths: none
  - sandbox: none
- Chain: architect → implement → test → restructure → review → ship
- Rationale: Contained catalog/docs defect; validation script is the regression seam; test and harden stay the floor.

## Inputs
- Research: none
- Model: none
- Sandbox: none

## Acceptance criteria
- Cursor detection includes Mobile and Cloud-from-Mobile; incomplete Task enums do not load General.
- Spawn contract forbids inherit/omit on Cursor; missing prefer slug remaps to `composer-2.5`; picker slugs stay illegal.
- Always-on pointers (AGENTS.md, CLAUDE.md, `.cursor/rules`, install templates) state the same rule.
- `scripts/validate-skills.ps1` fails if those rules regress.

## Work packages
1. Catalog + pointers: Cursor/Mobile detection, no General fallthrough, inherit/enum remap.
2. Validation: extend `validate-skills.ps1` to lock the regression.

## Open items
- None. Expected first-party-only spawn is the product rule already in the catalog.

## Tracker
- Provider: markdown
- Task: MD-1
- Sub-tasks: MD-2, MD-3
- Branch: cursor/first-party-cloud-subagents-5fab
- PR: https://github.com/marcuskrogh/skills/pull/48
- Classification: bug
- Workflow: fix-fast

## Next
`/ship MD-1` — Merge and close out (CLEAN review)
