# Concept: Review

Evaluate a change set against an agreed specification and the surrounding system
on **multiple axes**, both **vertically** and **horizontally**, producing
actionable findings with evidence. Shipping-phase review runs as **lasers**
and ends in a published **code review**. Uninvokable — load only when a skill's
On-invoke pointer fires.

## Intent

Produce findings that are evidenced on the change (or immediate neighbor), name
a concrete fix, and fit this PR's blast radius. Choose proportional **depth**
and **laser** mode before spawn. Toward closeout, prefer accurate severity over
a soft review. When spawning axis workers, also load
[CONCEPT_DELEGATION](CONCEPT_DELEGATION.md). Structure bar:
[CONCEPT_STRUCTURE](CONCEPT_STRUCTURE.md).

## Leading words

- **axis** — Spec / Correctness / Integration / Architecture / Standards
- **vertical** — deep within a changed path
- **horizontal** — across related code and contracts
- **actionable** — evidenced on the change (or immediate neighbor), names a concrete fix, fits this PR's blast radius
- **laser** — sequential pass over one axis (or a small bundle); under `/review-fix`, fix must-fix findings before the next laser
- **code review** — last published pull-request review after lasers; the closeout gate

## Invariants

- **Proportional depth.** Choose depth before spawn from work-package shape and change size. `full` when the package warrants all-axis coverage; `focused` for bugs, tweaks, refinements, reworks, small iterates, and localized deltas. Record the choice. Both vertical and horizontal still apply on every included axis.
- **Laser then code review.** Honor bound `review.lasers`. `sequential` runs one included axis at a time; `bundled` runs the focused or full worker map together. Either way, **code review** is the last published pass — not an optional extra.
- **Closeout rigor.** On Architecture and Standards lasers, catalog breaches and named smells in **changed** code are `should-fix` (or `blocker` when ship-critical). Do not demote them to `note` because a harden pass already ran, or because the diff is small.
- **Investigation context before axis work** — changed paths, file snapshots, neighbor map, spec pack, architecture pack, standards pack, tooling evidence when cheap.
- **Fix-biased severity.** Prefer `should-fix` over `note` when **actionable**.
- **Publish to the durable surface** (PR review, etc.); summarise counts to the user when a publish target exists. Under `/review-fix`, per-laser findings may stay in worker reports until **code review** publishes the merged set (plus any residue after fix-forward).
- **Manager merges** findings, promotes severity, publishes **code review**, and owns tracker handoff — workers value-routed per CONCEPT_DELEGATION.

## Extensions

| Slot | Required | Purpose |
|------|----------|---------|
| **Change source** | must | How to obtain the diff / commits |
| **Spec source** | must | Where acceptance lives |
| **Publish target** | must | Where findings are posted |
| **Checklist** | must | Axis checklists for investigator briefs |
| **Depth routing** | may | Signals → `full` \| `focused`; focused worker bundling |
| **Laser routing** | may | `bundled` \| `sequential`; order and which axes |
| **Parallelism** | may | Sub-agent mapping for each depth |
| **Model routing** | may | Per-worker defaults (value-biased) |
| **Severity model** | may | Overrides to the fix-biased default |
| **Tooling evidence** | may | Whether to run lint/type/test into briefs |
| **Handoff** | may | Next when blocking vs clean |

## Flow

1. Resolve subject + readiness. Done when reviewable.
2. Resolve change set. Done when non-empty diff confirmed.
3. Build investigation context. Done when packs are ready for briefs.
4. Choose **depth** and **laser** mode → score difficulty per worker → assign models. Done when depth, laser mode, and each worker tier/model are recorded.
5. Run **lasers** for that mode (sequential by axis, or bundled workers). Done when all included axis reports return.
6. When the applying skill fix-forwards, address must-fix findings after each laser (or after the bundle) before the next. Done when remaining lasers are unblocked or a hard stop is named.
7. **Code review** — manager merges, dedupes, publishes one pull-request review. Done when the durable review contains every retained finding.
8. Hand off: fix loop if blocking/actionable remain after code review; ship path only when clean (or findings-only with non-actionable notes only).

## Reference

### Axes

| Axis | Focus |
|------|--------|
| **Spec** | Fulfills agreed behaviour — nothing missing or wrong |
| **Correctness** | Works under real inputs/failures — logic, edges, races, tests |
| **Integration** | Fits the system — callers, contracts, auth, data flow, config |
| **Architecture** | Structure — [CONCEPT_STRUCTURE](CONCEPT_STRUCTURE.md); layers, boundaries, coupling, dependency direction, concrete refactorings |
| **Standards** | Repo conventions + structure-catalog smells in changed hunks (repo docs win) |

Architecture findings stay grounded in the change and nearby structure — concrete
refactorings with evidence. Architecture and Standards both apply the structure
catalog; Architecture owns module/layer/dependency shape, Standards owns local
smells and naming.

### Severity

| Level | Meaning | Fix-loop impact |
|-------|---------|-----------------|
| `blocker` | Wrong/missing required behaviour, likely prod bug, security hole, hard ADR/layering breach, broken tooling proof | Must fix; always blocking |
| `should-fix` | Clear defect/gap that should not ship — including structural problems this PR introduced/worsened with a concrete in-PR refactoring | Blocking for fix loops; `REQUEST_CHANGES` |
| `note` | Optional polish, preference without defect, out-of-scope follow-up, speculative cleanup outside blast radius | Soft for plain `/review`; still must-fix when actionable under `/review-fix` |

Default actionable → `should-fix` (or `blocker` if ship-critical).

### Finding shape

Axis; severity; inline vs general; path/line when inline; vertical or horizontal;
body: problem → evidence → suggested fix. Cap volume per axis; when the cap binds,
drop weakest evidence first while preserving earned severity. Bundled workers still
tag each finding with its **axis**.
