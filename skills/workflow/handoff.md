# Handoff protocol

Every pipeline skill **ends** by telling the user the next invoke and writing
**Next** into durable surfaces. Load when finishing a skill or resolving
continuation.

## Next block

```markdown
## Next
`/<skill> <ISSUE-KEY>` — <one-line why>
```

Also write **Next** into: the issue comment (or markdown Comments section), the
alignment artifact, and the ISSUES mirror when enabled. Chat-only Next is not
enough.

## Default Next by stage

| After | Next (default) |
|-------|----------------|
| setup | `/explore` or `/define` (front doors); `/help` for the map |
| explore | Frontier route Task skill — usually `/define` |
| bug | `/implement <Task>` (or `/ship <Task>` for remaining) |
| tweak | `/implement <Task>` (or `/ship <Task>` for remaining) |
| refine | `/implement <Task>` (or `/ship <Task>` for remaining) |
| rework | `/implement <Task>` (or `/ship <Task>` for remaining) |
| research | `/model <Task>` or `/define <Task>` |
| model | `/define <Task>` (or `/implement` if PLAN exists) |
| define | `/implement <Task>` (or first Chain step from Workflow binding; or `/ship`) |
| implement | `/review-fix <Task>` (or `/review` / `/ship`) |
| iterate | `/review-fix <NewTask>` (or `/ship <NewTask>`) |
| review (must-fix) | `/review-fix` or `/implement` fix-forward |
| review (clean / non-actionable notes only) | `/ship <Task>` |
| review-fix (CLEAN) | `/ship <Task>` |
| review-fix (FAILED) | `/implement` or `/review` — or `/ship` to retry remaining |
| ship (Done) | Done — or `/iterate` if merged work still wrong |
| ship (stopped) | `/ship <Task>` or the skill that unblocks |
| summarise | *(reports Next; does not advance)* |

## Entry context

| Skill | Load |
|-------|------|
| bug | Related Task/Story if linked; codebase pointers from user |
| tweak | Related Task/Story if linked; codebase pointers from user |
| refine | Related Task/Story if linked; thin area description + codebase pointers from user |
| rework | Related Task/Story if linked; thin area description + parity bar pointers from user |
| iterate | Prior shipped Task + merged PR + PLAN/BUG/TWEAK/REFINE/REWORK/prior ITERATE |
| research / model | Task (+ Story), ROADMAP, sibling artifacts — research is supportive |
| define | Task (+ Story), ROADMAP, RESEARCH/MODEL as **supportive** — still probe the user; then classify + bind workflow |
| implement | Task + Sub-tasks, PLAN / BUG / TWEAK / REFINE / REWORK, **existing delivery branch/PR**, test/lint commands (rework → comparative eval) |
| review / review-fix | Task + **same** delivery PR + PLAN/BUG/TWEAK/REFINE/REWORK/ITERATE |
| ship | Task + PLAN/BUG/TWEAK/REFINE/REWORK/ITERATE + delivery branch/PR; detect stage |
| summarise | Task + artifacts needed for stage inference |
| help | None required — catalog overview; no Task advance |
