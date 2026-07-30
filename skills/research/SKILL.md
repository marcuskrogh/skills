---
name: research
description: >-
  Multi-axis investigation of a topic: arXiv preprints plus formal written sources,
  web discovery, and informal/practitioner material. Writes RESEARCH.md as
  supportive evidence — not user alignment or product decisions. Links to a
  pipeline Task when given and updates continuity markdown. Use for surveys,
  state of the art, or a wide research pass.
---

# Research

Applies [CONCEPT_RESEARCH](../concepts/CONCEPT_RESEARCH.md) as a **multi-axis**
investigation for a user-described topic. Optional side path on the main pipeline
— feeds **model**, **define**, or **explore** with **supportive** context.

**On invoke:** read [../concepts/CONCEPT_RESEARCH.md](../concepts/CONCEPT_RESEARCH.md),
[../workflow/reference.md](../workflow/reference.md), and
[../tracker/SKILL.md](../tracker/SKILL.md) when a Task key or WORKSPACE exists. Read
[reference.md](reference.md) for axis tooling (arXiv script, web fetch notes).

**Default:** cover **all relevant axes**. arXiv is **one axis**, not the whole
pass. Narrow to a single axis only when the user asks (e.g. "arXiv only").

## Intent

Research is **evidence gathering across sources**, not user-agent alignment.

| Research does | Research does not |
|---------------|-------------------|
| Survey what sources say across axes | Speak for the user or settle product choices |
| Surface themes, gaps, and citations | Lock scope, UX, behaviour, or acceptance |
| Orient **model** / **define** with evidence | Replace definition probes or math alignment questions |
| Leave product particulars **open** | Pre-answer what **define** must ask the user |

`RESEARCH.md` is an **input**, not an agreement. Downstream skills must still align
with the user. Do not phrase the brief or **Next** as if research already decided
the plan.

## Extension contract

