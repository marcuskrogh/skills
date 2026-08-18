# Changelog at closeout

Load when ship [closeout](ship.md#closeout) runs pre-merge continuity and the
repo may maintain a user-facing changelog.

## Intent

Before merge, detect whether the repo keeps a changelog. When one exists, append
a **short, compact** entry in the file's established format so the shipped
change is recorded for end users. Skip silently when no changelog is configured
or found.

## Detection

Resolve path in order; **first match wins**:

1. **WORKSPACE** — `Changelog` path in [Artifacts](../setup/format.md#template)
   when set.
2. **Auto-detect** — first existing file:
   `CHANGELOG.md`, `CHANGELOG`, `docs/CHANGELOG.md`, `docs/changelog.md`,
   `.github/CHANGELOG.md`, `HISTORY.md`, `NEWS.md`, `News.md`, `RELEASES.md`.

Done when the repo has a resolved changelog path or confirmed absence.

## Format inference

Read the file head and latest version section. Match the repo's **established**
pattern — do not introduce a new format.

| Signal | Placement | Entry shape |
|--------|-----------|-------------|
| `## [Unreleased]` or `## Unreleased` (Keep a Changelog) | New bullets under **Unreleased**; leave version/date for release tooling or human | `- **Category:** one-line user benefit` (1–3 bullets) |
| `## [x.y.z]` / `## x.y.z` with date | New section **above** the latest version | Same heading style and date convention as neighbours |
| `# Version x.y.z` / SemVer title lines | New block above latest | Mirror title + bullet style |
| Dated-only sections (`## 2024-01-15`) | New dated section at top | Mirror bullet/paragraph style |
| Single running bullet list (no versions) | Prepend at top after any title | One compact bullet or short paragraph |

**product surface** — user-facing wording only; no issue keys, PR numbers, or
internal tracker tokens. See
[CONCEPT_IMPLEMENTATION](../concepts/CONCEPT_IMPLEMENTATION.md).

Infer **category** labels (`Added`, `Fixed`, `Changed`, …) from the file's
existing labels; default to `Added` / `Fixed` / `Changed` only when the file
uses none.

Done when placement and shape match an existing section.

## Entry content

Derive from the shipped artifact (`PLAN` / `BUG` / `TWEAK` / `REFINE` / `REWORK` / `ITERATE`):

- **1–3 bullets** or **one short paragraph** (≤ 2 sentences).
- Lead with **user-visible outcome**, not implementation detail.
- Bug fixes: what users can do now that was broken.
- Tweaks/features: what is new or easier.
- Refinements: usually omit (internal structure/docs) unless the user-facing
  surface itself was the refine subject.
- Omit when the change is purely internal (docs-only for agents, CI, refactors
  with no user effect) — note skip in ship summary.

Done when entry is compact and product-facing.

## Closeout hook

Runs inside ship closeout **pre-merge continuity** (open PR) or direct base
commit when the PR was already merged — same rules as other continuity files.
Commit on the delivery branch with PLAN/BUG/TWEAK/REFINE/REWORK/ITERATE/SANDBOX continuity.
