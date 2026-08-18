# Delivery branch continuity

One **delivery** Task → **one open delivery branch and PR** from first
**PR-opening** writer through ship. Research / model commit finding docs onto
that branch **without** opening a PR. Sandbox commits `SANDBOX.md` plus the
isolation tree the same way. Charting / explore map work follows
[charting vs delivery](#charting-vs-delivery). Load when creating, resolving,
or pushing to a delivery head.

## Rules

1. **Name and record.** Branch name = WORKSPACE `Branch pattern` + Task key.
   Record **branch name** and **PR URL** on the Task (comment + artifact Tracker
   section + ISSUES mirror) as soon as they exist.
2. **Resolve before create.** Look up recorded branch/PR (issue comment, artifact
   Tracker section, ISSUES, `gh pr list` by head/Task key). Open delivery PR or
   branch → **checkout and reuse**. Done when the existing head is checked out,
   or confirmed absent.
3. **Finding docs on the branch (research / model).** Commit `RESEARCH.md` /
   `MODEL.md` onto the delivery Task’s branch (create the branch if missing).
   **Never open a PR** from research or model. Record the branch; leave PR empty
   until a PR-opening skill runs. Done when the artifact is on the delivery head.
4. **Sandbox tree on the branch.** Commit `SANDBOX.md` and the isolation tree
   onto the delivery Task’s branch (create the branch if missing). **Never open
   a PR** from sandbox. Reuse the head when define already opened the PR.
   Post-merge: **new** branch from WORKSPACE base for the new Task. Done
   when the harness and artifact are on the delivery head.
5. **First PR-opening writer.** First of define / bug / tweak / refine / rework
   that commits for a **delivery** Task opens the draft PR when `Open PR by
   default` (reusing the branch if research/model/sandbox already started it).
   After **post-merge sandbox**, **implement** opens that PR. Later
   skills only push to that head. Done when the delivery PR exists and is recorded.
6. **Same PR through ship.** Implement, review-fix, and ship continue on that
   head — update the PR body; do not open a parallel `…-implement-…` or
   ship-only PR.
7. **Explore charts; it does not open a map-only PR.** Write `ROADMAP.md` on the
   frontier delivery Task’s branch when that head exists; otherwise persist via
   tracker / external location or a local commit **without** opening a PR. Once a
   route Task has a delivery branch, further ROADMAP updates for that Task go on
   **that** branch when practical.
8. **Iterate** (post-merge only) starts a **new** Task + branch + PR when the
   delta is a straightforward production fix. **Sandbox post-merge** starts a
   **new** Task + branch from base and **never** opens a PR.

## Charting vs delivery

| Kind | What | Branch / PR |
|------|------|-------------|
| **Delivery Task** | Will (or may) reach implement → ship — including a define-typed explore route Task that also runs research/model/sandbox, or a post-merge sandbox Task | One delivery branch; research/model add finding docs; sandbox adds a **representative** harness + `SANDBOX.md`; define (or bug/tweak/refine/rework) opens the single PR — **implement** opens it after post-merge sandbox |
| **Supportive-only route Task** | Explore-typed research/model/sandbox/task whose **Next** advances a *different* key; no implement/ship on this key | Commit finding docs or sandbox tree onto the **downstream delivery Task’s** branch (or tracker/external). **Never** open a PR for this key. Mark **Done** at handoff |
| **Explore map (Story)** | `ROADMAP.md` + Story + route tickets | Charting only — never leave an explore-only open PR |

**Invariant:** research and model produce documentation of findings on the
delivery branch for define / implement / later Next — **no separate PRs**.
Sandbox produces a harness and `SANDBOX.md` the same way. After
explore or supportive handoff, the only allowed open delivery PR for that Story
is the active define→ship head (if any).

## Standalone entry

| Entry | Behavior |
|-------|----------|
| `/bug` | Create Task; start delivery branch when committing `BUG.md`; Next `/implement` |
| `/tweak` | Create Task; start delivery branch when committing `TWEAK.md`; Next `/implement` |
| `/refine` | Create Task; start delivery branch when committing `REFINE.md`; Next `/implement` |
| `/rework` | Create Task; start delivery branch when committing `REWORK.md`; Next `/implement` (comparative) |
| `/sandbox` | Commit `SANDBOX.md` + isolation tree on delivery branch; **never** open a PR; Next `/sandbox` (delta) or `/implement` (promote). Post-merge: new Task + branch from base, Relates → prior |
| `/iterate` | New Task + branch + PR from base; Next `/review-fix`. If the delta needs inspect-each-turn, compose `/sandbox` instead |
| `/define` with no explore Task | Create Task (+ Sub-tasks) as pipeline owner |
| `/implement` with existing PLAN / BUG / TWEAK / REFINE / REWORK | Allowed; reuse delivery head |
| Skip define on features | Only when already implementation-ready |
| Skip define for defects / tweaks / refinements / reworks | Use `/bug`, `/tweak`, `/refine`, or `/rework` instead |

## Linking

- Explore route Tasks → parent Story; record **Blocked by** on dependents.
  Prefer one define-typed **delivery unit** per shared build. Research / model
  steps write finding docs onto that unit’s branch (no separate PR); sandbox
  writes the harness the same way; mark supportive-only children **Done** at
  handoff.
- Bug Tasks are usually standalone; may Relates to a Story/Task.
- Tweak Tasks are usually standalone; may Relates to a Story/Task.
- Refine Tasks are usually standalone; may Relates to a Story/Task.
- Rework Tasks are usually standalone; may Relates to a Story/Task.
- Iterate Tasks Relates to the shipped prior Task.
- Sandbox post-merge Tasks Relates to the shipped prior Task (comment the prior).
- Define / implement / review / ship comments stay on the **same** Task.
- Comment on the parent Story at define completion and at ship (phase Done).
- Comment on the prior Task when an iterate follow-up is created.
