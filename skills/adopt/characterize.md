# Adopt characterize

Disclosed from [SKILL.md](SKILL.md). Load as the first unit-chain step, **before**
structure packages. Do not restate [CONCEPT_STRUCTURE](../concepts/CONCEPT_STRUCTURE.md)
invariants. Distinct from `/test` (adversarial pass **after** structure).

## Intent

Define what the area does **today** and lock it in tests so later structure
work runs the **same tests** against the **same requirements**.

## Steps

1. **Map** — List observable behaviours at the area's seams: public API, CLI,
   events, persisted formats, and documented requirements the code already
   meets. Skip private internals that structure work will move. Done when every
   seam has rows, or the area is documented as having no observable seam
   (evidence required).
2. **Match** — Pair each row with an existing test path that would fail if that
   behaviour changed. Unmatched rows are gaps. Done when every row is `locked`
   or `gap`.
3. **Lock** — Implement tests for gaps. Tests encode **current** behaviour,
   including quirks. Do not change production to match a nicer spec. Reuse the
   repo's test layout. Asserting lock tests raise coverage (one **CRAP** lever);
   complexity at 8 or above still needs extract during structure. Done when
   every gap has a test path.
4. **Prove on current code** — Run the lock suite (existing + new) on the
   pre-structure tree. Done when it is green (or matches a documented
   known-fail list that structure work must not enlarge). Those commands become
   the unit **baseline**.

Persist the map on `ADOPT.md`. Structure implement does not start until step 4
holds.

## Behaviour map (required rows)

| Requirement | Current behaviour | Test path | Status |
|-------------|-------------------|-----------|--------|
| … | … | `path` or gap | locked / gap |

Status must be **locked** before structure packages. After structure, the same
rows, paths, and expected results still hold — do not rewrite expectations to
make a restructure green.

## Out of scope

New product behaviour, nicer specs, and deleting or weakening lock tests.
Those are tweak / rework / feature, or a hard stop.
