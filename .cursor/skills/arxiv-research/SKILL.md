---
name: arxiv-research
description: >-
  Investigates a user-described research topic through arXiv using the official
  export.arxiv.org Atom API. Plans search strategy, retrieves and triages papers,
  deep-reads the most relevant hits, and delivers a structured research brief with
  citations. Use when the user wants literature review, paper discovery, state of
  the art, or research on a topic via arXiv.
---

# arXiv Research

Systematic literature investigation on arXiv for a user-described topic. Uses the **official arXiv Atom API** (`https://export.arxiv.org/api/query`) — stable, public, no auth, no scraping.

Read [reference.md](reference.md) for query syntax, field prefixes, date ranges, and XML field mapping.

## When to use

- "What does arXiv say about …?"
- Literature review, survey, or state-of-the-art on a topic
- Find seminal or recent papers in a field
- Compare approaches, methods, or trends from preprints
- Resolve or enrich known arXiv IDs in context of a broader question

## Data source (mandatory)

Use the **arXiv Atom API** as the primary retrieval path:

```bash
curl -sL "https://export.arxiv.org/api/query?<params>"
```

Alternatives when Shell is unavailable: `WebFetch` on the same HTTPS URL.

Do **not** scrape `arxiv.org/search` unless the request needs DOI, ORCID, ACM, or MSC lookup (see reference.md). Even then, extract IDs from HTML and re-fetch metadata via the API.

## Workflow

### 1. Scope the research question

Before searching, pin down:

| Dimension | Clarify if missing |
|-----------|-------------------|
| **Topic** | Core concepts, synonyms, acronyms |
| **Intent** | Survey, seminal works, recent advances, method comparison, gap analysis |
| **Time horizon** | All time, last N years, or explicit date window |
| **Domain** | arXiv categories (`cat:cs.LG`, `cat:math.OC`, …) |
| **Depth** | Quick scan (5–10 papers) vs thorough review (25–50+) |
| **Exclusions** | Topics, methods, or application areas to skip |

If the user's message is already specific, infer reasonable defaults and state them briefly. Ask **one** clarifying question only when a wrong assumption would waste the search (e.g. "ML transformers" vs "electrical transformers").

### 2. Plan the search strategy

Design **2–4 complementary queries**, not one monolithic string:

1. **Broad discovery** — `all:` terms + optional `cat:` filter
2. **Title-focused** — `ti:"key phrase"` for landmark papers
3. **Abstract-focused** — `abs:` terms for methodological overlap
4. **Recency slice** — same query + `submittedDate:` window, `sortBy=submittedDate&sortOrder=descending`
5. **Author anchor** (if user names researchers) — `au:lastname`

Record the planned queries in your working notes before executing.

### 3. Execute API searches

For each query:

1. Build the URL (see reference.md).
2. Fetch with `curl -sL` or `WebFetch`.
3. Parse Atom XML: `totalResults`, then each `entry` (title, authors, abstract, dates, categories, links).
4. **Wait ≥ 3 seconds** between requests (arXiv best practice).
5. Paginate with `start` + `max_results` only when `totalResults` exceeds the first page. Use `max_results=25`–`50` per page.

**Default sort:**

| Intent | Sort |
|--------|------|
| Seminal / foundational | `sortBy=relevance` |
| Latest work | `sortBy=submittedDate&sortOrder=descending` |
| Recently updated surveys | `sortBy=lastUpdatedDate&sortOrder=descending` |

Stop fetching when you have enough high-quality candidates for the requested depth, or when additional pages yield diminishing relevance.

### 4. Triage and rank

Merge results across queries. Deduplicate by canonical arXiv ID (strip `vN` suffix).

Score each paper on:

- **Relevance** — matches the scoped question
- **Recency** — `published` date vs time horizon
- **Centrality** — citation proxies: author reputation, title/abstract signals ("survey", "review"), recurrence across queries
- **Quality signals** — clear problem statement, reproducibility mentions, journal_ref / DOI when present

