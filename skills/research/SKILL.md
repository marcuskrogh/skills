---
name: research
description: >-
  Multi-axis investigation of a topic: arXiv preprints plus formal written sources,
  web discovery, and informal/practitioner material. Writes RESEARCH.md as
  supportive evidence — not user alignment or product decisions. Links to a
  pipeline Task when given and updates continuity markdown. Use for surveys,
  state of the art, or a wide research pass.
disable-model-invocation: true
---

# Research

Applies [CONCEPT_RESEARCH](../concepts/CONCEPT_RESEARCH.md) as a **multi-axis**
investigation. Optional pipeline side path — feeds **model** / **define** /
**explore** with **supportive** context only.

**On invoke:** read CONCEPT_RESEARCH, [../concepts/CONCEPT_DELEGATION.md](../concepts/CONCEPT_DELEGATION.md)
when spawning axis workers, [reference.md](reference.md),
[../workflow/reference.md](../workflow/reference.md), and
[../tracker/SKILL.md](../tracker/SKILL.md) when a Task key or WORKSPACE exists.

**Default:** all relevant axes. Narrow to one axis only when the user asks; record why.

## Extensions

| Slot | This skill |
|------|------------|
| **Research axes** | Preprints (arXiv), Formal written, Web discovery, Informal / practitioner — all by default |
| **Retrieval path** | See table; arXiv details in [reference.md](reference.md) |
| **Artifact** | `RESEARCH.md` (path from WORKSPACE) |
| **Citation rules** | Every claim → retrieved evidence; durable ID/URL + **axis** label |
| **Pipeline continuity** | Attach to Task; delivery branch when committing |
| **Handoff defaults** | `/model` / `/define` / `/explore` / none |
| **Model routing** | CONCEPT_DELEGATION when axes are workers; synthesis stays on manager |

| Axis | Primary retrieval |
|------|-------------------|
| **Preprints (arXiv)** | `scripts/arxiv_research.py` first ([reference.md](reference.md)); curl/WebFetch API fallback only if Python unavailable |
| **Formal written** | WebSearch → WebFetch durable pages (DOI, publisher, IETF, ISO, W3C, …) |
| **Web discovery** | 2–4 complementary WebSearch queries; WebFetch primary pages |
| **Informal / practitioner** | WebSearch + WebFetch; **always label informal** |

## Steps

Follow CONCEPT_RESEARCH flow. Specialisations:

1. **Scope** — default all four axes; "arXiv only" (etc.) → that axis alone, stated in brief.
2. **Plan** — queries/targets per axis → Search strategy in `RESEARCH.md`.
3. **Execute** — parallel when tools allow; else Preprints → Formal → Web → Informal. Prefer one multi-`-q` arXiv `search` over many script invocations.
4. **Expand / triage / deep read** — per concept; dedupe by DOI / arXiv ID / canonical URL; prefer multi-axis hits.
5. **Artifact + continuity** — below.

## Artifact

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
… (mixed axes; title, axis, ID/URL, one-line relevance)

## Themes and trends
… (agreements / disagreements across axes)

## Gaps and limitations
…

## Recommended reading order
… (sources to study — not a product plan)

## Role in pipeline
Supportive context for `/model` and `/define`. Does **not** settle user alignment.

## Sources
… (full citations + axis)

## Tracker
- Task: <KEY> (if linked)
- Artifact: RESEARCH.md
- Branch: <delivery-branch if committing>
- PR: <url if open>

## Next
`/<skill> <KEY>` — <why>
```

## Pipeline continuity

When a Task key is given/inferred:

1. `attach_or_link` + comment (path, short summary, **Next**); leave status unchanged; no parallel Task.
2. Committing `RESEARCH.md` → [delivery branch continuity](../workflow/reference.md#delivery-branch-continuity-closed-loop) (reuse open branch/PR; never a research-only PR abandoned when define starts). External artifact location → write under external root, push into Task; no branch yet.
3. Update ROADMAP notes / PLAN Inputs when present; upsert ISSUES mirror.

Standalone: still write `RESEARCH.md`; **Next** may be `/explore` or `/define`.

## Handoff

| Context | Next |
|---------|------|
| Math-heavy follow-up | `/model <KEY>` |
| Ready to define with the user | `/define <KEY>` |
| Still scoping | `/explore` |
| Only needed the brief | none |
