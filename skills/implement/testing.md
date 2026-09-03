# Implement — testing and testability checklist

Paste into **Implementation** and **Testing** package briefs (and fix-forward briefs
when the finding is Correctness / missing coverage / testability). Complements
[CONCEPT_IMPLEMENTATION](../concepts/CONCEPT_IMPLEMENTATION.md).

Repo docs and existing test patterns win over generic advice.

## Spec locks

Honor [CONCEPT_IMPLEMENTATION](../concepts/CONCEPT_IMPLEMENTATION.md) **spec
lock**. Pass-criteria rows come from the definition artifact (legacy
`## Acceptance criteria` counts).

- [ ] Each pass-criteria row for this package has a spec lock (path named in
      the package report). Docs-only: `none — no executable behaviour`
- [ ] The lock is written from the row, not from the implementation
- [ ] Bug fixes and behaviour-changing tweaks: the lock was red on current
      code, then green after the fix
- [ ] New observable behaviour still has tests that would fail if the behaviour
      were missing or wrong — those tests are spec locks when they encode a
      pass-criteria row

## Behaviour coverage

- [ ] Bug fixes include a regression test (or equivalent automated check) that
      reproduces the defect before the fix (the spec lock, fail-first)
- [ ] Failure paths covered where the code branches on errors, empty/null, auth,
      validation, or partial failure — not only the happy path
- [ ] Contract / API / schema changes update existing tests and fixtures so they
      still match reality
- [ ] Purely non-behavioural changes (docs, comments, renames with no runtime effect)
      may omit new tests — state that explicitly in the package report

## Working surfaces

A **working surface** is a startable backend, a startable frontend, or a
composed client-server path the change can break. Unit tests at a seam do not
replace these checks when the area owns that surface.

- [ ] Backend the change can break still starts and answers its health, API, or
      CLI contract
- [ ] Frontend the change can break still builds and serves; mapped user flows
      still complete (browser or repo E2E — exercise the flow, not only first paint)
- [ ] When both exist, a composed path still works (the client still talks to the
      server on a mapped flow)
- [ ] Commands that prove the surfaces are recorded and re-run; the report
      includes `how_to_run` and observed result
- [ ] Adopt / `ADOPT.md`: every working-surface row on the Behaviour map is locked
      this way before structure, and still holds after
- [ ] Pure library / types / docs with no startable surface: record `none` with
      evidence — do not invent a host

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
- [ ] Coverage that lowers **CRAP** comes from tests that assert the executed
      paths; a call that ignores the result does not count
- [ ] Flaky or environment-bound tests are not introduced; prefer deterministic fakes

## Repo norms

- [ ] Tests live where this repo expects them (`*_test.*`, `__tests__/`, `tests/`, …)
- [ ] Naming, fixtures, factories, and runners match neighbouring tests
- [ ] Shared test helpers are reused when they already exist — do not invent a
      parallel test runner for one package

## Package report (required)

Each Implementation/Testing sub-agent report must include:

```text
tests_added_or_updated: <paths or "none — <justification>">
spec_locks: <pass-criteria row → test path, or "none — no executable behaviour">
how_to_run: <exact command(s) used>
result: pass | fail | unavailable (<why>)
working_surfaces: <commands + result, or "none — <evidence>">
coverage_notes: <touched paths covered / gaps remaining>
testability_notes: <seams used or deliberately not introduced>
```

Gaps that remain after the package become **re-delegation** targets —
do not silently defer them to `/test`, `/harden`, or review. Change size does
not relax this list. Missing spec locks fail the package. The bound **testing
phase** (`/test`) still audits the mapping; in-package tests do not replace it.
