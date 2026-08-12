# Delivery branch continuity

One **delivery** Task → **one open delivery branch and PR** from first writer
through ship. Charting / supportive-only explore work follows
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
3. **First writer starts.** First of research / model / define / bug / tweak / refine / rework that commits
   for a **delivery** Task creates the branch (and draft PR when `Open PR by default`).
   Later skills only push to that head. Done when branch exists and is recorded.
4. **Same PR through ship.** Implement, review-fix, and ship continue on that
   head — update the PR body; do not open a parallel `…-implement-…` or
   ship-only PR.
5. **Explore charts; it does not open a map-only PR.** Write `ROADMAP.md` on the
   frontier delivery Task’s branch when that head exists; otherwise persist via
   tracker / external location or a local commit **without** opening a PR. Once a
   route Task has a delivery branch, further ROADMAP updates for that Task go on
   **that** branch when practical.
6. **Iterate** (post-merge only) always starts a **new** Task + branch + PR.

## Charting vs delivery

| Kind | What | Branch / PR |
|------|------|-------------|
| **Delivery Task** | Will (or may) reach implement → ship on this key — including a define-typed explore route Task that also runs research/model | One open delivery branch/PR from first writer through ship |
| **Supportive-only route Task** | Explore-typed research/model/task whose **Next** advances a *different* key; no implement/ship on this key | Prefer no PR: push artifact into the tracker (external) or commit onto the **downstream delivery Task’s** head when known. If a PR was opened, at handoff fold durable content onto tracker or downstream head, **close the PR without merge**, delete the head when allowed, mark this Task **Done** |
| **Explore map (Story)** | `ROADMAP.md` + Story + route tickets | Charting only — never leave an explore-only open PR |

**Invariant:** after explore handoff or a supportive skill’s handoff, the only
allowed open delivery PR for that Story is the active define→ship head (if any).

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
  Prefer one define-typed **delivery unit** per shared build; supportive-only
  children leave no hanging PR and go **Done** at their skill handoff.
- Bug Tasks are usually standalone; may Relates to a Story/Task.
- Tweak Tasks are usually standalone; may Relates to a Story/Task.
- Refine Tasks are usually standalone; may Relates to a Story/Task.
- Rework Tasks are usually standalone; may Relates to a Story/Task.
- Iterate Tasks Relates to the shipped prior Task.
- Define / implement / review / ship comments stay on the **same** Task.
- Comment on the parent Story at define completion and at ship (phase Done).
- Comment on the prior Task when an iterate follow-up is created.
