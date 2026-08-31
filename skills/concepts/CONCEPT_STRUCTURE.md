# Concept: Structure

Shared **structure** bar for production code: names, size, cohesion, dependency
direction, named smells, **CRAP**, campground, and module depth. Uninvokable —
load only when a skill's On-invoke pointer fires.

## Intent

Keep every opened unit at least as well structured as its neighbours, and meet
the catalog bar on new code — **including small diffs**. Everyday work leaves
opened units cleaner (**campground**) and, when the benefit is major, opened
module neighbourhoods cleaner. **implement** applies this as-you-go and gates
closeout; **restructure** (alias **harden**) applies it as a shipping-phase pass
on every bound Task; **adopt** applies it across an existing tree that was not
built to the bar; Architecture and Standards **lasers** still evaluate it at
closeout.

Catalog: [STRUCTURE-CATALOG.md](STRUCTURE-CATALOG.md).

## Leading words

- **campground** — when a Task opens a unit, leave that whole unit cleaner
  (catalog holds) after the change
- **touched unit** — the function, method, type, or interface opened to make
  the spec change; not the whole file
- **restructure** — shipping-phase, behaviour-preserving structure pass on the
  delivery pull request (invoke alias: `/harden`; binding key: `harden.mode`)
- **architecture neighbourhood** — the module or boundary this Task already
  opens, plus its ports; refine it only when the benefit is major
- **adopt** — apply the catalog across an existing codebase that was not built
  to the bar; inventory, sequence, walk one delivery unit at a time until Done
- **characterize** — map current observable behaviour to tests and prove them
  green on current code before structure-only edits
- **working surface** — startable backend, startable frontend, or composed
  client-server path the area already owns
- **prove** — recorded baseline (lock suite plus working-surface commands) still
  holds before the next structure-only step or area
- **CRAP** — Change Risk Anti-Patterns score; a guide toward extract vs
  justified dispatch; always evaluate on touched code; no hard cap
- **seam** — injectable boundary that lets a unit be tested without booting the
  whole system
- **depth** — a unit does one thing behind a simple interface and hides the
  rest; one-thing and deep modules are the same idea at function and module scale

## Invariants

- **As-you-go.** New and changed code meets the structure catalog before a
  package is done. Implement does not defer catalog breaches to restructure or
  review. Change size does not relax the catalog.
- **Campground.** Opening a **touched unit** licenses cleaning that whole unit
  (and helpers extracted from it), not the rest of the file. After the change
  the unit meets the catalog. Prove before tidy. A god-unit **sprouts** the
  path this Task needs; the remainder is no worse. Review may finish that unit
  when this change opened it. Feature behaviour and campground extracts do not
  share a work package.
- **Every change size.** A one-hunk bugfix meets the same catalog as a feature.
  Small is not a skip.
- **Behaviour preserved on structure-only passes.** Restructure and adopt change
  structure, naming, layering, and comments only. Executable behaviour stays the
  same; **prove** holds on the recorded baseline.
- **Proof is the gate.** A structure-only unit is not done while the recorded
  baseline is red, was not run, or existing tests were weakened to pass. The
  baseline is the lock suite **and** every **working surface** the unit owns
  (backend still starts and answers; frontend still builds, serves, and mapped
  flows still complete; composed client-server paths still work when both exist).
- **Lock before restructure.** Adopt does not start structural edits on a unit
  until observable behaviours — including every **working surface** the area
  owns — are mapped to tests that are green on current code. Those commands are
  the prove commands after edits. A unit suite that never starts the process
  does not lock a startable surface.
- **Architecture neighbourhood.** When this Task already opens a module or
  crosses a boundary, consider that neighbourhood’s interface, depth, and
  dependency direction. Refine it on this pull request when the benefit is
  **major**. Do not move boundaries as a ritual. Do not re-layer the rest of
  the system. Do not open a follow-up ticket for leftover architecture.
- **One thing and depth.** A function or module has one reason to change and
  one level of abstraction in the body; its interface stays simple. A deep
  module does one thing. A quiet 20–40 line function with one job is a win.
  Split when the body mixes reasons, nests control flow, or needs its own name.
- **Shape over score.** Nested control flow and boolean soup lean toward
  meaningfully low complexity (about 4–8). A flat switch, match, or lookup over
  a closed set may stay. Always evaluate **CRAP** on touched functions; the
  score alone is not a fail.
- **Repo docs win.** Documented ADRs, layering, naming, and numeric bars
  override generic catalog rows.
- **Named smells are defects.** An actionable named smell in changed code is
  `should-fix` (or `blocker` when it breaches a documented constraint) — not
  optional polish.
- **Concrete move.** A structure finding names an extract, move, rename, split,
  invert, or asserting test with evidence. Vague cleanup is not a finding.
- **Neighbours set the pattern, not the smell.** Match existing patterns in the
  touched area. New and changed hunks still meet the catalog; do not copy a
  neighbour smell or nested-conditional **CRAP** into this PR.
- **Untestable is not done.** An extract that still cannot be tested at a
  **seam** without booting the world fails the package.

## Extensions

| Slot | Required | Purpose |
|------|----------|---------|
| **Catalog** | must | Principle rows ([STRUCTURE-CATALOG.md](STRUCTURE-CATALOG.md)) |
| **Scope** | may | Touched units, surrounding module, or sequenced brownfield tree |
| **Verification** | may | How behaviour-preservation is proved after structural edits |

## Flow

1. **Load catalog + repo docs** — ADRs and neighbour patterns first. Done when
   the effective bar is known.
2. **Apply** — Check each **touched unit** against the catalog, including small
   diffs; consider the **architecture neighbourhood** when a major benefit is
   clear. Done when every breach has a concrete move or an explicit, documented
   exception.
3. **Prove** — Re-run the recorded baseline commands (touched-area suite, lint,
   and **working surface** commands the unit owns) after structural edits. Done
   when checks match the baseline (green, or no new fails against a documented
   known-fail list).
