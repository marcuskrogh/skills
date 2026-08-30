# Adopt characterize

Disclosed from [SKILL.md](SKILL.md). Load as the first unit-chain step, **before**
structure packages. Do not restate [CONCEPT_STRUCTURE](../concepts/CONCEPT_STRUCTURE.md)
invariants. Distinct from `/test` (adversarial pass **after** structure).

## Intent

Define what the area does **today** and lock it in tests so later structure
work runs the **same tests** against the **same requirements**.

## Steps

1. **Map** — List observable behaviours at the area's seams. Cover every
   **working surface** the area owns:
   - **backend** — startable process, HTTP/API/health, CLI, jobs, persistence, events
   - **frontend** — routes, screens, client state, user-visible interactions
   - **composed** — client-server paths the area already meets
   Plus documented requirements the code already meets. Skip private internals
   that structure work will move. An area with no startable surface (types,
   docs, pure library) records `none` with evidence. Done when every seam and
   working surface has rows.
2. **Match** — Pair each row with an existing test path that would fail if that
   behaviour changed. Working-surface rows need a path that fails if the
   process does not start, the API does not answer, or the UI flow does not
   complete (repo E2E, smoke, or a new lock test). Unmatched rows are gaps.
   Done when every row is `locked` or `gap`.
3. **Lock** — Implement tests for gaps. Tests encode **current** behaviour,
   including quirks. Do not change production to match a nicer spec. Reuse the
   repo's test layout; add smoke/E2E when unit tests cannot see a working-surface
   break. Asserting lock tests raise coverage (one **CRAP** lever);
   complexity at 8 or above still needs extract during structure. Done when
   every gap has a test path.
4. **Prove on current code** — Run the lock suite (existing + new) **and** the
   working-surface commands on the pre-structure tree, per
   [testing.md](../implement/testing.md) **Working surfaces**:
   - backend: start + health/API/CLI smoke
   - frontend: build/serve + mapped screens (browser or repo E2E; exercise the
     flow, not only first paint)
   - composed: one path that exercises the client against the server
   Done when all are green (or match a documented known-fail list that structure
   work must not enlarge). Those commands become the unit **baseline**.

Persist the map on `ADOPT.md`. Structure implement does not start until step 4
holds.

## Behaviour map (required rows)

| Requirement | Current behaviour | Surface | Test path | Status |
|-------------|-------------------|---------|-----------|--------|
| … | … | backend / frontend / composed / none | `path` or gap | locked / gap |

Status must be **locked** before structure packages. After structure, the same
rows, paths, and expected results still hold — do not rewrite expectations to
make a restructure green.

A unit suite that never starts the process does not lock a startable surface.

## Out of scope

New product behaviour, nicer specs, and deleting or weakening lock tests.
Those are tweak / rework / feature, or a hard stop.
