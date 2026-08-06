# Research axes reference

Tooling notes for the **research** skill. Do not present during research.

| Axis | Tooling |
|------|---------|
| Preprints (arXiv) | `scripts/arxiv_research.py` (below) |
| Formal written | WebSearch → WebFetch (DOI, publisher, RFC/standards) |
| Web discovery | WebSearch (+ WebFetch of key pages) |
| Informal / practitioner | WebSearch → WebFetch; always label informal |

## Axis 1: arXiv

Prefer `scripts/arxiv_research.py` (stdlib; no MCP). Discover flags and JSON shape
via `python3 scripts/arxiv_research.py --help` and the subcommand's `--help`.

| Command | Purpose |
|---------|---------|
| `search` | One or more `-q` queries; merges and deduplicates |
| `lookup` | Metadata by arXiv ID (`--ids`) |
| `snowball` | Expand from seed IDs via author/category follow-ups |

```bash
python3 scripts/arxiv_research.py search \
  -q 'all:transformer AND cat:cs.LG' \
  -q 'ti:"attention is all you need"' \
  --max-results 50 --sort submittedDate --order descending

python3 scripts/arxiv_research.py lookup --ids 1706.03762,hep-th/9711200

python3 scripts/arxiv_research.py snowball --ids 1706.03762 --max-results 20
```

Prefer one multi-`-q` `search` over many script invocations. The script enforces
**≥ 3 seconds** between API requests — do not parallelise raw `curl` against the
same API.

**Fallback** (Python unavailable): Atom API
`https://export.arxiv.org/api/query` — see
https://info.arxiv.org/help/api/user-manual.html. Extract IDs via WebFetch of
`arxiv.org/search` when the Atom API cannot answer (DOI/ORCID filters, etc.),
then `lookup --ids`.

Common categories: `cs.LG`, `cs.CL`, `cs.CV`, `cs.AI`, `stat.ML`, `math.OC`,
`q-bio` — full taxonomy at https://arxiv.org/category_taxonomy.

## Axes 2–4: web retrieval

**Formal written** — Prefer DOI pages, publisher abstracts, IETF RFCs, W3C/ISO/IEEE
public specs, open surveys with stable URLs. Record title, authors/org, year, DOI
or standard id, peer-review/normative note.

**Web discovery** — Several complementary queries; fetch before deep claims;
encyclopedic pages orient only.

**Informal / practitioner** — Prefer named authors, known labs/companies, or widely
cited posts; capture date and venue; keep the informal label.

## Citation hygiene

| Prefer | Avoid |
|--------|-------|
| arXiv ID, DOI, RFC number, permalink | Rotting homepages; bare search titles |
| Axis label on every citation | Mixing informal with formal unlabeled |
| Quoting only retrieved text | Filling gaps from memory |