| Extension | This skill |
|-----------|------------|
| **Research axes** | See [Axes](#axes) — all by default |
| **Retrieval path** | Per axis below; arXiv via `scripts/arxiv_research.py`; others via WebSearch / WebFetch (or harness equivalents) |
| **Artifact** | `RESEARCH.md` (path from WORKSPACE) |
| **Citation rules** | Every claim traces to retrieved evidence; include durable ID/URL + **axis** label |

## When to use

- Wide survey or state-of-the-art on a topic (default)
- "What does the field / web / literature say about …?"
- Compare approaches across papers, standards, docs, and practice
- Find seminal works, recent advances, or practitioner gotchas
- Resolve known arXiv IDs / DOIs / RFCs in a broader multi-axis pass
- Explicit single-axis ask (e.g. arXiv-only) — then skip other axes and note why

## Axes

Cover each axis that fits the topic. Skip only with a recorded reason (user scope,
out of domain, or quick-scan proportionality).

| Axis | Sources | Primary retrieval |
|------|---------|-------------------|
| **1. Preprints (arXiv)** | arXiv (and noted peer preprint servers if relevant) | `scripts/arxiv_research.py` — see [reference.md](reference.md) |
| **2. Formal written** | Journals, proceedings, books, standards, RFCs, official specs, textbooks | WebSearch → WebFetch durable pages (DOI, publisher, IETF, ISO, W3C, …) |
| **3. Web discovery** | Search indexes, docs hubs, survey pages, encyclopedic overviews, secondary catalogs | WebSearch with complementary queries; WebFetch key landing pages |
| **4. Informal / practitioner** | Engineering blogs, talks/slides, repo READMEs/ADRs, forums, industry reports, newsletters | WebSearch + WebFetch; label as informal |

### Axis 1 — Preprints (arXiv)

Use `scripts/arxiv_research.py` as the **first** path for this axis:

```bash
python3 scripts/arxiv_research.py search -q 'all:topic AND cat:cs.LG' --max-results 25
python3 scripts/arxiv_research.py lookup --ids 1706.03762,2312.00752
python3 scripts/arxiv_research.py snowball --ids 1706.03762 --max-results 20
```

**Fallback** (only if Python is unavailable): `curl -sL` on
`https://export.arxiv.org/api/query?...` or `WebFetch` on the same URL. Do **not**
scrape `arxiv.org/search` unless the request needs DOI, ORCID, ACM, or MSC lookup
(see reference.md).

Design **2–4 complementary arXiv queries** (broad / title / abstract / recency /
author). Prefer **one** multi-`-q` script invocation. Full flags and JSON schema:
[reference.md](reference.md).

### Axis 2 — Formal written

Search for peer-reviewed and normative material beyond preprints:

- Journal / conference versions of preprint hits (DOI, publisher PDF/HTML)
- Standards and RFCs (IETF, ISO, IEEE, W3C, …)
- Books / handbook chapters and survey articles
- Official product or API specifications when the topic is systems/software

Prefer durable identifiers (DOI, RFC number, standard designation). Note
peer-review or normative status when known.

### Axis 3 — Web discovery

Run **2–4 complementary web queries** (not one string), e.g.:

1. Broad topic + "survey" / "overview" / "state of the art"
2. Method or system name + comparison / benchmark
3. Official documentation or "site:" filters for known hubs
4. Recency-oriented queries when the user wants recent advances

Use results to discover candidates for axes 1–2 and 4; fetch primary pages rather
than citing search snippets alone.

### Axis 4 — Informal / practitioner

Seek practice-facing material that formal corpora miss:

- Engineering blog posts and postmortems
- Conference talks, slides, recorded demos
- High-signal repo docs (README, ADR, design notes)
- Forums / Q&A only when they add unique operational detail
- Industry whitepapers and reputable newsletters

**Always label** these as informal. Do not present them as peer-reviewed fact.

## Workflow specialisation

Follow CONCEPT_RESEARCH. Multi-axis notes:

### 1. Scope

Infer topic, intent, depth, and time horizon. Default axes = all four. If the user
says "arXiv only" (or similar), run that axis alone and state the scope in the brief.

### 2. Plan

Write a short plan: which axes, which queries/targets per axis. Record it in
`RESEARCH.md` under Search strategy.

### 3. Execute

Run axes in parallel when tools allow; otherwise Preprints → Formal → Web →
Informal is a good order (seeds from preprints often unlock formal versions and
practitioner discussion).

### 4. Expand

Snowball across axes: arXiv snowball for papers; follow DOIs/citations for formal;
follow "discussed in" / author sites / related repos for informal.

### 5. Triage

Merge candidates; dedupe by DOI / arXiv ID / canonical URL. Prefer items that
appear on multiple axes. Tier Core / Supporting / Peripheral with axis labels.

### 6. Deep read

Extract problem, approach, contribution, evidence, limitations, links — from
retrieved text only.

### 7. Artifact

Write **`RESEARCH.md`**. Label findings as source evidence, not project decisions:

```markdown
# Research brief: <topic>

## Question
…

## Axes covered
| Axis | Status | Notes |
|------|--------|-------|
| Preprints (arXiv) | covered / skipped | … |
| Formal written | covered / skipped | … |
| Web discovery | covered / skipped | … |
| Informal / practitioner | covered / skipped | … |

## Search strategy
… (queries / targets per axis)

## Executive summary
… (what the sources say — not what we will build)

## Key sources
… (mixed axes; each item: title, axis, ID/URL, one-line relevance)

## Themes and trends
… (note agreements and disagreements across axes)

## Gaps and limitations
… (incl. axis blind spots)

## Recommended reading order
… (sources to study — not a product plan)

## Role in pipeline
Supportive context for `/model` and `/define`. Does **not** settle user alignment.
Particulars for define remain open.

## Sources
… (full citations with durable links/IDs + axis)

## Tracker
- Task: <KEY> (if linked)
- Artifact: RESEARCH.md
- Branch: <delivery-branch if committing>
- PR: <url if open>

## Next
`/<skill> <KEY>` — <why>
```

## Pipeline continuity

When a pipeline **Task** (or Story) key was given or inferred:

1. `attach_or_link` `RESEARCH.md` on that issue; `comment` with path + short executive summary + **Next**.
2. Do **not** change Task status (leave **To Do** / current); do **not** create a parallel Task when a key was given.
3. **Delivery branch:** if committing `RESEARCH.md` (or other continuity) for this Task,
   follow [delivery branch continuity](../workflow/reference.md#delivery-branch-continuity-closed-loop):
   reuse the Task’s open branch/PR if any; otherwise start the delivery branch (+ draft
   PR when Open PR by default) so define/implement continue on the **same** PR. Do
   **not** open a research-only PR that will be abandoned when define starts another.
4. If `ROADMAP.md` lists the route step, add/update notes pointing at `RESEARCH.md`
   (on the delivery branch when one exists for this Task).
5. If `PLAN.md` exists for the Task, add a **Research** section or link under Open items / Inputs — as evidence, not as locked decisions.
6. Upsert the markdown mirror (`docs/agents/ISSUES.md`) with artifact + branch/PR + **Next**.

Standalone research (no Task): still write `RESEARCH.md`; **Next** may be `/explore`
or `/define` if the user wants to start a phase.

## Handoff

| Context | Next |
|---------|------|
| Math-heavy follow-up | `/model <KEY>` |
| Ready to define behaviour with the user | `/define <KEY>` |
| Still scoping the initiative | `/explore` |
| Only needed the brief | No further skill |

```markdown
## Next
`/define <KEY>` — Define with user; research brief is supportive context only
```

(or `/model <KEY>` — Align math with user; research brief is supportive context only)

## Operational rules

1. **Multi-axis by default** — arXiv alone is not a complete pass unless scoped.
2. **Script first on preprints** — one `search` with multiple `-q` flags beats many `curl`s.
3. **Web for the other axes** — WebSearch / WebFetch (or harness equivalents); no MCP required.
4. **Honest coverage** — note preprint vs peer-reviewed vs informal; say what was skipped.
5. **No fabrication** — every claim traces to retrieved output (script JSON, fetched page, or search result you opened).
6. **Proportional depth** — quick scan: light pass on ≥2 axes; thorough: all relevant axes + expand.
7. **Canonical IDs** — arXiv ID (no `vN` unless needed), DOI, RFC/standard id, or durable URL.
8. **Supportive only** — never present research synthesis as user-approved scope or a finished definition.

## Anti-patterns

- arXiv-only (or any single-axis) research when the user asked for a normal / wide pass
- Multiple separate arXiv script invocations when one `search -q ... -q ...` suffices
- Citing search snippets without fetching the underlying page when depth requires it
- Treating blogs/forums as peer-reviewed without labeling informal
- Ignoring `total_results` on arXiv and treating the first page as exhaustive
- Framing the brief or handoff so `/define` skips questioning the user
- Treating source consensus as project decisions
- Opening a separate research-only PR when the Task already has (or will immediately
  get) a define/implement delivery PR — use one branch

## Quick examples

**Wide pass — diffusion models for protein design:**

1. Preprints: multi-query arXiv search + optional snowball.
2. Formal: DOI / journal versions; any standards or reviews.
3. Web: "protein diffusion design survey", lab/docs hubs.
4. Informal: practitioner posts, notable repo READMEs, talks.
5. Triage across axes → `RESEARCH.md`.

**arXiv-scoped (user asked):**

```bash
python3 scripts/arxiv_research.py search \
  -q 'all:diffusion+protein+design+AND+cat:q-bio' \
  -q 'ti:"protein"+AND+abs:diffusion' \
  -q 'all:diffusion+AND+cat:q-bio+AND+submittedDate:[202401010000+TO+202512312359]' \
  --max-results 30 --sort submittedDate --order descending
```

Record Axes covered: only Preprints; others skipped (user scope).
