# Concept: Implementation

**Uninvokable concept.** Skills that need this behaviour must instruct the agent to
read this file on invoke. Do not surface this concept unless a skill references it.

## Purpose

Execute an agreed **specification** in a codebase via a **management agent** that
plans, delegates, evaluates, and tracks alignment with the spec — without
implementing large work directly.

Implementation is also how the codebase stays **well-structured and testable**.
Every delivery must leave the touched area at least as easy to test, and at least
as well covered, as before — preferably better. Features that land without tests,
or designs that hard-wire collaborators and block isolation, degrade quality over
time even when the feature "works."

## What this is not

- Not a user-invokable workflow by itself
- Not solo implementation in the management thread
- Not alignment — the spec must already exist (from a prior alignment session,
  artifact file, or user-provided plan)
- Not "code first, tests later" — tests and testability are part of the work,
  not an optional afterthought

## Extension contract

Skills that apply this concept **must** define:

| Extension | Purpose |
|-----------|---------|
| **Spec source** | How the management agent obtains the specification (chat artifact, file path, user paste) |
| **Branch naming** | How to name the feature branch |
| **Delivery** | PR vs branch-only vs other completion criteria |
| **Verification** | Final checks before delivery — tests (new/updated), lint, coverage/quality non-degradation for the touched area, spec checklist |

Skills **may** define:

| Extension | Purpose |
|-----------|---------|
| **Pre-work** | Steps before first delegation (e.g. commit spec file, ask issue ID) |
| **Work package types** | Domain-specific package categories |
| **Subagent mapping** | Which subagent type per package kind |
| **PR template** | Required PR body sections |
| **Testing checklist** | Concrete test/testability checks to paste into package briefs |

## Invariants

- **Management role.** The invoking agent owns the plan and delegates — it does not
  absorb large implementation work unless a package is trivial or delegation fails
  after retry.
- **Spec fidelity.** Every work package and evaluation cross-references the
  specification. Deviations require plan revision or user alignment.
- **Isolated packages.** Each delegation is self-contained with objective, inputs,
  constraints, deliverables, and branch context.
- **Iterative plan.** Re-evaluate the plan after each sub-agent report; revise
  remaining packages when findings change assumptions.
- **Branch discipline.** Create a feature branch before the first delegation;
  sub-agents commit to that branch.
- **No silent gaps.** If a sub-agent report is insufficient, re-delegate with named
  gaps — do not silently fix large gaps in the management thread.
- **Tests with behaviour.** Every package that changes observable behaviour includes
  or updates tests in the same package (or a tightly coupled follow-on Testing
  package before verification). Bug fixes include regression coverage for the
  failing case.
- **Design for testability.** Prefer clear seams: injectable collaborators,
  isolatable units, and dependency direction that allows testing without a full
  system boot. Do not hard-wire infrastructure, clocks, I/O, or neighbors in ways
  that force a redesign to test later.
- **No coverage or quality regression.** Verification must not leave the touched
  area with a weaker suite, broken tests, or lower effective coverage of new/changed
  paths than before. New behaviour needs tests proportional to risk; failure paths
  count, not only happy paths.
- **Verification is mandatory.** Do not deliver without running the project's usual
  tests/lint for the touched area (or full suite when that is the repo norm). If
  tooling is unavailable, say so explicitly — do not invent green results.

## Testing and testability

Treat testing as a **first-class work product**, equal to production code:

| Concern | Expectation |
|---------|-------------|
| **New behaviour** | Automated tests that would fail if the behaviour were missing or wrong |
| **Bug fixes** | Regression test (or equivalent automated check) that reproduces the defect |
| **Contract changes** | Existing tests updated so they still match the real contract |
| **Failure paths** | Errors, empty/null, auth denial, partial failure — not only the happy path |
| **Structure** | Collaborators mockable/faked at a seam; no need to redesign to isolate a unit |
| **Coverage** | Touched paths covered; do not leave large new branches or public APIs untested |
| **Repo norms** | Follow the project's test layout, naming, fixtures, and runners |

When the spec's acceptance criteria omit verification details, still add tests for
changed behaviour unless the change is purely non-behavioural (docs, comments,
config rename with no runtime effect) — and say so in the package report.

**vs later review:** Review axes (Correctness, Architecture) catch gaps; implementation
must not rely on review to invent the test suite. Ship tests with the code.

## Flow

### 1. Obtain specification

Load the spec from the skill's **spec source**. If missing or ambiguous, ask the
user — do not invent requirements.

### 2. Pre-work

Run any **pre-work** defined by the skill (e.g. issue ID, write spec file to repo).

### 3. Create branch

Create the feature branch per **branch naming** before any delegation.

### 4. Draft plan

Break the spec into ordered **work packages** — discrete, delegable units with
acceptance criteria. Respect dependencies. Include testing in each behavioural
package (or schedule dedicated Testing packages before verify). Call out
testability constraints when the design needs seams for isolation.

### 5. Implementation loop

```
1. Select next work package
2. Delegate to a sub-agent with:
   - objective and acceptance criteria (including tests / testability)
   - spec excerpts and prior package findings
   - branch name; files/areas to touch or avoid
   - testing checklist when the skill provides one
3. Receive sub-agent report
4. Evaluate against package criteria, overall spec, and testing/testability invariants
5. Update plan if needed; mark done or re-delegate
6. Repeat until all packages complete
```

### 6. Verify and deliver

Run **verification** (tests, lint, coverage/quality check for the touched area,
spec checklist). Deliver per the skill (**PR**, branch status, status report).
Do not hand off to review with known red tests or untested new behaviour.

## Work package delegation

Each delegation must include:

- **Objective** — what this package must achieve
- **Inputs** — spec sections, prior findings, decisions
- **Constraints** — scope, style, dependencies from the spec; testability seams
  when relevant
- **Deliverables** — code, **tests** (or explicit justification if none), findings,
  and notes on coverage of new/changed paths
- **Branch** — feature branch; sub-agents commit here

## Evaluating sub-agent results

1. Check deliverables against package acceptance criteria (including tests).
2. Cross-reference with the spec and overall plan.
3. Check testability: can the new unit be exercised without hard-wired neighbors?
4. Check coverage intent: are new/changed behavioural paths exercised by tests?
5. If insufficient → re-delegate with specific gaps (missing tests count as gaps).
6. If plan assumptions were wrong → revise remaining packages before continuing.

## Anti-patterns

- Implementing large chunks directly instead of delegating
- Delegating without acceptance criteria or branch context
- Skipping plan re-evaluation after surprising findings
- Starting on `main` without a feature branch
- Ending without the agreed **delivery** outcome
- Proceeding without a usable specification
- Shipping observable behaviour without tests
- "We'll add tests in a follow-up" without an in-plan Testing package before verify
- Hard-wiring collaborators, clocks, or I/O so the unit cannot be isolated
- Skipping the project test suite to save time, or inventing green CI
- Only happy-path tests when failure modes are part of the spec or obvious in the code
- Leaving existing tests broken or outdated after a contract change

## Authoring skills that use this concept

1. Instruct the agent to **read this file first** on invoke.
2. Fill in the **extension contract** (including a concrete **Verification** that
   covers tests and non-degradation).
3. Prefer a **testing checklist** for package briefs when the skill is the main
   build path.
4. Link: `[CONCEPT_IMPLEMENTATION](../concepts/CONCEPT_IMPLEMENTATION.md)`.
