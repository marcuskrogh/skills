---
name: review
description: >-
  Review of a GitHub PR as sequential or bundled lasers across Spec,
  Correctness, Integration, Architecture, and Standards: find, fix, then
  publish a code review. Hands off to ship when CLEAN. Use when the bound
  chain's review phase is next. Alias: /review-fix.
disable-model-invocation: true
---

# Review

Applies [CONCEPT_REVIEW](../concepts/CONCEPT_REVIEW.md) as **lasers**,
**fix-forward**, and a published **code review** on the GitHub pull request.
**Depth** is proportional: `full` or `focused` per [depth.md](depth.md).
**Laser** mode is `sequential` or `bundled` per [lasers.md](lasers.md).

**On invoke:** read [CONCEPT_REVIEW](../concepts/CONCEPT_REVIEW.md),
[CONCEPT_STRUCTURE](../concepts/CONCEPT_STRUCTURE.md),
[CONCEPT_IMPLEMENTATION](../concepts/CONCEPT_IMPLEMENTATION.md),
[../implement/SKILL.md](../implement/SKILL.md) (fix-forward),
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
| **Spec source** | Tracker issue + `PLAN.md` (incl. Classification/Workflow) / `BUG.md` / `TWEAK.md` / `REFINE.md` / `REWORK.md` / `ITERATE.md` / `ADOPT.md` / `MODEL.md` / `ARCHITECTURE.md` |
| **Publish target** | GitHub PR review via `gh api` + tracker comment |
| **Checklist** | [checklist.md](checklist.md) + [axis-briefs.md](axis-briefs.md) |
| **Depth routing** | Bound `review.depth` / `review.mode` from PLAN Workflow when present; else [depth.md](depth.md) |
| **Laser routing** | Bound `review.lasers` from PLAN Workflow when present; else [lasers.md](lasers.md) |
| **Parallelism** | `sequential` → one axis worker at a time; `bundled` + `multiagent` / `full` → five axis workers; `bundled` + `single` / `focused` → Core + Architecture (+ optional Integration) |
| **Model routing** | CONCEPT_DELEGATION — defaults below / in depth.md |
| **Tooling evidence** | Run project lint/typecheck/test for touched area when cheap; feed failures to Correctness |
| **Handoff** | CLEAN → `/ship`; FAILED → named remaining work |

### Default worker categories (`full`)

| Axis | Default | Elevate to high when |
|------|---------|----------------------|
| Spec | Mid | Large/ambiguous PLAN; conflicting acceptance |
| Correctness | Mid | Concurrency/races, security, subtle algorithms, unexplained tooling failures |
| Integration | Mid | Authz, migrations, public API/schema breaks, multi-service contracts |
| Architecture | Mid | New layers/modules, cycles, ADR conflicts, large structural shift |
| Standards | Mid | Almost never stay Low — climb after a failed lower pass; named smells on small diffs still Mid |

Focused defaults: [depth.md](depth.md#model-defaults-focused).

## Steps

Follow the CONCEPT_REVIEW flow with these specialisations:

1. **Resolve issue and PR** — Resolve the key, fetch the **In Review** Task, and use delivery continuity to locate its PR. Capture number, URL, base, head SHA, commits, and a non-empty diff. Done when one reviewable Task/PR pair is identified or a readiness stop is reported.
2. **Build context and choose depth** — Prepare the concept's investigation packs (include `ARCHITECTURE.md` when present); choose depth/mode from PLAN **Workflow** binding when present, else via [depth.md](depth.md); choose laser mode via [lasers.md](lasers.md); score each included worker. `review.mode=findings-only` only when the operator explicitly asked. Done when every brief has the relevant packs and a recorded tier/model.
3. **Lasers and fix** — Follow [lasers.md](lasers.md). After each sequential laser (or after the bundle), fix **actionable** findings via [implement](../implement/SKILL.md) fix-forward inside the **expansion bound**. Re-run the touched-area suite (on `ADOPT.md`: lock suite **and** working-surface commands). Skip Spec only when its pack is empty. Dedupe with Architecture owning structural overlap and Integration owning runtime contract breaks. Done when included lasers are complete and must-fix are addressed, or a named hard stop remains.
4. **Code review** — Manager merge + publish: **APPROVE** when no must-fix remain. If residue remains, one more fix-forward, then APPROVE. Put a short found/fixed/discarded summary in the review body. Done when the durable PR review exists and must-fix are addressed (**CLEAN**) or unresolved findings are named (**FAILED**).
5. **Track and hand off** — Keep the Task **In Review**, persist **Next**. Done when Task, PR, mirror, and user report agree on CLEAN/FAILED and its Handoff.

### Must-fix

- `blocker` or `should-fix`
- Named structure-catalog smells and catalog breaches in **changed** code
- Actionable findings (evidence + concrete fix + inside expansion bound)

Discard the rest. Do not leave notes on CLEAN. Do not open follow-up issues.

### Review body shape

```markdown
## Summary
- Depth: full | focused; lasers: sequential | bundled (<one-line reason>)
- Found / fixed / discarded: <n> / <n> / <n>
- Vertical / Horizontal / Architecture themes: …
- Worst: <one line or "none">

## Spec / Correctness / Integration / Architecture / Standards
… (fixed findings or "None." / "Skipped (focused).")
```

### Tell the user

Issue key/URL, PR URL, depth, laser mode, found/fixed/discarded counts, CLEAN/FAILED, **Next**.

## Handoff

| Exit | Condition | Next |
|------|-----------|------|
| **CLEAN** | Code review has no must-fix | `/ship <KEY>` |
| **FAILED** | Fix-forward could not address must-fix inside the expansion bound | Report remaining; `/implement <KEY>` |

```markdown
## Next
`/ship <TASK-KEY>` — Merge and close out
```
