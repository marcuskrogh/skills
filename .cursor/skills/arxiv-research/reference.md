# arXiv API reference (for agents)

Official docs: https://info.arxiv.org/help/api/user-manual.html

## Endpoint

```
https://export.arxiv.org/api/query
```

Always use **HTTPS**. No authentication. Response format: Atom 1.0 XML.

## Query parameters

| Parameter | Type | Default | Purpose |
|-----------|------|---------|---------|
| `search_query` | string | — | Boolean search expression |
| `id_list` | CSV | — | One or more arXiv IDs |
| `start` | int | 0 | 0-based offset for pagination |
| `max_results` | int | 10 | Page size (server max 2000; use ≤50 in agent workflows) |
| `sortBy` | enum | relevance | `relevance`, `submittedDate`, `lastUpdatedDate` |
| `sortOrder` | enum | descending | `ascending`, `descending` |

`search_query` and `id_list` can be combined; the API returns IDs that match the query filter.

## Field prefixes (`search_query`)

| Field | Prefix | Example |
|-------|--------|---------|
| All | `all:` | `all:diffusion+model` |
| Title | `ti:` | `ti:"graph+neural+network"` |
| Author | `au:` | `au:lecun` |
| Abstract | `abs:` | `abs:reinforcement+learning` |
| Comments | `co:` | `co:"NeurIPS+2024"` |
| Journal ref | `jr:` | `jr:"Nature"` |
| Report number | `rn:` | `rn:CERN-PH-TH` |
| Category | `cat:` | `cat:cs.LG` |
| arXiv ID | `id:` | prefer `id_list=` instead |

## Boolean operators

- `AND`, `OR`, `ANDNOT` — join with `+` in URLs: `all:transformer+AND+cat:cs.LG`
- Group with parentheses (URL-encode): `%28cat:cs.LG+OR+cat:cs.AI%29`
- Phrases: wrap in `%22...%22` (URL-encoded double quotes)

## Date ranges

```
submittedDate:[YYYYMMDDHHMM TO YYYYMMDDHHMM]
lastUpdatedDate:[YYYYMMDDHHMM TO YYYYMMDDHHMM]
```

URL-encode brackets as `%5B` and `%5D`.

Example (papers submitted in 2024):

```
submittedDate:%5B202401010000+TO+202412312359%5D
```

## arXiv ID formats

- **New style:** `YYMM.NNNNN` (e.g. `1706.03762`)
- **Old style:** `archive/YYMMNNN` (e.g. `hep-th/9711200`) — no subcategory dot
- **Version pin:** append `vN` to `id_list` (e.g. `1706.03762v1`)

## Atom XML fields per `<entry>`

| Path | Maps to |
|------|---------|
| `entry/id` | Abs URL with version; strip `vN` for canonical ID |
| `entry/title` | Title (trim whitespace) |
| `entry/summary` | Abstract (trim whitespace) |
| `entry/published` | v1 submission (ISO 8601) |
| `entry/updated` | Latest version update |
| `entry/author/name` | Author names (preserve order) |
| `entry/arxiv:primary_category[@term]` | Primary category |
| `entry/category[@term]` | All categories |
| `entry/arxiv:comment` | Comments (optional) |
| `entry/arxiv:journal_ref` | Journal reference (optional) |
| `entry/arxiv:doi` | DOI (optional) |
| `entry/link[@rel="alternate"]` | Abstract page |
| `entry/link[@rel="related" @type="application/pdf"]` | PDF URL |

Feed-level:

| Path | Maps to |
|------|---------|
| `feed/opensearch:totalResults` | Total hits for query |
| `feed/opensearch:startIndex` | Current offset |
| `feed/opensearch:itemsPerPage` | Page size |

## Rate limiting

arXiv requests **≤ 1 request per 3 seconds** sustained. Sleep 3 seconds between API calls in loops.

## Example URLs

**Broad topic + category, newest first:**

```
https://export.arxiv.org/api/query?search_query=all:retrieval+augmented+generation+AND+cat:cs.CL&start=0&max_results=25&sortBy=submittedDate&sortOrder=descending
```

**Known paper lookup:**

```
https://export.arxiv.org/api/query?id_list=1706.03762&max_results=1
```

**Author + recent window:**

```
https://export.arxiv.org/api/query?search_query=au:hinton+AND+submittedDate:%5B202301010000+TO+202512312359%5D&max_results=20&sortBy=submittedDate&sortOrder=descending
```

## Shell fetch pattern

```bash
curl -sL "https://export.arxiv.org/api/query?search_query=all:topic&max_results=25"
```

`-sL` follows redirects and suppresses progress noise.

## API limitations (use WebFetch fallback)

These dimensions are **not** searchable via the Atom API:

- DOI lookup
- ORCID lookup
- ACM / MSC classification field search
- "Cross-listed only" filter

For those, open `https://arxiv.org/search/...` with WebFetch, extract IDs, then re-fetch metadata via `id_list=`.

## Common categories

| Code | Area |
|------|------|
| `cs.LG` | Machine learning |
| `cs.CL` | Computation and language |
| `cs.CV` | Computer vision |
| `cs.AI` | Artificial intelligence |
| `cs.RO` | Robotics |
| `stat.ML` | Machine learning (statistics) |
| `math.OC` | Optimization and control |
| `physics.comp-ph` | Computational physics |
| `q-bio` | Quantitative biology |

Full list: https://arxiv.org/category_taxonomy
