# Concept: Research

**Uninvokable concept.** Skills that need this behaviour must instruct the agent to
read this file on invoke. Do not surface this concept unless a skill references it.

## Purpose

Produce an honest, citable **research brief** on a scoped question: what is known,
what themes recur, what gaps remain, and what to read next — without fabricating
sources or overstating coverage.

The brief is **supportive context** for later skills (model, define, explore). It
adds evidence and orientation. It does **not** speak for the user or settle
product, UX, scope, or acceptance choices.

A complete pass covers **multiple research axes** (not a single corpus). Skills
specialise which axes they implement, tooling per axis, artifact path, and
pipeline handoff.

## What this is not

- Not a user-invokable workflow by itself
- Not alignment / definition of product behaviour (those are other concepts)
- Not a substitute for user answers in define or model — evidence ≠ user intent
- Not implementation
- Not a dump of raw search results without synthesis
- Not a single-corpus scan when the topic needs a wider picture (unless the user
  explicitly scopes to one axis)
- Not a decision log: themes and findings describe sources, not what the project
  will build

## Research axes

An **axis** is a family of sources with a shared retrieval style and reliability
profile. Default research covers **all axes that fit the topic**, then synthesizes
across them. One axis alone (e.g. only preprints) is incomplete unless the user
asked for that scope.

Typical axes (skills may rename or refine):

| Axis | What it covers | Role |
|------|----------------|------|
| **Preprints** | arXiv and similar preprint servers | Fast scholarly signal; not always peer-reviewed |
| **Formal written** | Journals, conference proceedings, books, standards, RFCs, official specs | Stable, citable, often peer-reviewed or normative |
| **Web discovery** | General web search, documentation hubs, indexes, encyclopedic overviews | Breadth, secondary pointers, terminology |
| **Informal / practitioner** | Blogs, engineering posts, talks/slides, repos, forums, industry reports | Practice, gotchas, adoption — weigh carefully |

Skills **must** list their axes and the retrieval path for each. Skipping an axis
requires a reason (out of domain, user exclusion, or proportional depth for a
quick scan).

## Extension contract

Skills that apply this concept **must** define:

| Extension | Purpose |
|-----------|---------|
| **Research axes** | Which axes to cover by default; when an axis may be skipped |
| **Retrieval path** | Mandatory first tool / command sequence **per axis** |
| **Artifact** | Brief filename and required sections |
| **Citation rules** | How claims must trace to retrieved evidence (IDs, URLs, axis label) |

Skills **may** define:

| Extension | Purpose |
|-----------|---------|
| **Domain filters** | Categories, venues, date windows |
| **Depth presets** | Quick scan vs thorough review (axes still plural unless scoped) |
| **Pipeline continuity** | How to attach the brief to a Task / roadmap |
| **Handoff defaults** | Next skill after the brief |
| **Model routing** | When axes run as sub-agents — apply [CONCEPT_DELEGATION](CONCEPT_DELEGATION.md) |

## Model routing (when axes are sub-agents)

If the skill (or harness) runs research axes via sub-agents / `Task` calls, apply
[CONCEPT_DELEGATION](CONCEPT_DELEGATION.md): manager synthesizes and writes the
brief on the parent / high-capability model; axis workers default to the
platform’s top available **low-capability** model; elevate to **high-capability**
only for Demanding synthesis (dense conflicting formal literature, high-stakes
correctness of citations across axes) or after an insufficient value-tier axis
pass. Use the platform catalog (or General).

## Workflow (conceptual)

### 1. Scope the research question

Before searching, pin down (infer defaults when safe; ask once if a wrong assumption
would waste the search):

| Dimension | Clarify if missing |
|-----------|-------------------|
| **Topic** | Core concepts, synonyms, acronyms |
| **Intent** | Survey, seminal works, recent advances, method comparison, gap analysis |
| **Time horizon** | All time, last N years, or explicit window |
| **Domain** | Field / category filters |
| **Depth** | Quick scan vs thorough review |
| **Axes** | Default = all relevant; narrow only if the user asks |
| **Exclusions** | Topics, methods, or axes to skip |

