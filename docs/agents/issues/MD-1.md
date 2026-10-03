# MD-1: Presentation front page

| Field | Value |
|-------|-------|
| Type | Task |
| Status | In Review |
| Parent | |
| Children | MD-2 |
| Artifact | docs/agents/PLAN.md |
| PR | |
| Created | 2026-10-03 |

## Summary

Rewrite the skills repository front page into a short presentation: description and motivation, install, what it does and how you use it, then chapters. Images and examples stay on the front page. Depth stays in `docs/guide/`.

## Acceptance

none — no executable behaviour

## Classification

- Class: refine
- Template: structure-safe
- Chain: architect → implement → restructure → review → ship
- test.mode: skip
- harden.mode: dedicated
- review.depth: focused
- review.mode: single
- review.lasers: sequential

## Comments

### 2026-10-03 define

Operator set the four-part front page and asked to record it and proceed. Plan and structure-safe binding are on `docs/agents/PLAN.md`. Branch `cursor/readme-presentation-ac69`. Next: `/architect MD-1` — record where the front page and guide chapters sit.

### 2026-10-03 architect

`docs/agents/ARCHITECTURE.md` is on the branch. The change lives in `README.md` and `docs/guide/`. No new module. Next: `/implement MD-1` — write the presentation front page.

### 2026-10-03 implement

Front page, guide alignment, and three images under `docs/guide/` are on the branch. `test.mode=skip` (docs-only). Sub-task MD-2 is done. Outcome `built`. Next: `/restructure MD-1` — structure pass on the docs diff.

### 2026-10-03 restructure

Touched pages are the front page and the guide chapters it links. No executable behaviour. No catalog breach to extract: the long install material is the install chapter, and the front page stays the short presentation. Outcome `ready`. Next: `/review MD-1` — focused review of the docs diff.

## Next
`/review MD-1` — focused review of the docs diff
