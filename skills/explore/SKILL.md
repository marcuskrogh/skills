---
name: explore
description: >-
  Exploration through foggy or oversized work. Charts ROADMAP.md plus a Story
  of sequenced route Tasks (one delivery unit by default). Research/model leave
  finding docs on that branch for Next — no separate PRs. Use when the
  destination is felt but the route is not yet visible.
disable-model-invocation: true
---

# Explore

Applies [CONCEPT_ALIGNMENT](../concepts/CONCEPT_ALIGNMENT.md) to **wayfinding** —
charting a course through foggy work. Explore charts; downstream skills walk.

**On invoke:** read [../concepts/CONCEPT_ALIGNMENT.md](../concepts/CONCEPT_ALIGNMENT.md)
and [../workflow/SKILL.md](../workflow/SKILL.md).

## Leading words

- **delivery unit** — one define-typed Task (and its PR) that owns research/model/sandbox artifacts through ship when they share a build
- **finding docs** — `RESEARCH.md` / `MODEL.md` committed on the delivery branch for later skills; never their own PR
- **supportive-only** — explore route Task whose Next advances a different key; no implement/ship on itself

**Chart the route.** Creating a research/model/sandbox/define Task completes a map step;
the frontier's Handoff starts execution.

## Extensions

| Slot | This skill |
|------|------------|
| **Subject** | Vague, foggy, or oversized work |
| **Probes** | Destination (1–2 lines); why it matters; competing framings that change the whole map; fog vs ticket; route step kinds; sequence/deps; out of scope |
| **Stop condition** | Destination named, visible frontier ticketed (with sequence/deps), remaining uncertainty recorded as fog or out of scope — enough to hand off **Next** |
| **Alignment artifact** | `ROADMAP.md` (path from WORKSPACE) — the map |
| **Readiness prompt** | "Does this map capture the destination and the next steps through the fog?" |
| **Opening** | Thin: "What are we trying to find our way to?" Rich: highest-value fog (destination, framing, or first takeable step). Existing map → [Continue the map](#continue-the-map) |
| **Scope guard** | Chart only — no destination implementation; no fake-settled requirements for later skills; tracker writes after approval are charting, not walking; no map-only open PR |

**Divergence here** changes destination, route shape, or Task existence/deps.
Choices that only change how a later skill answers belong on that Task — park a
one-line fog/Task pointer.

## Fog of war

**Fog or ticket?** Can you state the step precisely enough to act on *now* — not
whether you can answer it now.

| Put it here | When |
|-------------|------|
| **Route Task** | Sharp enough to hand to `/define` (preferred), `/research`, `/model`, `/sandbox`, or a concrete unblocker — even if blocked |
| **Not yet specified** (fog) | Sensed but not ticket-sized — do not pre-slice into fake Tasks |
| **Out of scope** | Beyond this destination — never graduates unless destination is redrawn |

Resolving a route Task should clear fog ahead. Re-invoking `/explore` **graduates**
what is now sharp into fresh Tasks.

## Route Task types

| Type | Role | Typical Next on frontier |
|------|------|--------------------------|
| **research** | Evidence finding docs the route waits on | `/research <KEY>` |
| **model** | Math finding docs before (or with) definition | `/model <KEY>` |
| **sandbox** | Isolated inspect-loop for a contained element before production implement | `/sandbox <KEY>` |
| **define** | User-agent alignment on particulars for a buildable slice | `/define <KEY>` |
| **task** | Other unblocker that earns its place by unblocking a later decision | Checklist on the Task |

**One delivery unit by default.** Prefer a **single define-typed route Task**
when research / model / sandbox / define feed the same eventual build — run those
steps on that Task so artifacts land on the same branch define and implement
will use. Prefer **separate route Tasks with dependencies** only
when sequence truly needs independent tickets (parallel owners, research that
may kill the destination, or blockers owned elsewhere).

Wire **Blocked by** after Tasks have keys. A Task is **unblocked** when every
blocker is **Done** (or waived). **Next** = first frontier Task's skill (respect
Order).

