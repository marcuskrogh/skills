# Concept: Research

Produce an honest, citable **research brief** on a scoped question across
**multiple research axes** — what is known, recurring themes, gaps, and what to
read next — without fabricating sources. Uninvokable — load only when a skill's
On-invoke pointer fires.

The brief is **supportive context** for later skills. It does not speak for the
user or settle product, UX, scope, or acceptance.

When axes run as workers, also load [CONCEPT_DELEGATION](CONCEPT_DELEGATION.md).

## Leading words

- **axis** — family of sources with a shared retrieval style and reliability profile
- **core / supporting / peripheral** — triage tiers after ranking

## Default axes

| Axis | Covers | Role |
|------|--------|------|
| **Preprints** | arXiv and similar | Fast scholarly signal; not always peer-reviewed |
| **Formal written** | Journals, proceedings, books, standards, RFCs | Stable, citable, often normative |
| **Web discovery** | Search, docs hubs, encyclopedic overviews | Breadth, secondary pointers |
| **Informal / practitioner** | Blogs, talks, repos, forums, industry reports | Practice and gotchas — weigh carefully |

## Invariants

- **Multi-axis by default.** Cover every relevant axis unless the user scoped to one or depth is explicitly quick (still sample more than one when feasible). Skipping an axis needs a reason.
- **Evidence traceability.** Every claim traces to retrieved output.
- **Honest coverage.** Note corpus and reliability limits per axis.
- **Proportional depth.** Quick scans stay light; thorough reviews search + expand on each included axis.
- **No fabrication.** Never cite sources absent from retrieval results.
- **Canonical IDs.** Prefer stable identifiers from the skill's data sources.
- **Supportive only.** Research informs; it does not close divergences define/model must resolve with the user.

## Extensions

| Slot | Required | Purpose |
|------|----------|---------|
| **Research axes** | must | Which axes by default; when one may be skipped |
| **Retrieval path** | must | Mandatory first tool/command sequence **per axis** |
| **Artifact** | must | Brief filename and required sections |
| **Citation rules** | must | How claims trace to evidence (IDs, URLs, axis label) |
| **Domain filters** | may | Categories, venues, date windows |
| **Depth presets** | may | Quick vs thorough (axes still plural unless scoped) |
| **Pipeline continuity** | may | Attach brief to Task / roadmap |
| **Handoff defaults** | may | Next skill after the brief |
| **Model routing** | may | When axes are workers — CONCEPT_DELEGATION |

## Flow

1. **Scope** — topic, intent, time horizon, domain, depth, axes, exclusions. Done when a wrong assumption would not waste the search.
2. **Plan per axis** — complementary queries; record before executing. Done when each included axis has a plan.
3. **Retrieve** — every included axis; prefer batched retrieval within an axis. Done when candidates suffice or diminishing returns.
4. **Expand** — snowball from core seeds across axes. Done when expansion yield flattens.
5. **Triage** — relevance, recency, centrality, quality → core (3–8) / supporting (5–15) / peripheral. Label axis + reliability. Done when tiers assigned.
6. **Deep read (core)** — from available evidence only: problem, approach, contribution, evidence, limitations, IDs. Done when each core item is extracted or marked insufficient.
7. **Synthesize** — question, axes (and skips), strategy, summary, key sources, themes, gaps, reading order, citations. Frame as what sources say — not product decisions. Done when brief meets skill artifact sections.
8. **Hand off** — Next only when the brief should feed model/define/scoping; language treats brief as supportive input.
