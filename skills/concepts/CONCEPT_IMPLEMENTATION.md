# Concept: Implementation

Execute an agreed **specification** via a **manager** that plans, delegates,
evaluates, and tracks — without absorbing large implementation in the manager
thread. Every delivery leaves the touched area at least as testable and as well
covered as before. Uninvokable — load only when a skill's On-invoke pointer fires.

When spawning workers, also load [CONCEPT_DELEGATION](CONCEPT_DELEGATION.md).

## Leading words

- **manager** / **worker** — see CONCEPT_DELEGATION
- **spec fidelity** — every package and evaluation cross-references the specification

## Invariants

- **Management role.** Manager owns plan and evaluation; delegates large work. Manager stays high-capability; workers use CONCEPT_DELEGATION (value-biased).
- **Spec fidelity.** Deviations require plan revision or user alignment — not silent invention.
- **Isolated packages.** Each delegation is self-contained: objective, inputs, constraints, deliverables, branch, difficulty/model.
- **Iterative plan.** Re-evaluate after each report; revise remaining packages when findings change assumptions.
- **Branch discipline.** Resolve the skill's delivery branch before first delegation; prefer an existing open branch/PR for the Task; workers commit only there.
- **No silent gaps.** Insufficient report → re-delegate with named gaps (escalate one tier); do not absorb large gaps in the manager thread.
- **Tests with behaviour.** Behavioural packages include/update tests in-package (or a Testing package before verify). Bug fixes include regression coverage.
- **Design for testability.** Injectable seams; isolatable units; no hard-wired I/O/clocks/neighbors that force redesign to test.
- **No coverage/quality regression.** Touched-area suite stays honest and green; failure paths count.
- **Verification mandatory.** Run real project tests/lint for the touched area (or full suite if that is the norm). Never invent green results.

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

## Package brief (minimum)

Objective; inputs; constraints (incl. testability seams); deliverables (code + tests or explicit justification); branch; difficulty / model.
