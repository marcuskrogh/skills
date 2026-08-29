# Concept: Structure

Shared **structure** bar for production code: names, size, cohesion, dependency
direction, and named smells. Uninvokable — load only when a skill's On-invoke
pointer fires.

## Intent

Keep every changed unit at least as well structured as its neighbours, and meet
the catalog bar on new code. **implement** applies this as-you-go; **harden**
applies it as a shipping-phase pass; Architecture and Standards **lasers**
enforce it at closeout.

Catalog: [STRUCTURE-CATALOG.md](STRUCTURE-CATALOG.md).

## Leading words

- **harden** — shipping-phase, behaviour-preserving structure pass on the
  delivery pull request
- **seam** — injectable boundary that lets a unit be tested without booting the
  whole system

## Invariants

- **As-you-go.** New and changed code meets the structure catalog before a
  package is done. Implement does not defer catalog breaches to review.
- **Behaviour preserved on harden.** Harden changes structure, naming, layering,
  and comments only. Executable behaviour stays the same; the suite proves it.
- **Repo docs win.** Documented ADRs, layering, and naming override generic
  catalog rows.
- **Named smells are defects.** An actionable named smell in changed code is
  `should-fix` (or `blocker` when it breaches a documented constraint) — not
  optional polish.
- **Concrete move.** A structure finding names an extract, move, rename, split,
  or invert with evidence. Vague cleanup is not a finding.
- **Neighbours set the floor.** Match existing patterns in the touched area;
  raise to the catalog when new code would otherwise be worse than the catalog.

## Extensions

| Slot | Required | Purpose |
|------|----------|---------|
| **Catalog** | must | Principle rows ([STRUCTURE-CATALOG.md](STRUCTURE-CATALOG.md)) |
| **Scope** | may | Changed hunks vs surrounding module |
| **Verification** | may | How behaviour-preservation is proved after structural edits |

## Flow

1. **Load catalog + repo docs** — ADRs and neighbour patterns first. Done when
   the effective bar is known.
2. **Apply** — Check each changed unit against the catalog. Done when every
   breach has a concrete move or an explicit, documented exception.
3. **Prove** — Re-run the touched-area suite (and lint) after structural edits.
   Done when checks pass.
