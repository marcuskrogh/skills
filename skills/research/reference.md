# Research axes reference

Tooling notes for the **research** skill. Do not present during research.

| Axis | Tooling |
|------|---------|
| Preprints (arXiv) | `scripts/arxiv_research.py` |
| Formal written | WebSearch → WebFetch (DOI, publisher, RFC/standards) |
| Web discovery | WebSearch (+ WebFetch of key pages) |
| Informal / practitioner | WebSearch → WebFetch; always label informal |

## Axis 1: arXiv

Prefer `scripts/arxiv_research.py` (stdlib; no MCP). Discover commands, flags, and
JSON shape via `python3 scripts/arxiv_research.py --help` and each subcommand's
`--help`. Prefer one multi-query `search` over many script invocations. Honour the
script's rate limit (≥ 3s between API requests).

**Fallback** (Python unavailable): Atom API
`https://export.arxiv.org/api/query` — see
https://info.arxiv.org/help/api/user-manual.html. Extract IDs via WebFetch of
`arxiv.org/search` when the Atom API cannot answer, then script `lookup`.

Category taxonomy: https://arxiv.org/category_taxonomy.

## Axes 2–4: web retrieval

**Formal written** — Prefer DOI pages, publisher abstracts, IETF RFCs, W3C/ISO/IEEE
public specs, open surveys with stable URLs. Record title, authors/org, year, DOI
or standard id, peer-review/normative note.

**Web discovery** — Several complementary queries; fetch before deep claims;
encyclopedic pages orient only.

**Informal / practitioner** — Prefer named authors, known labs/companies, or widely
cited posts; capture date and venue; keep the informal label.

## Citation hygiene

Prefer durable IDs (arXiv ID, DOI, RFC, permalink) with an **axis** label on every
citation. Quote only retrieved text.
