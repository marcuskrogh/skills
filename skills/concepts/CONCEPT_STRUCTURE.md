# Concept: Structure

Shared **structure** bar for production code: names, size, cohesion, dependency
direction, and named smells. Uninvokable — load only when a skill's On-invoke
pointer fires.

## Intent

Keep every changed unit at least as well structured as its neighbours, and meet
the catalog bar on new code — **including small diffs**. **implement** applies
this as-you-go and gates closeout; **harden** applies it as a shipping-phase
pass on every bound Task; **adopt** applies it across an existing tree that was
not built to the bar; Architecture and Standards **lasers** enforce it at
closeout.

Catalog: [STRUCTURE-CATALOG.md](STRUCTURE-CATALOG.md).

## Leading words

- **harden** — shipping-phase, behaviour-preserving structure pass on the
  delivery pull request
- **adopt** — apply the catalog across an existing codebase that was not built
  to the bar; inventory, sequence, walk one delivery unit at a time until Done
- **seam** — injectable boundary that lets a unit be tested without booting the
  whole system

## Invariants

- **As-you-go.** New and changed code meets the structure catalog before a
  package is done. Implement does not defer catalog breaches to harden or review.
  Change size does not relax the catalog.
- **Every change size.** A one-hunk bugfix meets the same catalog as a feature.
  Small is not a skip.
- **Behaviour preserved on structure-only passes.** Harden and adopt change
  structure, naming, layering, and comments only. Executable behaviour stays the
  same; the suite proves it.
- **Repo docs win.** Documented ADRs, layering, and naming override generic
  catalog rows.
- **Named smells are defects.** An actionable named smell in changed code is
  `should-fix` (or `blocker` when it breaches a documented constraint) — not
  optional polish.
- **Concrete move.** A structure finding names an extract, move, rename, split,
  or invert with evidence. Vague cleanup is not a finding.
- **Neighbours set the pattern, not the smell.** Match existing patterns in the
  touched area. New and changed hunks still meet the catalog; do not copy a
  neighbour smell into this PR.

## Extensions

| Slot | Required | Purpose |
|------|----------|---------|
| **Catalog** | must | Principle rows ([STRUCTURE-CATALOG.md](STRUCTURE-CATALOG.md)) |
| **Scope** | may | Changed hunks, surrounding module, or sequenced brownfield tree |
| **Verification** | may | How behaviour-preservation is proved after structural edits |

## Flow

1. **Load catalog + repo docs** — ADRs and neighbour patterns first. Done when
   the effective bar is known.
2. **Apply** — Check each changed unit against the catalog, including small
   diffs. Done when every breach has a concrete move or an explicit, documented
   exception.
3. **Prove** — Re-run the touched-area suite (and lint) after structural edits.
   Done when checks pass.
