# Concept: Review

Evaluate a change set against an agreed specification and the surrounding system
on **multiple axes**, both **vertically** and **horizontally**. Shipping-phase
review **finds and fixes** autonomously, then publishes a **code review**.
Uninvokable — load only when a skill's On-invoke pointer fires.

## Intent

Check every guiding principle (easy when earlier steps held) **and** run the
larger analysis (spec, system fit, contracts, module/system architecture).
Actionable findings are fixed on this pull request. Choose proportional
**depth** and **laser** mode before spawn. When spawning axis workers, also
load [CONCEPT_DELEGATION](CONCEPT_DELEGATION.md). Structure bar:
[CONCEPT_STRUCTURE](CONCEPT_STRUCTURE.md).

## Leading words

- **axis** — Spec / Correctness / Integration / Architecture / Standards
- **vertical** — deep within a changed path
- **horizontal** — across related code and contracts
- **actionable** — evidenced on the change (or immediate neighbor), names a concrete fix, fits this PR's blast radius
- **laser** — sequential pass over one axis (or a small bundle); fix must-fix findings before the next laser
- **code review** — last published pull-request review after lasers and fixes; the closeout gate
- **expansion bound** — the finding’s unit, its tests, and any caller or contract the fix breaks

## Invariants

- **Always fix.** `/review` reviews and fixes. `/review-fix` is an alias.
  Findings-only runs only when the operator explicitly sets
  `review.mode=findings-only`. Default closeout is autonomous.
- **Evaluate every principle.** Campground, catalog, tests, and architecture
  still get a pass. If earlier steps held, the pass is short. Also run the
  larger analysis.
- **Proportional depth.** Choose depth before spawn from work-package shape and change size. `full` when the package warrants all-axis coverage; `focused` for bugs, tweaks, refinements, reworks, small iterates, and localized deltas. Record the choice. Both vertical and horizontal still apply on every included axis.
- **Laser then fix then code review.** Honor bound `review.lasers`. `sequential` runs one included axis at a time and fixes before the next; `bundled` runs the focused or full worker map together, then one fix pass. **Code review** is last — publish **APPROVE** after fixes. Intermediate `REQUEST_CHANGES` is not a human inbox.
- **Closeout rigor.** On Architecture and Standards lasers, catalog breaches and named smells in **changed** code are `should-fix` (or `blocker` when ship-critical). Do not demote them because a restructure pass already ran, or because the diff is small.
- **No leftover notes or tickets.** Actionable → fix on this PR inside the
  **expansion bound**. Not actionable (pre-existing mess this PR did not worsen,
  out of spec, outside the bound) → discard; do not publish as a leftover; do
  not open a follow-up issue. Ask the operator only on a true shape/product
  divergence that architect already missed — rare.
- **Investigation context before axis work** — changed paths, file snapshots, neighbor map, spec pack, architecture pack (`ARCHITECTURE.md` when present), standards pack, tooling evidence when cheap.
- **Fix-biased severity.** Prefer `should-fix` over discard when **actionable**.
  `blocker` / `should-fix` order the work; they are not a human queue.
- **Publish to the durable surface** (PR review, etc.); tell the operator what
  was found, fixed, and discarded (short, named). Per-laser findings may stay
  in worker reports until **code review** publishes the merged set after fixes.
- **Manager merges** findings, promotes severity, runs fix-forward, publishes
  **code review**, and owns tracker handoff — workers value-routed per
  CONCEPT_DELEGATION.

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
| **Handoff** | may | Next when CLEAN vs FAILED |

## Flow

1. Resolve subject + readiness. Done when reviewable.
2. Resolve change set. Done when non-empty diff confirmed.
3. Build investigation context. Done when packs are ready for briefs.
4. Choose **depth** and **laser** mode → score difficulty per worker → assign models. Done when depth, laser mode, and each worker tier/model are recorded.
5. Run **lasers** for that mode (sequential by axis, or bundled workers). Done when all included axis reports return.
6. Fix must-fix findings after each laser (or after the bundle) inside the **expansion bound**; re-run touched-area suite. Done when remaining lasers are unblocked or a hard stop is named.
7. **Code review** — manager merges, dedupes, publishes one pull-request review (**APPROVE** when no must-fix remain). Done when the durable review records the closed loop.
8. Hand off: `/ship` when CLEAN; FAILED only when a must-fix could not be done inside the expansion bound after the cap of fix cycles.

## Reference

### Axes

| Axis | Focus |
|------|--------|
| **Spec** | Fulfills agreed behaviour — nothing missing or wrong |
| **Correctness** | Works under real inputs/failures — logic, edges, races; tests as principle check, not a second `/test` project |
| **Integration** | Fits the system — callers, contracts, auth, data flow, config |
| **Architecture** | Structure — [CONCEPT_STRUCTURE](CONCEPT_STRUCTURE.md) and `ARCHITECTURE.md`; layers, boundaries, coupling, dependency direction, neighbourhood refinements |
| **Standards** | Repo conventions + structure-catalog smells in changed hunks (repo docs win) |

Architecture findings stay grounded in the change and nearby structure — concrete
refactorings with evidence. Architecture and Standards both apply the structure
catalog; Architecture owns module/layer/dependency shape, Standards owns local
smells and naming.

### Severity

| Level | Meaning | Fix-loop impact |
|-------|---------|-----------------|
| `blocker` | Wrong/missing required behaviour, likely prod bug, security hole, hard ADR/layering breach, broken tooling proof | Must fix first |
| `should-fix` | Clear defect/gap that should not ship — including structural problems this PR introduced/worsened with a concrete in-PR refactoring | Must fix |
| (discard) | Not actionable: outside expansion bound, pre-existing and not worsened, taste, out of spec | Do not record as a leftover note |

Default actionable → `should-fix` (or `blocker` if ship-critical).

### Finding shape

Axis; severity; inline vs general; path/line when inline; vertical or horizontal;
body: problem → evidence → suggested fix. Cap volume per axis; when the cap binds,
drop weakest evidence first while preserving earned severity. Bundled workers still
tag each finding with its **axis**.
