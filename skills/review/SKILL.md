---
name: review
description: >-
  Thorough multi-axis GitHub PR review (Spec, Correctness, Integration,
  Architecture, Standards) with vertical and horizontal investigation. Scores
  each axis across low/mid/high capability tiers (Routine → low, Moderate → mid,
  Demanding → high); manager stays high-capability. Tied to a pipeline issue in
  In Review; posts findings on the PR and tracker; hands off to review-fix or
  ship.
disable-model-invocation: true
---

# Review

Applies [CONCEPT_REVIEW](../concepts/CONCEPT_REVIEW.md) as a deep review posted
**on the GitHub pull request** and summarised on the **pipeline issue** — not as
repo files or long chat transcripts.

**On invoke:** read CONCEPT_REVIEW, [../concepts/CONCEPT_DELEGATION.md](../concepts/CONCEPT_DELEGATION.md)
(+ [../concepts/PLATFORM-CATALOGS.md](../concepts/PLATFORM-CATALOGS.md) when assigning models),
[../workflow/reference.md](../workflow/reference.md), [checklist.md](checklist.md),
[axis-briefs.md](axis-briefs.md), and [../tracker/SKILL.md](../tracker/SKILL.md).

Requires authenticated `gh` and tracker auth per WORKSPACE. If either is missing, stop.

## Extensions

| Slot | This skill |
|------|------------|
| **Change source** | GitHub PR linked to the pipeline Task (or current branch) |
| **Spec source** | Tracker issue + `PLAN.md` / `BUG.md` / `ITERATE.md` / `MODEL.md` |
| **Publish target** | GitHub PR review via `gh api` + tracker comment |
| **Checklist** | [checklist.md](checklist.md) + [axis-briefs.md](axis-briefs.md) |
| **Parallelism** | Five parallel `generalPurpose` axis workers |
| **Model routing** | CONCEPT_DELEGATION — defaults below |
| **Tooling evidence** | Run project lint/typecheck/test for touched area when cheap; feed failures to Correctness |
| **Handoff** | See [Handoff](#handoff) |

### Default worker categories

| Axis | Default | Elevate to high when |
|------|---------|----------------------|
| Spec | Mid | Large/ambiguous PLAN; conflicting acceptance |
| Correctness | Mid | Concurrency/races, security, subtle algorithms, unexplained tooling failures |
| Integration | Mid | Authz, migrations, public API/schema breaks, multi-service contracts |
| Architecture | Mid | New layers/modules, cycles, ADR conflicts, large structural shift |
| Standards | Low | Almost never — climb via mid only after a failed lower pass |

## Steps

1. **Resolve issue** — key/URL or ask once; `fetch`; require **In Review** (else stop). Capture key, summary, sub-tasks, artifact paths.
2. **Resolve PR** — issue-linked → user-named → current branch → draft if commits exist. Confirm non-empty diff; capture number, URL, base, head SHA, diff, commits.
3. **Build investigation context** — CONCEPT_REVIEW packs: changed paths, file snapshots, neighbor map, spec/architecture/standards packs, tooling evidence. Pass into every brief.
4. **Score + spawn** — difficulty per axis; one message, five `Task` calls with `model` when supported. Briefs from [axis-briefs.md](axis-briefs.md). Empty spec pack → skip Spec, still run the other four; ask once if everything is empty of intent.
5. **Publish** — merge/dedupe (Architecture over Standards for same structural issue; Integration for runtime contract breaks); promote mislabeled actionable `note`s → `should-fix`; submit one PR review via `gh api` (`REQUEST_CHANGES` if any blocker/should-fix; `COMMENT` for non-actionable notes only; `APPROVE` only on zero findings). Unanchorable inlines → PR conversation with axis prefix. Never commit review JSON; never paste full review in chat.
6. **Tracker** — comment counts + event + **Next**; keep Task **In Review**; upsert ISSUES. Do not mark Done.

### Review body shape

```markdown
## Summary
- Blockers: <n> | Should-fix: <n> | Notes: <n>
- Vertical / Horizontal / Architecture themes: …
- Worst: <one line or "none">

## Spec / Correctness / Integration / Architecture / Standards
… (general findings or "None."; severity counts)
```

### Tell the user

Only: issue key/URL, PR URL, one-line counts + event, **Next**.

## Handoff

| Outcome | Next |
|---------|------|
| Any `blocker` / `should-fix`, or actionable `note`s | `/review-fix <KEY>` (preferred) or `/implement <KEY>` fix-forward |
| Only non-actionable `note`s or zero findings | `/ship <KEY>` |
