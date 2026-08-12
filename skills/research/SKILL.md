---
name: research
description: >-
  Research across preprint, formal, web, and practitioner axes. Produces a
  citable RESEARCH.md as supportive evidence and links it to a pipeline Task
  when present. Use for surveys, state of the art, or a wide evidence pass.
disable-model-invocation: true
---

# Research

Applies [CONCEPT_RESEARCH](../concepts/CONCEPT_RESEARCH.md) as a **multi-axis**
investigation. Optional pipeline side path — feeds **model** / **define** /
**explore** with **supportive** context only.

**On invoke:** read [CONCEPT_RESEARCH](../concepts/CONCEPT_RESEARCH.md),
[reference.md](reference.md), and
[../workflow/reference.md](../workflow/reference.md), plus
[../workflow/handoff.md](../workflow/handoff.md) when writing **Next**. When
spawning axis workers, also read
[CONCEPT_DELEGATION](../concepts/CONCEPT_DELEGATION.md). When linking the brief
to a Task, also read [../workflow/delivery.md](../workflow/delivery.md),
[../workflow/tracker-sync.md](../workflow/tracker-sync.md),
and [../tracker/SKILL.md](../tracker/SKILL.md).

## Extensions

| Slot | This skill |
|------|------------|
| **Research axes** | Preprints (arXiv), Formal written, Web discovery, Informal / practitioner — all by default |
| **Retrieval path** | See table; arXiv details in [reference.md](reference.md) |
| **Artifact** | `RESEARCH.md` (path from WORKSPACE) |
| **Citation rules** | Every claim → retrieved evidence; durable ID/URL + **axis** label |
| **Pipeline continuity** | Attach to delivery Task when possible; supportive-only route Tasks leave no hanging PR |
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

1. **Scope and plan axes** — Default to all four axes; when the user narrows the pass, record the included axes and reason. Write queries/targets into Search strategy. Done when every included axis has a retrieval plan and every skipped axis has a reason.
2. **Retrieve and synthesize** — Run axes in parallel when tools allow; otherwise Preprints → Formal → Web → Informal. Prefer one multi-`-q` arXiv search, dedupe by DOI / arXiv ID / canonical URL, and prefer multi-axis hits. Done when the CONCEPT_RESEARCH completion bars hold for retrieval, triage, deep read, and synthesis.
3. **Persist and continue** — Write `RESEARCH.md`; when linked, apply delivery continuity and the research tracker row; persist the Handoff when there is a next pipeline step. Done when claims are traceable and the artifact, Task, mirrors, and **Next** agree — with no hanging supportive-only PR.

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
Supportive context for `/model` and `/define`.

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

Follow [delivery continuity](../workflow/delivery.md) when committing and the
[research tracker row](../workflow/tracker-sync.md#matrix). Enrich the existing
**delivery** Task when this brief feeds that key’s define→ship path; leave its
status unchanged. On a **supportive-only** explore route Task, prefer tracker /
external persistence or the downstream delivery head — do not leave an open PR
for this key; at handoff mark the Task **Done** and close any charting PR
without merge ([charting vs delivery](../workflow/delivery.md#charting-vs-delivery)).
Update ROADMAP notes / PLAN Inputs when present. Record the artifact, short
summary, branch/PR (delivery only), **Next**, and enabled mirror.

Standalone: still write `RESEARCH.md`; **Next** may be `/explore` or `/define`.

## Handoff

| Context | Next |
|---------|------|
| Math-heavy follow-up | `/model <KEY>` |
| Ready to define with the user | `/define <KEY>` |
| Still scoping | `/explore` |
| Only needed the brief | none |
