# Implement — testing and testability checklist

Paste into **Implementation** and **Testing** package briefs (and fix-forward briefs
when the finding is Correctness / missing coverage / testability). Complements
[CONCEPT_IMPLEMENTATION](../concepts/CONCEPT_IMPLEMENTATION.md).

Repo docs and existing test patterns win over generic advice.

## Behaviour coverage

- [ ] New observable behaviour has automated tests that would fail if the behaviour
      were missing or wrong
- [ ] Bug fixes include a regression test (or equivalent automated check) that
      reproduces the defect before the fix
- [ ] Failure paths covered where the code branches on errors, empty/null, auth,
      validation, or partial failure — not only the happy path
- [ ] Contract / API / schema changes update existing tests and fixtures so they
      still match reality
- [ ] Purely non-behavioural changes (docs, comments, renames with no runtime effect)
      may omit new tests — state that explicitly in the package report

## Testability of the design

- [ ] Collaborators that need isolation (I/O, clock, network, DB, neighbors) are
      injectable or behind a clear seam — not hard-wired constructors that block
      unit tests without a redesign
- [ ] New modules have one clear responsibility that can be exercised in a focused
      test without booting the whole system (unless the repo norm is only
      integration/E2E for that layer)
- [ ] Dependency direction allows tests to substitute fakes/mocks at package
      boundaries the project already uses
- [ ] No new global mutable singletons or static state that make tests order-dependent
      or flaky

## Coverage and quality non-degradation

- [ ] Project test suite for the touched area (or full suite if that is the norm)
      passes after the package
- [ ] New/changed public APIs and critical branches are exercised; do not leave large
      new paths untested
- [ ] Do not delete, skip, or weaken existing tests to "make green" without replacing
      equivalent coverage
- [ ] If the repo reports coverage: do not regress coverage on touched packages
      without an explicit, documented reason in the PR test plan
- [ ] Flaky or environment-bound tests are not introduced; prefer deterministic fakes

## Repo norms

- [ ] Tests live where this repo expects them (`*_test.*`, `__tests__/`, `tests/`, …)
- [ ] Naming, fixtures, factories, and runners match neighbouring tests
- [ ] Shared test helpers are reused when they already exist — do not invent a
      parallel harness for one package

## Package report (required)

Each Implementation/Testing sub-agent report must include:

```text
tests_added_or_updated: <paths or "none — <justification>">
how_to_run: <exact command(s) used>
result: pass | fail | unavailable (<why>)
coverage_notes: <touched paths covered / gaps remaining>
testability_notes: <seams used or deliberately not introduced>
```

Gaps that remain after the package become **plan items** or re-delegation targets —
do not silently defer them past verification.
