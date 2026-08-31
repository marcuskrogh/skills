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
enough — except **guide** and **explain**, which use chat Next only (resume
in-flight or none) and do not write tracker or artifact Next.

## Default Next by stage

| After | Next (default) |
|-------|----------------|
| setup | `/explore` or `/define` (front doors); `/help` for the map |
| explore | Frontier route Task skill — usually `/define` on a delivery Task; research/model/sandbox leave artifacts on that branch (no separate PR) |
| bug | `/architect <Task>` (or `/ship <Task>` for remaining) |
| tweak | `/architect <Task>` (or `/ship <Task>` for remaining) |
| refine | `/architect <Task>` (or `/ship <Task>` for remaining) |
| adopt | none when the route is Done; the blocking skill + `/adopt` to resume the route on a hard stop |
| rework | `/architect <Task>` (or `/ship <Task>` for remaining) |
| research | `/model <Task>` or `/define <Task>` |
| model | `/define <Task>` (or `/implement` if PLAN exists) |
| sandbox | `/sandbox <Task>` (delta) or `/implement <Task>` (promote) |
| define | `/architect <Task>` (or `/adopt` when class is adopt; or first Chain step from Workflow binding; or `/ship`) |
| architect | `/implement <Task>` |
| implement | `/test <Task>` (then `/restructure`; or `/ship`) |
| test | `/restructure <Task>` |
| restructure / harden | `/review <Task>` |
| iterate | `/test <NewTask>` (or `/sandbox` when the delta is an inspect-loop) |
| review / review-fix (CLEAN) | `/ship <Task>` |
| review (FAILED) | `/implement` — or `/ship` to retry remaining |
| ship (Done) | Done — or `/iterate` if merged work still wrong; `/sandbox` when each turn needs inspectables |
| ship (stopped) | `/ship <Task>` or the skill that unblocks |
| summarise | *(reports Next; does not advance)* |
| guide | Resume persisted Next of in-flight Task, or none |
| explain | Resume persisted Next of in-flight Task, or none |

## Entry context

| Skill | Load |
|-------|------|
| bug | Related Task/Story if linked; codebase pointers from user |
| tweak | Related Task/Story if linked; codebase pointers from user |
| refine | Related Task/Story if linked; thin area description + codebase pointers from user |
| adopt | Tree root (repo or named subtree); `ADOPT.md` when continuing; PLAN when class is adopt; structure catalog |
| rework | Related Task/Story if linked; thin area description + parity bar pointers from user |
| iterate | Prior shipped Task + merged PR + PLAN/BUG/TWEAK/REFINE/REWORK/prior ITERATE; fork to sandbox when inspect-loop |
| research / model | Task (+ Story), ROADMAP, sibling artifacts — research is supportive |
| sandbox | Task (+ Story), PLAN/REWORK, existing `SANDBOX.md` + isolation tree — inspect-loop; post-merge: prior shipped Task |
| define | Task (+ Story), ROADMAP, RESEARCH/MODEL/SANDBOX as **supportive** — still probe the user; then classify + bind workflow |
| implement | Task + Sub-tasks, PLAN / BUG / TWEAK / REFINE / REWORK / ADOPT, `RESEARCH.md` / `MODEL.md` / `SANDBOX.md` when present (esp. docs and promote packages), **existing delivery branch/PR**, test/lint commands (rework → comparative eval) |
| test | Task + **same** delivery PR + PLAN/BUG/TWEAK/REFINE/REWORK/ITERATE/ADOPT + implement testing notes |
| harden | Task + **same** delivery PR + PLAN/BUG/TWEAK/REFINE/REWORK/ITERATE/ADOPT + structure catalog |
| review / review-fix | Task + **same** delivery PR + PLAN/BUG/TWEAK/REFINE/REWORK/ITERATE/ADOPT + `SANDBOX.md` when present |
| ship | Task + PLAN/BUG/TWEAK/REFINE/REWORK/ITERATE/ADOPT + `SANDBOX.md` when present + delivery branch/PR; detect stage |
| summarise | Task + artifacts needed for stage inference |
| help | None required — catalog overview; no Task advance |
| guide | Named task; in-flight Task artifacts only when that work is being walked; no Task advance |
| explain | Current step: in-flight Task + last agent output + named subject; no Task advance |
