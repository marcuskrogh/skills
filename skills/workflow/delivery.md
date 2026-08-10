# Delivery branch continuity

One pipeline Task → **one open delivery branch and PR** from first writer through
ship. Load when creating, resolving, or pushing to a delivery head.

## Rules

1. **Name and record.** Branch name = WORKSPACE `Branch pattern` + Task key.
   Record **branch name** and **PR URL** on the Task (comment + artifact Tracker
   section + ISSUES mirror) as soon as they exist.
2. **Resolve before create.** Look up recorded branch/PR (issue comment, artifact
   Tracker section, ISSUES, `gh pr list` by head/Task key). Open delivery PR or
   branch → **checkout and reuse**. Done when the existing head is checked out,
   or confirmed absent.
3. **First writer starts.** First of research / model / define / bug / tweak / refine / rework that commits
   for the Task creates the branch (and draft PR when `Open PR by default`).
   Later skills only push to that head. Done when branch exists and is recorded.
4. **Same PR through ship.** Implement, review-fix, and ship continue on that
   head — update the PR body; do not open a parallel `…-implement-…` or
   ship-only PR.
5. **Explore** may write `ROADMAP.md` without owning a route Task’s delivery PR.
   Once a route Task has a delivery branch, further ROADMAP updates for that Task
   go on **that** branch when practical.
6. **Iterate** (post-merge only) always starts a **new** Task + branch + PR.

## Standalone entry

| Entry | Behavior |
|-------|----------|
| `/bug` | Create Task; start delivery branch when committing `BUG.md`; Next `/implement` |
| `/tweak` | Create Task; start delivery branch when committing `TWEAK.md`; Next `/implement` |
| `/refine` | Create Task; start delivery branch when committing `REFINE.md`; Next `/implement` |
| `/rework` | Create Task; start delivery branch when committing `REWORK.md`; Next `/implement` (comparative) |
| `/iterate` | New Task + branch + PR from base; Next `/review-fix` |
| `/define` with no explore Task | Create Task (+ Sub-tasks) as pipeline owner |
| `/implement` with existing PLAN / BUG / TWEAK / REFINE / REWORK | Allowed; reuse delivery head |
| Skip define on features | Only when already implementation-ready |
| Skip define for defects / tweaks / refinements / reworks | Use `/bug`, `/tweak`, `/refine`, or `/rework` instead |

## Linking

- Explore route Tasks → parent Story; record **Blocked by** on dependents.
- Bug Tasks are usually standalone; may Relates to a Story/Task.
- Tweak Tasks are usually standalone; may Relates to a Story/Task.
- Refine Tasks are usually standalone; may Relates to a Story/Task.
- Rework Tasks are usually standalone; may Relates to a Story/Task.
- Iterate Tasks Relates to the shipped prior Task.
- Define / implement / review / ship comments stay on the **same** Task.
- Comment on the parent Story at define completion and at ship (phase Done).
- Comment on the prior Task when an iterate follow-up is created.