**Finding docs, not separate PRs.** Research and model only produce finding
documentation on the delivery branch for whatever follows in **Next** (define,
implement, …). Sandbox produces an isolation tree and `SANDBOX.md` the same way. They
never open their own PRs. Explore does not open a map-only
PR. The only open delivery PR is the define→ship head once define (or a
bug/tweak/refine/rework entry) opens it. Supportive-only route Tasks go **Done**
at handoff after their docs (or isolation tree) are on the downstream delivery branch.

## Artifact

`ROADMAP.md` is an **index**; detail lives on tickets.

```markdown
# Roadmap: [title]

## Destination
<one or two lines>

## Notes
<domain hints; standing preferences>

## Route
| Order | Task | Type | Blocked by | Status | Issue |
|-------|------|------|------------|--------|-------|
| 1 | <title> | research / model / sandbox / define / task | — | To Do | <KEY> |

## Cleared so far
- [<title>](link) — <one-line gist>

## Not yet specified
- …

## Out of scope
- …

## Tracker
- Provider: …
- Story (map): <KEY>
- Tasks: <KEY>, …

## Next
`/<skill> <KEY>` — <frontier title>: <why this step>
```

Keep Destination short. **Not yet specified** stays non-empty whenever honest fog remains.

## Steps

### Chart the map

1. **Align** — Follow CONCEPT_ALIGNMENT with the extensions above. Done when the destination and map stop condition hold.
2. **Classify the route** — Map the visible frontier breadth-first into typed Tasks, fog, and out of scope. Done when every visible item has exactly one classification and dependencies are known.
3. **Handle a clear direct path** — If the work is already small and fog-free, select the direct handoff instead of manufacturing route Tasks. Done when `/define` (preferred front door) or the concrete action is identified.
4. **Approve the map** — Present `ROADMAP.md` with the readiness prompt. Done when the user approves it or names the next divergence.
5. **Persist and hand off** — Apply the explore tracker row and choose the first frontier skill by Order; leave no map-only open PR. Done when Story, Tasks, dependencies, artifact, mirror, and **Next** agree.

### Continue the map

1. **Load and orient** — Read Destination, Route, Cleared, and fog; compare them with tracker state. Done when cleared work and the current frontier are identified.
2. **Rechart** — Graduate sharp fog into Tasks, wire dependencies, and move work beyond the destination to Out of scope. Done when each changed item is classified and every new Task has enough context for its declared skill.
3. **Persist and hand off** — Update ROADMAP, Story, tracker, and ISSUES; choose the new frontier by Order; ensure research/model/sandbox artifacts sit on the delivery branch with no research/model/sandbox PRs. Done when all durable surfaces carry the same route and **Next**, with no hanging charting PRs.

## Tracker (after approval)

Follow the [explore tracker row](../workflow/tracker-sync.md#matrix) using the
configured provider operations. The Story carries Destination + Notes; each
route Task carries Type, question/step, blockers, fog pointers, and skill.
Create dependencies in a second pass after keys exist. New issues stay **To
Do**; close only Tasks newly ruled beyond the destination. Persist `ROADMAP.md`
per [delivery continuity](../workflow/delivery.md) — charting only; no map-only
open PR.

## Handoff

Prefer the frontier's declared type; if several unblocked, lowest **Order** (or ask once when ambiguous):

| Frontier type | Invoke |
|---------------|--------|
| research | `/research <TASK-KEY>` |
| model | `/model <TASK-KEY>` |
| sandbox | `/sandbox <TASK-KEY>` |
| define | `/define <TASK-KEY>` |

Before handing off, confirm research/model/sandbox left artifacts on the delivery
branch only — no research/model/sandbox or explore-only open PRs
([delivery](../workflow/delivery.md#charting-vs-delivery)).

```markdown
## Next
`/<skill> <TASK-KEY>` — <title>: <why this frontier step is next>
```