Produce a short ranked shortlist:

| Tier | Size | Action |
|------|------|--------|
| **Core** | 3–8 | Deep read (abstract + metadata; PDF only if user needs detail) |
| **Supporting** | 5–15 | Cite in synthesis with one-line relevance |
| **Peripheral** | rest | Mention only if they fill a gap |

Drop obvious false positives (wrong domain, tangential keywords).

### 5. Deep read (core papers)

For each **Core** paper, extract:

- **Problem** — what gap or question
- **Approach** — method / architecture / theory
- **Contribution** — main claim vs prior work
- **Evidence** — datasets, benchmarks, theorems (from abstract + comment field)
- **Limitations** — stated or inferable caveats
- **Links** — `abs` and `pdf` URLs from Atom `link` elements

Fetch individual records with `id_list=` when you need full metadata for a known ID.

Do not hallucinate paper content. If the abstract is insufficient, say so and offer to fetch the PDF summary.

### 6. Synthesize findings

Deliver a **structured research brief**. Adapt sections to the user's intent; always include citations with arXiv links.

```markdown
# Research brief: <topic>

## Question
<Restated research question and scope>

## Search strategy
<Queries run, categories, date window, result counts>

## Executive summary
<3–6 sentences: main themes, consensus, open questions>

## Key papers
### 1. <Title> ([arXiv:ID](abs_url))
- **Authors:** …
- **Date:** …
- **Category:** …
- **Relevance:** …
- **Takeaway:** …

(repeat for core papers)

## Themes and trends
<Grouped findings: methods, applications, datasets, theory>

## Gaps and limitations
<What arXiv coverage suggests is under-explored or contested>

## Recommended reading order
<Ordered list for someone new to the topic>

## Sources
<Bulleted list of all cited arXiv IDs with abs URLs>
```

### 7. Offer follow-ups

After the brief, offer (only if natural):

- Narrow or broaden the search
- Extend the date window
- Compare two sub-topics
- Track a specific author or method line

## Operational rules

1. **API first** — never default to HTML scraping.
2. **HTTPS + redirects** — always `https://export.arxiv.org/...`; use `curl -sL` or equivalent.
3. **Rate limit** — ≥ 3 s between API calls in a loop.
4. **Trim XML text** — titles and abstracts often have leading whitespace.
5. **Canonical IDs** — store `1706.03762`, not `1706.03762v7`, unless version matters.
6. **Honest coverage** — arXiv is preprints; note peer-review status. Absence of results is a finding.
7. **No fabrication** — every claim about a paper must trace to fetched metadata.
8. **Proportional depth** — a quick scan is 1–2 queries and a short summary; a thorough review uses the full workflow.

## Anti-patterns

- Single vague query (`all:AI`) with no category or date filter
- Ignoring `totalResults` and reporting only the first page as exhaustive
- Citing papers not returned by a search or `id_list` fetch
- Bursting dozens of API requests without throttling
- Scraping search HTML when the API suffices
- Long preamble before delivering findings

## Quick examples

**User:** "Recent work on diffusion models for protein design"

**Agent moves:**
1. Scope: last 2 years, `q-bio` / `cs.LG`, survey depth ~15 papers
2. Queries: `all:diffusion+protein+design+AND+cat:q-bio`, `ti:"protein"+AND+abs:diffusion`, recency slice with `submittedDate`
3. Triage → 5 core, 8 supporting
4. Synthesize brief with themes (structure prediction, sequence design, benchmarks)

**User:** "Find the Transformer paper and related attention work from 2017"

**Agent moves:**
1. `id_list=1706.03762` for canonical paper
2. `all:attention+AND+submittedDate:%5B201701010000+TO+201712312359%5D+AND+cat:cs.CL`
3. Brief positioning Transformer among contemporaneous attention papers