### 2. Plan per axis

For **each** included axis, design complementary queries or targets — not one
monolithic string for the whole pass. Record the plan before executing.

Across axes, prefer complementary coverage (e.g. preprint landmarks + formal
surveys + practitioner writeups) over duplicate hits of the same paper under
different URLs.

### 3. Execute retrieval

Run retrieval for every included axis. Prefer batched retrieval within an axis
(with throttling / dedup when tooling supports it) over many sequential ad-hoc
calls.

Stop an axis when high-quality candidates suffice or additional pages yield
diminishing relevance — then move to the next axis.

### 4. Expand from core seeds

After identifying a small set of **core** sources (any axis), snowball: related
work, authors, standards, citations, “also discussed in…”. Merge into the
candidate pool. Seeds from one axis may expand into another.

### 5. Triage and rank

Score candidates on relevance, recency, centrality (recurrence across queries and
axes), and quality signals. Prefer primary evidence over tertiary summaries.
Produce tiers:

| Tier | Size | Action |
|------|------|--------|
| **Core** | 3–8 | Deep read |
| **Supporting** | 5–15 | Cite with one-line relevance |
| **Peripheral** | rest | Mention only to fill a gap |

Label each item with its **axis** and reliability note (e.g. preprint, peer-reviewed,
practitioner blog).

### 6. Deep read (core)

For each core item, extract from **available evidence only**:

- Problem / gap
- Approach
- Contribution vs prior work
- Evidence (datasets, benchmarks, theorems, case studies)
- Limitations
- Links / identifiers
- Axis + reliability

Do not hallucinate content. If the abstract, page, or metadata is insufficient,
say so.

### 7. Synthesize

Write a brief that includes at least: question, axes covered (and any skipped with
reason), search strategy, executive summary, key sources (mixed axes),
themes/trends, gaps/limitations, recommended reading order, and full citations with
durable links/IDs and axis labels.

Frame synthesis as **what the sources say**, not what the user decided.
Recommended reading order ranks sources to study — it does not prescribe product
scope, architecture, or acceptance criteria for define.

Call out disagreements across axes (e.g. preprint claims vs practitioner reports).

### 8. Hand off

Point to the next skill only when the brief should feed definition, modelling, or
further scoping — otherwise end. Handoff language must treat the brief as
**supportive input**, never as settled alignment.

## Invariants

- **Multi-axis by default.** Cover every relevant axis unless the user scoped to one
  or depth is explicitly quick (then still sample more than one when feasible).
- **Evidence traceability.** Every claim traces to retrieved output.
- **Honest coverage.** Note corpus and reliability limits per axis.
- **Proportional depth.** Quick scans stay light; thorough reviews search + expand
  on each included axis.
- **No fabrication.** Never cite sources not present in retrieval results.
- **Canonical IDs.** Prefer stable identifiers (arXiv ID, DOI, RFC number, durable
  URL) from the skill's data sources.
- **Supportive only.** Research informs; it does not align with the user or close
  divergence points that define / model must resolve with the user.

## Anti-patterns

- Running only a single axis (e.g. arXiv alone) when the topic needs a wider picture
- Many separate retrievals when one batched call would suffice **within** an axis
- Treating the first page of any axis as exhaustive without checking hit counts
- Citing papers or facts not in retrieval output
- Skipping synthesis and dumping raw JSON/HTML
- Treating informal sources as peer-reviewed fact without labeling them
- Writing briefs that sound like product decisions or approved plans for define
- Instructing later skills to treat research conclusions as already-agreed with the user

## Authoring skills that use this concept

1. Instruct the agent to **read this file** on invoke.
2. Fill in the **extension contract** (especially axes + retrieval path per axis).
3. Link: `[CONCEPT_RESEARCH](../concepts/CONCEPT_RESEARCH.md)`.
