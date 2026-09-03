---
name: writing-for-agents
description: >-
  Writing skills and concepts for agents. Use when creating or editing a
  SKILL.md, CONCEPT_*.md, skill reference file, AGENTS.md, or CLAUDE.md in
  this repo — especially to prune duplication, sharpen terminology, apply the
  lean concept/skill shapes, or apply the human-cadence overlay.
---

Reference for writing any document an agent in this repo consumes — a **skill**,
a **concept**, a disclosed reference file, or a pointer in `AGENTS.md` /
`CLAUDE.md`. Packaging differs; writing does not: the same levers make each one
**predictable** — the agent taking the same _process_ every run, not producing
the same output.

Inspired by [Matt Pocock's writing-for-agents](https://github.com/mattpocock/skills/tree/main/skills/productivity/writing-for-agents);
specialised for this repo's **concept → skill** split. For install/sync/plugin
mechanics, see [`manage-skills`](../manage-skills/SKILL.md). For skill-only
invocation tradeoffs, see [`SKILL-MECHANICS.md`](SKILL-MECHANICS.md).

## Concepts vs skills

| Kind | Path | Invokable? | Owns |
|------|------|------------|------|
| **Concept** | `skills/concepts/CONCEPT_<NAME>.md` | Never | Shared **invariants**, **flow**, and **extension slots** |
| **Skill** | `skills/<name>/SKILL.md` | Yes | **Extensions filled**, artifact paths, tracker duties, **Next** |

A skill **applies** one or more concepts. The concept is the single source of
truth for behaviour every applying skill shares. The skill adds only what that
purpose specialises.

**Rule:** a skill never restates a concept invariant. Point at the concept;
fill the extension table; write skill-only steps (artifact shape, tracker,
handoff). Restating an invariant is **duplication** — it inflates prominence
and drifts.

**User-facing prose** is not this skill. Messages the operator reads follow
[CONCEPT_LANGUAGE](../concepts/CONCEPT_LANGUAGE.md) from the always-on extract.
This skill's leading words and compact tokens are for skill and concept files
only. Skill prose still uses simple verbs and drops leftover assistant lines;
the skill **shape** (bold leading words, tables, required headings) stays.

## Context pointers

A **context pointer** names out-of-context material and encodes when to reach
it. A skill `description`, an **On invoke: read …** line, and a concept link
are the same object. The pointer's _wording_ decides reach reliability.

- **Front-load the leading word** — the trigger token first.
- **One trigger per branch.** Synonyms that rename one case are one branch
  written twice; collapse them.
- **Cut identity the body already carries.**

## The two loads

- **Context load** — always-loaded material (skill descriptions, AGENTS lines).
  Earns hard pruning.
- **Cognitive load** — cost on the human as index. Spend where human judgement
  matters; remove where it does not.

Material reached only through a pointer escapes context load at the price of
the pointer's line.

## Information hierarchy

Documents mix **steps** (ordered actions) and **reference** (definitions,
rules, facts). Rank each piece by how immediately the agent needs it:

1. **In-file step** — what the agent does, in order.
2. **In-file reference** — consulted on demand (flat peer-sets are fine).
3. **Disclosed reference** — sibling file behind a pointer (e.g. platform
   catalogs, axis checklists).

**Progressive disclosure** moves material down the ladder so the top stays
legible. Branching is the cleanest test: inline what every branch needs; push
what only some branches reach.

**Co-location** keeps a concept's definition, rules, and caveats under one
heading. **Sprawl** is a document too long even when every line is live —
cure with the ladder and by sequence/branch splits.

## Leading words

A **leading word** is a compact concept the model already holds (or that you
define once) and then repeat as a _token_, never as a restated paragraph. It
anchors execution in the body and invocation in pointers.

Repo tokens (use these; do not paraphrase into soft synonyms):

| Token | Meaning |
|-------|---------|
| **divergence** | Choice where multiple valid paths exist and a wrong assumption wastes rework |
| **alignment** | Relentless one-question loop until divergences that matter are resolved with the user |
| **fog** | Work felt but not yet ticketable; recorded, not faked into specs |
| **destination** | Named end-state of an explore map |
| **route** | Sequenced Tasks that clear fog; charted by explore, walked by later skills |
| **frontier** | First takeable Task on the route |
| **extension** | Skill-filled slot the concept declares but does not specialise |
| **invariant** | Concept-owned rule every applying skill inherits — never restated |
| **probe** | Domain question area; selection order still follows divergence value |
| **Next** | Persisted handoff cue naming the following skill + key |
| **fix-forward** | Same open PR; address review findings only |
| **iterate** | Post-ship delta on a **new** branch/PR |
| **tweak** | Small intentional change to existing behaviour; lightweight define sibling of bug |
| **refine** | Bounded structural/descriptive improvement without behaviour change; lightweight define sibling of bug/tweak |
| **rework** | Intentional implementation change with measured non-degradation (parity bar + comparative eval); lightweight define sibling of refine/tweak |
| **sandbox** | Isolated, representative vehicle for one contained unit, outside production paths; inspect-each-turn then promote via implement; post-merge instead of iterate when each turn needs inspection |
| **test** | Shipping-phase dedicated testing pass after implement (`test.mode=dedicated`) |
| **harden** | shipping-phase **refactoring** (`harden.mode=dedicated`); user-facing name **restructure** (`/harden` alias) |
| **architect** | Always-on shape step after define; `ARCHITECTURE.md` on the delivery branch |
| **restructure** | Shipping-phase structure pass after test; alias `/harden` |
| **campground** | Leave each opened unit cleaner; prove before tidy |
| **refactoring** | Behaviour-preserving structure edit (extract, rename, move, split, invert); campground and restructure apply these; CRAP guides which extract; not a phase or class |
| **architecture neighbourhood** | Opened module/boundary; refine only when the benefit is major |
| **adopt** | Apply the structure catalog across an existing codebase that was not built to the bar; characterize current behaviour into tests first (including working surfaces); delegated walk until the route is Done |
| **characterize** | Map current observable behaviour to tests and prove them green on current code before structure-only edits |
| **working surface** | Startable backend, startable frontend, or composed client-server path the area already owns |
| **CRAP** | Change Risk Anti-Patterns score; a guide toward extract vs justified dispatch; target below 8 unless repo docs set another threshold |
| **pass criteria** | Checkable success rows on the definition artifact, distinct from the specification; each row is one observable a spec lock can fail |
| **spec lock** | Automated check written from a pass-criteria row; fails if that row is unmet; a test of an invented helper does not count |
| **prove** | Recorded lock suite plus working-surface commands must still hold before the next structure-only step or area |
| **laser** | Sequential single-axis (or small-bundle) review pass; under review-fix, fix before the next laser |
| **code review** | Final published pull-request review after lasers; the closeout gate |
| **class** | Closed label for kind of work (bug/tweak/adopt/refine/rework/feature/…); from CONCEPT_CLASSIFICATION |
| **binding** | Selected workflow template + parameters persisted on the definition artifact |
| **template** | Named delivery bundle (fix-fast, parity-iterative, …) |
| **front door** | Primary human entry: explore (fog) or define (concrete) |
| **manager** | Orchestrating agent — stays high-capability; plans, evaluates, tracks |
| **worker** | Delegated sub-agent — value-routed low/mid/high |
| **depth** | Proportional intensity preset (review: `full` vs `focused`; define/bug/tweak/adopt/refine/rework: Full vs Lightweight) |
| **dev-surface** | (pl. **dev-surfaces**) Development linking surface where issue keys belong — full list: CONCEPT_IMPLEMENTATION Leading words |
| **product surface** | (pl. **product surfaces**) End-user facing shipped source and copy — product language exclusively; full list: CONCEPT_IMPLEMENTATION Leading words |
| **user-facing** | Prose the operator reads — [CONCEPT_LANGUAGE](../concepts/CONCEPT_LANGUAGE.md) |
| **human cadence** | Overlay in [LANGUAGE-HUMANIZER.md](../concepts/LANGUAGE-HUMANIZER.md) |
| **pace** | One unit per user turn; wait for **advance** or **block** before the next; each waited message ends on a short continue cue |
| **advance** | Approving reply that continues a paced sequence (yes, okay, move on, and similar; a successful result counts) |
| **block** | Reply that the current unit failed, is unclear, or does not fit the environment; reevaluate the remaining sequence |
| **guidance** | Paced walkthrough of a task the user wants walked — [CONCEPT_GUIDANCE](../concepts/CONCEPT_GUIDANCE.md) |
| **explanation** | Paced teaching of the current step and its decisions — [CONCEPT_EXPLANATION](../concepts/CONCEPT_EXPLANATION.md) |

Hunt restatements that a leading word retires. Prefer an existing pretrained
word over a coined one when the prior is strong enough.

**Negation** is the failure mode beside this lever: "don't X" activates X.
State the **positive** target. A prohibition earns its place only as a hard
guardrail you cannot phrase positively — and even then pair it with the
positive. Prefer **invariants** over **anti-pattern** lists; the latter are
usually invariants written twice in negative form.

## Human cadence in skill files

Apply [LANGUAGE-HUMANIZER.md](../concepts/LANGUAGE-HUMANIZER.md) content
patterns. Keep the skill **shape**: bold leading words, labeled tables, required
headings, and em dashes used as skill punctuation. Operator-directed replies are
not this skill; they follow [CONCEPT_LANGUAGE](../concepts/CONCEPT_LANGUAGE.md)
from the always-on extract.

## Steps and completion criteria

Every step ends on a **completion criterion** — checkable, preferably
exhaustive. Vague bounds invite **premature completion**. Sharpen the bound
first; only if it stays fuzzy _and_ you observe rush, split the sequence
across a real context boundary (hand-off / subagent), not an inline call.

## Pruning

- **Single source of truth** per meaning. Concepts own shared behaviour;
  skills own specialisations; the **environment** (`package.json`, CI,
  directory layout, `--help`) owns lookup facts — restating those is a
  **cache**, kept only when the lookup is expensive.
- Check **relevance** line by line. Default fate without pruning is
  **sediment**.
- Hunt **no-ops**: instructions the model already obeys by default. Delete
  the whole sentence when it fails the test.
- Delete boilerplate that every file repeats identically ("Authoring skills…",
  "What this is not" that only negates the purpose). Concepts open on
  **Intent**; the one-line Uninvokable role line in the concept shape is the
  allowed exception (do not expand it into a section).
- **Always-on language extract** names CONCEPT_LANGUAGE, LANGUAGE-PHRASES, and
  LANGUAGE-HUMANIZER, plus two caches (`GeneralProcessSimulator`, agent-host
  **harness**).
  Do not copy the phrase or cadence tables into AGENTS.md, Cursor rules, or
  skill On-invoke lines. Pipeline skills load [../workflow/SKILL.md](../workflow/SKILL.md)
  instead of listing delivery/handoff/tracker-sync files. Manual class skills
  share [../define/overrides.md](../define/overrides.md).

## Concept shape

Keep concepts short. Target: intent + invariants + extensions (+ flow when
the sequence is the point). Disclose long catalogs.

```markdown
# Concept: <Name>

<One-line role.> Uninvokable — load only when a skill's On-invoke pointer fires.

## Intent

<2–4 sentences: what, when, outcome. Positive framing only.>

## Leading words   # optional — only new or sharpened tokens

- **token** — definition

## Invariants

- **Name.** Positive rule the agent can check.
- …

## Extensions

| Slot | Required | Purpose |
|------|----------|---------|
| **Subject** | must | … |
| **Opening** | may | … |

## Flow   # when sequence matters

1. … — done when <criterion>
2. …

## Reference   # or disclose to SIBLING.md

<Tables every applying skill needs; otherwise push behind a pointer.>
```

Omit: "What this is not", "Anti-patterns", "Authoring skills that use this
concept", duplicate probe lists that skills will specialise anyway.

## Skill shape

```markdown
---
name: <folder>
description: >-
  <Leading word first>. <What it produces>. <When to use>.
# disable-model-invocation: true   # user-invoked only — see SKILL-MECHANICS.md
---

# <Name>

Applies [CONCEPT_…](../concepts/…) to <subject>. <One sentence on outcome.>

**On invoke:** read <concept(s)>, [../workflow/SKILL.md](../workflow/SKILL.md) when pipeline, <disclosed refs>.

## Extensions

| Slot | This skill |
|------|------------|
| **Subject** | … |
| **Stop condition** | … |
| **Artifact** | `FILE.md` |
| **Readiness prompt** | "…" |

## Steps   # skill-only — do not restate concept flow/invariants

1. …
2. …

## Artifact

\`\`\`markdown
# template
\`\`\`

## Tracker / Handoff

<Duties table + Next block>
```

**Description** is a context pointer: leading word front, one trigger per
genuine branch, no body identity. Prefer user-invocation
(`disable-model-invocation: true`) for pipeline skills; keep model-invocation
for routers and authoring aids the agent must discover (`workflows`,
`writing-for-agents`). See [`SKILL-MECHANICS.md`](SKILL-MECHANICS.md).

## Editing checklist

When touching a concept or skill:

1. **Whose meaning is this?** Concept, skill, disclosed ref, environment, or
   **user-facing** prose ([CONCEPT_LANGUAGE](../concepts/CONCEPT_LANGUAGE.md))?
2. **Already said?** Delete the restatement; link the source.
3. **Negation → positive?** Convert anti-patterns into invariants or delete.
4. **Leading word available?** Collapse the triad into the token.
5. **Ladder correct?** Disclose catalogs and branch-only material.
6. **Completion criteria sharp?** Especially on alignment stop and verify.
7. **Human cadence?** Apply LANGUAGE-HUMANIZER. User-facing also follows its
   marks. Skill files keep their shape.
8. **Validate:** `.\scripts\validate-skills.ps1`
