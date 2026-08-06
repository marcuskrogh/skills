# Concept: Review

Evaluate a change set against an agreed specification and the surrounding system
on **multiple axes**, both **vertically** and **horizontally**, producing
actionable findings with evidence. Uninvokable — load only when a skill's
On-invoke pointer fires.

## Intent

Produce findings that are evidenced on the change (or immediate neighbor), name
a concrete fix, and fit this PR's blast radius. Choose proportional **depth**
before spawn. When spawning axis workers, also load
[CONCEPT_DELEGATION](CONCEPT_DELEGATION.md).

## Leading words

- **axis** — Spec / Correctness / Integration / Architecture / Standards
- **vertical** — deep within a changed path
- **horizontal** — across related code and contracts
- **actionable** — evidenced on the change (or immediate neighbor), names a concrete fix, fits this PR's blast radius

## Invariants

- **Proportional depth.** Choose depth before spawn from work-package shape and change size. `full` when the package warrants all-axis coverage; `focused` for bugs, small iterates, and localized deltas. Record the choice. Both vertical and horizontal still apply on every included axis.
- **Investigation context before axis work** — changed paths, file snapshots, neighbor map, spec pack, architecture pack, standards pack, tooling evidence when cheap.
- **Fix-biased severity.** Prefer `should-fix` over `note` when **actionable**.
- **Publish to the durable surface** (PR review, etc.); summarise counts to the user when a publish target exists.
- **Manager merges** findings, promotes severity, publishes, and owns tracker handoff — workers value-routed per CONCEPT_DELEGATION.

## Extensions

| Slot | Required | Purpose |
|------|----------|---------|
| **Change source** | must | How to obtain the diff / commits |
| **Spec source** | must | Where acceptance lives |
| **Publish target** | must | Where findings are posted |
| **Checklist** | must | Axis checklists for investigator briefs |
| **Depth routing** | may | Signals → `full` \| `focused`; focused worker bundling |
| **Parallelism** | may | Sub-agent mapping for each depth |
| **Model routing** | may | Per-worker defaults (value-biased) |
| **Severity model** | may | Overrides to the fix-biased default |
| **Tooling evidence** | may | Whether to run lint/type/test into briefs |
| **Handoff** | may | Next when blocking vs clean |

## Flow

1. Resolve subject + readiness. Done when reviewable.
2. Resolve change set. Done when non-empty diff confirmed.
3. Build investigation context. Done when packs are ready for briefs.
4. Choose **depth** → score difficulty per worker → assign models. Done when depth and each worker tier/model are recorded.
5. Run workers for that depth (prefer parallel when more than one). Done when all worker reports return.
6. Merge, dedupe, keep axes separate in publish. Done when review is published.
7. Hand off: fix loop if blocking/actionable remain; ship path only when clean (or plain `/review` with non-actionable notes only).

## Reference

### Axes

| Axis | Focus |
|------|--------|
| **Spec** | Fulfills agreed behaviour — nothing missing or wrong |
| **Correctness** | Works under real inputs/failures — logic, edges, races, tests |
| **Integration** | Fits the system — callers, contracts, auth, data flow, config |
| **Architecture** | Structure — layers, boundaries, coupling, dependency direction, concrete refactorings |
| **Standards** | Repo conventions + smell baseline (repo docs win) |

Architecture findings stay grounded in the change and nearby structure — concrete
refactorings with evidence.

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
