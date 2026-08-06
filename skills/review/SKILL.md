---
name: review
description: >-
  Adaptive-depth GitHub PR review: full five-axis pass on larger feature work,
  focused one-or-two-worker pass on bugs, small iterates, and localized deltas.
  Axes Spec, Correctness, Integration, Architecture, Standards; scores workers
  across low/mid/high (Routine → low, Moderate → mid, Demanding → high); manager
  stays high-capability. Tied to a pipeline issue in In Review; posts findings
  on the PR and tracker; hands off to review-fix or ship.
disable-model-invocation: true
---

# Review

Applies [CONCEPT_REVIEW](../concepts/CONCEPT_REVIEW.md) as a review posted
**on the GitHub pull request** and summarised on the **pipeline issue** — not as
repo files or long chat transcripts. **Depth** is proportional: `full` or
`focused` per [depth.md](depth.md).

**On invoke:** read CONCEPT_REVIEW, [../concepts/CONCEPT_DELEGATION.md](../concepts/CONCEPT_DELEGATION.md)
(+ [../concepts/PLATFORM-CATALOGS.md](../concepts/PLATFORM-CATALOGS.md) when assigning models),
[../workflow/reference.md](../workflow/reference.md), [depth.md](depth.md),
[checklist.md](checklist.md), [axis-briefs.md](axis-briefs.md), and
[../tracker/SKILL.md](../tracker/SKILL.md).

Requires authenticated `gh` and tracker auth per WORKSPACE. If either is missing, stop.

## Extensions

| Slot | This skill |
|------|------------|
| **Change source** | GitHub PR linked to the pipeline Task (or current branch) |
| **Spec source** | Tracker issue + `PLAN.md` / `BUG.md` / `ITERATE.md` / `MODEL.md` |
| **Publish target** | GitHub PR review via `gh api` + tracker comment |
| **Checklist** | [checklist.md](checklist.md) + [axis-briefs.md](axis-briefs.md) |
| **Depth routing** | [depth.md](depth.md) — after context pack |
| **Parallelism** | `full` → five axis workers; `focused` → one Core (+ optional Integration) |
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

1. **Resolve issue** — key/URL or ask once; `fetch`; require **In Review** (else stop). Capture key, summary, sub-tasks, artifact paths.
2. **Resolve PR** — issue-linked → user-named → current branch → draft if commits exist. Confirm non-empty diff; capture number, URL, base, head SHA, diff, commits.
3. **Build investigation context** — CONCEPT_REVIEW packs: changed paths, file snapshots, neighbor map, spec/architecture/standards packs, tooling evidence. Pass into every brief.
4. **Choose depth + spawn** — pick `full` or `focused` per [depth.md](depth.md); score each worker; one message with the matching `Task` calls and `model` when supported. `full` briefs from [axis-briefs.md](axis-briefs.md); `focused` briefs from [depth.md](depth.md#focused-briefs). Empty Spec pack → skip Spec (still run other included axes); ask once if everything is empty of intent.
5. **Publish** — merge/dedupe (Architecture over Standards for same structural issue; Integration for runtime contract breaks); promote mislabeled actionable `note`s → `should-fix`; submit one PR review via `gh api` (`REQUEST_CHANGES` if any blocker/should-fix; `COMMENT` for non-actionable notes only; `APPROVE` only on zero findings). Unanchorable inlines → PR conversation with axis prefix. Never commit review JSON; never paste full review in chat.
6. **Tracker** — comment depth + counts + event + **Next**; keep Task **In Review**; upsert ISSUES. Do not mark Done.

### Review body shape

```markdown
## Summary
- Depth: full | focused (<one-line reason>)
- Blockers: <n> | Should-fix: <n> | Notes: <n>
- Vertical / Horizontal / Architecture themes: …
- Worst: <one line or "none">

## Spec / Correctness / Integration / Architecture / Standards
… (general findings or "None." / "Skipped (focused)."; severity counts)
```

Under `focused`, axes not covered → `Skipped (focused).` Architecture is skipped
unless depth was promoted to `full`.

### Tell the user

Only: issue key/URL, PR URL, depth, one-line counts + event, **Next**.

## Handoff

| Outcome | Next |
|---------|------|
| Any `blocker` / `should-fix`, or actionable `note`s | `/review-fix <KEY>` (preferred) or `/implement <KEY>` fix-forward |
| Only non-actionable `note`s or zero findings | `/ship <KEY>` |
