---
name: review
description: >-
  Review of a GitHub PR as sequential or bundled lasers across Spec,
  Correctness, Integration, Architecture, and Standards, ending in a published
  code review. Publishes findings on the PR and pipeline Task, then hands off
  to review-fix or ship.
disable-model-invocation: true
---

# Review

Applies [CONCEPT_REVIEW](../concepts/CONCEPT_REVIEW.md) as **lasers** plus a
published **code review** **on the GitHub pull request**, summarised on the
**pipeline issue**. **Depth** is proportional: `full` or `focused` per
[depth.md](depth.md). **Laser** mode is `sequential` or `bundled` per
[lasers.md](lasers.md).

**On invoke:** read [CONCEPT_REVIEW](../concepts/CONCEPT_REVIEW.md),
[CONCEPT_STRUCTURE](../concepts/CONCEPT_STRUCTURE.md),
[../workflow/reference.md](../workflow/reference.md),
[../workflow/delivery.md](../workflow/delivery.md),
[../workflow/tracker-sync.md](../workflow/tracker-sync.md),
[../workflow/handoff.md](../workflow/handoff.md), [depth.md](depth.md),
[lasers.md](lasers.md), [checklist.md](checklist.md), [axis-briefs.md](axis-briefs.md), and
[../tracker/SKILL.md](../tracker/SKILL.md). Before spawning workers, also read
[CONCEPT_DELEGATION](../concepts/CONCEPT_DELEGATION.md) and its platform catalog
as directed there.

Requires authenticated `gh` and tracker auth per WORKSPACE. If either is missing, stop.

## Extensions

| Slot | This skill |
|------|------------|
| **Change source** | GitHub PR linked to the pipeline Task (or current branch) |
| **Spec source** | Tracker issue + `PLAN.md` (incl. Classification/Workflow) / `BUG.md` / `TWEAK.md` / `REFINE.md` / `REWORK.md` / `ITERATE.md` / `MODEL.md` |
| **Publish target** | GitHub PR review via `gh api` + tracker comment |
| **Checklist** | [checklist.md](checklist.md) + [axis-briefs.md](axis-briefs.md) |
| **Depth routing** | Bound `review.depth` / `review.mode` from PLAN Workflow when present; else [depth.md](depth.md) |
| **Laser routing** | Bound `review.lasers` from PLAN Workflow when present; else [lasers.md](lasers.md) |
| **Parallelism** | `sequential` → one axis worker at a time; `bundled` + `multiagent` / `full` → five axis workers; `bundled` + `single` / `focused` → one Core (+ optional Integration, + Architecture when harden/refine) |
| **Model routing** | CONCEPT_DELEGATION — defaults below / in depth.md |
| **Tooling evidence** | Run project lint/typecheck/test for touched area when cheap; feed failures to Correctness |
| **Handoff** | See [Handoff](#handoff) |

### Default worker categories (`full`)

| Axis | Default | Elevate to high when |
|------|---------|----------------------|
| Spec | Mid | Large/ambiguous PLAN; conflicting acceptance |
| Correctness | Mid | Concurrency/races, security, subtle algorithms, unexplained tooling failures |
| Integration | Mid | Authz, migrations, public API/schema breaks, multi-service contracts |
| Architecture | Mid | New layers/modules, cycles, ADR conflicts, large structural shift |
| Standards | Low | Almost never — climb via mid only after a failed lower pass |

Focused defaults: [depth.md](depth.md#model-defaults-focused).

## Steps

Follow the CONCEPT_REVIEW flow with these specialisations:

1. **Resolve issue and PR** — Resolve the key, fetch the **In Review** Task, and use delivery continuity to locate its PR. Capture number, URL, base, head SHA, commits, and a non-empty diff. Done when one reviewable Task/PR pair is identified or a readiness stop is reported.
2. **Build context and choose depth** — Prepare the concept's investigation packs; choose depth/mode from PLAN **Workflow** binding when present, else via [depth.md](depth.md); choose laser mode via [lasers.md](lasers.md); score each included worker. Done when every brief has the relevant packs and a recorded tier/model.
3. **Run lasers** — Follow [lasers.md](lasers.md). Findings-only: no fix-forward between lasers. Skip Spec only when its pack is empty, and ask once when all intent is absent. Dedupe with Architecture owning structural overlap and Integration owning runtime contract breaks. Done when all included laser reports are evaluated and one severity-normalized finding set remains.
4. **Code review** — Submit one PR review via `gh api`: `REQUEST_CHANGES` for blocker/should-fix, `COMMENT` for non-actionable notes only, or `APPROVE` for zero findings. Put unanchorable findings in the PR conversation with an axis prefix. Done when the durable PR review contains every retained finding and no review JSON is committed.
5. **Track and hand off** — Apply the review tracker row with depth, counts, event, and **Next** while keeping the Task **In Review**. Done when Task, enabled mirror, and user summary agree on the review outcome and Handoff.

### Review body shape

```markdown
## Summary
- Depth: full | focused; lasers: sequential | bundled (<one-line reason>)
- Blockers: <n> | Should-fix: <n> | Notes: <n>
- Vertical / Horizontal / Architecture themes: …
- Worst: <one line or "none">

## Spec / Correctness / Integration / Architecture / Standards
… (general findings or "None." / "Skipped (focused)."; severity counts)
```

Under `focused` + `bundled`, axes not covered → `Skipped (focused).` Architecture
is skipped unless depth was promoted to `full`, `harden.mode=dedicated`, or class
is refine.

### Tell the user

Only: issue key/URL, PR URL, depth, laser mode, one-line counts + event, **Next**.

## Handoff

| Outcome | Next |
|---------|------|
| Any `blocker` / `should-fix`, or actionable `note`s | `/review-fix <KEY>` (preferred) or `/implement <KEY>` fix-forward |
| Only non-actionable `note`s or zero findings | `/ship <KEY>` |
