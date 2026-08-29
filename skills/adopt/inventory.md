# Adopt inventory

Disclosed from [SKILL.md](SKILL.md). Load when scanning a brownfield tree against
the structure catalog. Do not restate [CONCEPT_STRUCTURE](../concepts/CONCEPT_STRUCTURE.md)
invariants.

## Scan

Walk the production tree. Skip generated output, vendor, lockfiles, and paths
repo docs mark as out of scope. **Repo docs win** on layering and names.
When more than one area exists, scan via [route.md](route.md#delegation)
workers; the manager merges rows.

For each **area** (module, package, bounded directory, or equivalent seam the
repo already uses), record catalog rows that fail with a **concrete move**
(extract, rename, move, split, invert, asserting test) and evidence. Include
**CRAP** at or above 8 (or the repo threshold). Vague cleanup is not a row.
Neighbour patterns in that area set the shape to match; do not copy a
neighbour smell or high **CRAP** into the adoption hunks.

An area **meets the bar** when remaining rows are documented exceptions.

## Sequence

Rank areas that still fail:

1. **Foundation** — breaches that other areas must copy if left in place
   (wrong dependency direction, missing seams, cycles, high-**CRAP** types
   neighbours must extend).
2. **Contagion** — smells that spread when new code follows neighbours.
3. **Value** — hot paths and public modules before cold or leaf code.

Do not reorder to pick a smaller first diff when a foundation breach would
force the next area to repeat the smell.

## Delivery units

| Shape | When |
|-------|------|
| **One Task / one PR** | The failing set is one area, or a tightly coupled cluster one review can hold and one suite slice can prove |
| **Story + route Tasks** | Areas are independently shippable, or the tree is larger than one reviewable blast radius |

Each route Task is one delivery unit (own branch/PR through ship). The
**frontier** is the first open area in Order. Later units start from the base
that already contains prior adoption.

## Frontier packages

On the frontier Task, **characterize** first ([characterize.md](characterize.md)).
Structure packages (extract, rename, move, split, invert) start only when the
behaviour map is locked. Observable behaviour stays the same;
[route.md](route.md#preserve-behaviour-required) is the gate. A behaviour-changing
package is out of scope. Size packages so implement can finish them in one
delivery; do not stuff the whole tree into one package.
