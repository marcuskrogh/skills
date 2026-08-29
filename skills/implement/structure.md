# Implement — structure checklist

Paste into **Implementation** package briefs (and fix-forward / harden briefs
when the finding is Architecture, Standards, or a named smell). Applies
[CONCEPT_STRUCTURE](../concepts/CONCEPT_STRUCTURE.md). Complements
[testing.md](testing.md).

Repo docs and neighbour **patterns** win over generic catalog rows. Neighbour
**smells** do not. Change size does not relax this list.

## Write-time bar

- [ ] Names reveal role; new functions/types are small enough to need no apology
- [ ] Each new/changed unit has one responsibility and sits in the right layer
- [ ] No new hard-wired I/O, clock, network, or DB that blocks a **seam**
- [ ] No new import/package cycles; dependency direction matches the repo
- [ ] No speculative framework, extra layer, or unused hook
- [ ] Duplicated logic in this change is extracted, or an explicit reason says
      the concepts only rhyme
- [ ] Error paths are handled, not swallowed; comments (if any) say why
- [ ] Named smells in **changed** code are fixed in-package — not left for review
- [ ] **CRAP** used as a guide on changed functions (target below 8): nested
      conditionals extracted; a flat switch/case over a closed set of types
      may stay

## Package report (required)

Each Implementation (and Harden) sub-agent report must include:

```text
structure_notes: <catalog rows checked + meets | breaches + concrete moves made>
crap: <target | nested extracted | justified dispatch: <shape> | report path>
smells_fixed: <named smells addressed or "none">
seams: <injectable boundaries used or deliberately not introduced>
exceptions: <documented catalog exceptions or "none">
```

A missing report, a catalog breach that remains, or "leave for harden/review"
fails the package — re-delegate; do not mark it done.

## Manager gate (before Next `/test`)

Walk the **whole** delivery diff (every Implementation package, not only the
last one):

- [ ] Every write-time bar item holds, or has a documented exception on the PR
- [ ] Every Implementation package report includes `structure_notes` that cite
      catalog rows and a `crap` line
- [ ] No remaining named smell in **changed** hunks
- [ ] Nested-conditional **CRAP** above the target is extracted; justified
      flat dispatch is recorded on the `crap` line (the score alone does not
      fail the gate)
- [ ] New code does not copy a neighbour smell
- [ ] Seams required by [testing.md](testing.md) exist before `/test`

Fail the gate → re-delegate. Passing the gate does not skip `/test` or `/harden`.
