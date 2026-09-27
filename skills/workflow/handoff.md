# Handoff protocol

Every pipeline skill **ends** on its output and outcome. The **workflow** then
writes **Next**. Skills do not choose the successor
([CONCEPT_SKILL](../concepts/CONCEPT_SKILL.md)). Load with [SKILL.md](SKILL.md)
and [pipelines.md](pipelines.md) before the user-facing reply. Also load when
resolving continuation.

## Reply close

The last section of a reply that finishes a skill is exactly:

```markdown
## Next
`/<skill> <ISSUE-KEY>` — <one-line why>
```

The heading, the slash invoke, and the em dash stay exact. Prose above the
block follows [CONCEPT_LANGUAGE](../concepts/CONCEPT_LANGUAGE.md). Nothing
follows the block.

Also write that same **Next** line into: the issue comment (or markdown
Comments section), the skill's artifact, and the ISSUES mirror when enabled.
Chat-only Next is not enough — except **guide** and **explain**, which use
chat Next only (resume in-flight or none) and do not write tracker or artifact
Next.

An open alignment turn is not a finish. That reply is the one question and
stops. It has no `## Next` block and does not start a later skill. When ship
closes the loop, the line may be `Done — <KEY>` instead of a slash invoke.
The skill name in the block comes from [pipelines.md](pipelines.md).

## Resolve Next

1. If the skill's output does not exist yet (an alignment question is open, or
   an inspect-loop inside this invocation is waiting on a verdict), persist
   **Next** as this same skill and stop. That resumes the unfinished output.
   It is not a successor.
2. Take the skill's **outcome** and the bound workflow
   ([pipelines.md](pipelines.md#which-workflow)). No binding and no route →
   **standalone** (Next none).
3. Apply the first matching **Transitions** row. `chain-first` / `chain-next`
   use the **Chains** table for that workflow.
4. **immediate** — read that skill and run it now, then resolve again.
   **cue** — persist the Next block and stop. **stop** — persist Next none.
   **immediate** is the workflow mode. The user cue **continue** still means
   one persisted **Next**.
5. A finished reply ends with the [Reply close](#reply-close) block. An open
   alignment reply does not. `/ship <KEY>` remains the continuation that
   finishes the rest of the bound chain; it is not a successor a skill writes
   for itself. When the outcome is done, the block is `Done — <KEY>`.

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
| define | Task (+ Story), ROADMAP, RESEARCH/MODEL/SANDBOX as **supportive** — still probe the user. The opening description does not approve the plan. Classify and bind only after the readiness prompt |
| implement | Task + Sub-tasks, PLAN / BUG / TWEAK / REFINE / REWORK / ADOPT, `RESEARCH.md` / `MODEL.md` / `SANDBOX.md` when present (esp. docs and promote packages), **existing delivery branch/PR**, test/lint commands (rework → comparative eval) |
| test | Task + **same** delivery PR + PLAN/BUG/TWEAK/REFINE/REWORK/ITERATE/ADOPT + implement testing notes |
| harden | Task + **same** delivery PR + PLAN/BUG/TWEAK/REFINE/REWORK/ITERATE/ADOPT + structure catalog |
| review / review-fix | Task + **same** delivery PR + PLAN/BUG/TWEAK/REFINE/REWORK/ITERATE/ADOPT + `SANDBOX.md` when present |
| ship | Task + PLAN/BUG/TWEAK/REFINE/REWORK/ITERATE/ADOPT + `SANDBOX.md` when present + delivery branch/PR; detect stage |
| summarise | Task + artifacts needed for stage inference |
| help | None required — catalog overview; no Task advance |
| guide | Named task; in-flight Task artifacts only when that work is being walked; no Task advance |
| explain | Current step: in-flight Task + last agent output + named subject; no Task advance |
