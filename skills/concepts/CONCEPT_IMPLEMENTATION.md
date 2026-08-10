# Concept: Implementation

Execute an agreed **specification** via a **manager** that plans, delegates,
evaluates, and tracks — without absorbing large implementation in the manager
thread. Uninvokable — load only when a skill's On-invoke pointer fires.

## Intent

Deliver the spec through isolated work packages so every touched area stays at
least as testable and as well covered as before. When spawning workers, also
load [CONCEPT_DELEGATION](CONCEPT_DELEGATION.md).

## Leading words

- **dev-surface** (pl. **dev-surfaces**) — development linking surface where issue keys belong (branch names, PR titles/bodies, commits that link work, tracker fields/comments, agent artifacts, handoffs, ISSUES mirrors)
- **product surface** (pl. **product surfaces**) — end-user facing shipped source and copy (UI/frontend strings, user-facing changelogs / release notes / update descriptions, in-app help, emails, other end-user text)

## Invariants

- **Spec fidelity.** Every package and evaluation cross-references the specification; deviations require plan revision or user alignment.
- **Isolated packages.** Each delegation is self-contained: objective, inputs, constraints, deliverables, branch, difficulty/model.
- **Iterative plan.** Re-evaluate after each report; revise remaining packages when findings change assumptions.
- **Branch discipline.** Resolve the skill's delivery branch before first delegation; prefer an existing open branch/PR for the Task; workers commit only there.
- **Dev-surface keys.** Issue keys live only on **dev-surfaces**. **Product surfaces** carry product language exclusively.
- **Named-gap re-delegate.** Insufficient report → re-delegate with named gaps (escalate one tier).
- **Tested delivery.** Behavioural packages include/update tests in-package (or a Testing package before verify); honor PLAN Workflow `implement.verify` when bound (`tests` / `non-regression` / `comparative`); bug fixes and behaviour-changing tweaks include regression coverage; refinements verify behaviour is unchanged (non-regression); reworks / comparative verify use baseline vs candidate evaluation before accept; injectable seams; touched-area suite stays honest and green.
- **Honor binding.** When Classification / Workflow are persisted on the spec, do not reclassify; execute to the bound params.
- **Verification mandatory.** Run real project tests/lint for the touched area (or full suite if that is the norm); report observed results only.

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

## Flow

1. **Obtain spec** — from skill source; ask if missing. Done when spec is usable.
2. **Pre-work** — skill-defined. Done when pre-work complete.
3. **Branch** — reuse open delivery branch/PR for the work item, else create. Done when branch is checked out.
4. **Draft plan** — ordered packages with acceptance (tests in behavioural packages). Done when packages cover the spec.
5. **Implementation loop** — select package → score difficulty → delegate → evaluate (incl. tests/testability) → re-delegate or mark done → revise plan. Done when all packages complete.
6. **Verify and deliver** — skill verification + delivery outcome. Done when checks pass and delivery criteria met.

## Reference

### Package brief (minimum)

Objective; inputs; constraints (incl. testability seams; **Dev-surface keys**); deliverables (code + tests or explicit justification); branch; difficulty / model.
