# Implement — structure checklist

Paste into **Implementation** package briefs (and fix-forward / harden briefs
when the finding is Architecture, Standards, or a named smell). Applies
[CONCEPT_STRUCTURE](../concepts/CONCEPT_STRUCTURE.md). Complements
[testing.md](testing.md).

Repo docs and neighbour patterns win over generic catalog rows.

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

## Package report (required)

Each Implementation (and Harden) sub-agent report must include:

```text
structure_notes: <meets catalog | breaches + concrete moves made>
smells_fixed: <named smells addressed or "none">
seams: <injectable boundaries used or deliberately not introduced>
exceptions: <documented catalog exceptions or "none">
```

A catalog breach that remains after the package is a **re-delegation** target —
do not mark the package done.
