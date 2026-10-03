# MD-1: Presentation front page

| Field | Value |
|-------|-------|
| Type | Task |
| Status | In Review |
| Parent | |
| Children | MD-2 |
| Artifact | docs/agents/PLAN.md |
| PR | https://github.com/marcuskrogh/skills/pull/64 |
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

### 2026-10-03 review

Focused review, sequential. Core and Architecture should-fix items are fixed on this branch: full install confirm, draft pull request, setup and adopt called out before define, external artifact location aligned with `setup/format.md`, `gh` plus tracker auth, scripts table kept in Structure, first-use routing left on the front page. Discarded: a help choose-one exception to the Next block. Help's overview reply still ends with Next. The handoff rule on the front page stays. Depth `focused`. Lasers `sequential`. GitHub review publish failed: `Resource not accessible by integration` on `addPullRequestReview`. The pull-request review is not published, so the outcome is not `CLEAN` yet. Next: `/review MD-1` — publish the pull-request review.

## Next
`/review MD-1` — publish the pull-request review
