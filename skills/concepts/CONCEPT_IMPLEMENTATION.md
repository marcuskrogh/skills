# Concept: Implementation

Execute an agreed **specification** via a **manager** that plans, delegates,
evaluates, and tracks — without absorbing large implementation in the manager
thread. Uninvokable — load only when a skill's On-invoke pointer fires.

## Intent

Deliver the spec through isolated work packages so every touched area stays at
least as testable, as well covered, and as well structured as before. When
spawning workers, also load [CONCEPT_DELEGATION](CONCEPT_DELEGATION.md).
Structure bar: [CONCEPT_STRUCTURE](CONCEPT_STRUCTURE.md).

## Leading words

- **dev-surface** (pl. **dev-surfaces**) — development linking surface where issue keys belong (branch names, PR titles/bodies, commits that link work, tracker fields/comments, agent artifacts, handoffs, ISSUES mirrors)
- **product surface** (pl. **product surfaces**) — end-user facing shipped source and copy (UI/frontend strings, user-facing changelogs / release notes / update descriptions, in-app help, emails, other end-user text)
- **working surface** — startable backend, startable frontend, or composed client-server path the change can break
- **spec lock** — automated check written from a **pass criteria** row (definition
  artifact; legacy Acceptance rows count). Fails if that row is unmet. A test of
  a helper the agent invented does not lock the spec.

## Invariants

- **Spec fidelity.** Every package and evaluation cross-references the specification; deviations require plan revision or user alignment.
- **Isolated packages.** Each delegation is a self-contained *brief*
  (objective, inputs, constraints, deliverables, branch, difficulty/model).
  Packages share the manager's working directory — a second Git worktree is not
  the isolation.
- **Iterative plan.** Re-evaluate after each report; revise remaining packages when findings change assumptions.
- **Branch discipline.** Resolve the skill's delivery branch before first
  delegation; prefer an existing open branch/PR for the Task; check it out in
  this session's working directory; workers commit only there.
- **Dev-surface keys.** Issue keys live only on **dev-surfaces**. **Product surfaces** carry product language exclusively.
- **Named-gap re-delegate.** Insufficient report → re-delegate with named gaps (escalate one tier).
- **Spec lock.** Each pass-criteria row has a spec lock before the package is
  done. Write the check from the row, not from the implementation. Bugs and
  behaviour-changing tweaks fail-first (the lock is red, then the fix makes it
  green). Docs-only: `none — no executable behaviour`. `/test` audits the
  mapping; in-package spec locks do not replace that pass.
- **Tested delivery.** Behavioural packages include/update tests in-package (or a Testing package before verify); honor PLAN Workflow `implement.verify` when bound (`tests` / `non-regression` / `comparative`); bug fixes and behaviour-changing tweaks include regression coverage; refinements verify behaviour is unchanged (non-regression); adopt characterizes current behaviour into lock tests before structure packages, including every **working surface** the area owns, then those tests are the non-regression bar; reworks / comparative verify use baseline vs candidate evaluation before accept; injectable seams; touched-area suite stays honest and green. In-package tests do not replace the bound **testing phase** (`/test`). Change size does not relax coverage, seams, or spec locks.
- **Structured delivery.** Packages meet [CONCEPT_STRUCTURE](CONCEPT_STRUCTURE.md) as-you-go. Named smells and catalog breaches in changed code fail the package — re-delegate. Do not defer them to harden or review. In-package structure does not replace the bound **harden** phase. Change size does not relax the catalog.
- **Honor binding.** When Classification / Workflow are persisted on the spec, do not reclassify; execute to the bound params. Do not skip `/test` or `/restructure` (`/harden`) unless the binding's skip rows apply.
- **Closeout-aware.** Implement writes for the bound chain: honest seams for `/test`, catalog-clean units for `/restructure`, nothing left as "review will catch it." Before leaving implement, the manager gates the **whole** diff against the testing and structure checklists. Honor `ARCHITECTURE.md` when present.
- **Verification mandatory.** Run real project tests/lint for the touched area (or full suite if that is the norm); report observed results only. When the change can break a **working surface**, those commands run too: backend start and contract, frontend build/serve and mapped flows, composed client-server path when both exist. A unit suite alone does not prove a startable surface.

## Extensions

| Slot | Required | Purpose |
|------|----------|---------|
| **Spec source** | must | How the manager obtains the spec |
| **Branch naming** | must | Feature branch pattern |
| **Delivery** | must | PR vs branch-only vs other completion |
| **Verification** | must | Final checks — tests, lint, non-degradation, spec checklist |
| **Pre-work** | may | Steps before first delegation |
| **Work package types** | may | Domain package categories |
| **Subagent mapping** | may | Subagent type per package kind |
| **Model routing** | may | Defaults for CONCEPT_DELEGATION (still value-biased) |
| **PR template** | may | Required PR body sections |
| **Testing checklist** | may | Concrete checks for package briefs |
| **Structure checklist** | may | Concrete structure checks for package briefs |
| **Closeout gate** | may | Whole-diff testing + structure walk before handing off to `/test` |

## Flow

1. **Obtain spec** — from skill source; ask if missing. Done when spec is usable.
2. **Pre-work** — skill-defined. Done when pre-work complete.
3. **Branch** — reuse open delivery branch/PR for the work item, else create.
   Done when that branch is checked out in this session's working directory.
4. **Draft plan** — ordered packages with a spec lock per pass-criteria row. Done when packages cover the spec.
5. **Implementation loop** — select package → score difficulty → delegate → evaluate (tests, testability, and structure catalog) → re-delegate or mark done → revise plan. Done when all packages complete.
6. **Closeout gate** — walk the whole diff against the testing and structure checklists. Done when every remaining gap is a re-delegation or a documented exception.
7. **Verify and deliver** — skill verification + delivery outcome. Done when checks pass, the gate holds, and delivery criteria met.

## Reference

### Package brief (minimum)

Objective; inputs (incl. pass-criteria rows); constraints (incl. testability seams, structure catalog, **Dev-surface keys**); deliverables (code + spec locks or explicit justification; structure notes); branch; difficulty / model.
