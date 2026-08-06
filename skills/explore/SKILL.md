---
name: explore
description: >-
  Clear the fog on a vague or oversized piece of work. Charts a shared map
  (ROADMAP.md + Story) of sequenced, dependent route Tasks — research, model,
  define, and other investigations — then hands off the frontier. Use when the
  destination is felt but the way there is not yet visible.
disable-model-invocation: true
---

# Explore

Applies [CONCEPT_ALIGNMENT](../concepts/CONCEPT_ALIGNMENT.md) to **wayfinding** —
charting a course through foggy work. Explore charts; downstream skills walk.

**On invoke:** read [../concepts/CONCEPT_ALIGNMENT.md](../concepts/CONCEPT_ALIGNMENT.md),
[../workflow/reference.md](../workflow/reference.md), and
[../tracker/SKILL.md](../tracker/SKILL.md).

## Leading words

- **destination** — named end-state this effort is finding its way to
- **fog** — in-scope work felt but not yet ticketable
- **route** — sequenced Tasks that clear fog
- **frontier** — open, unblocked route Tasks

**Plan the route; don't walk it.** Creating a research/model/define Task is not
running that skill. Temptation to just do the work usually means the map's edge
is reached — hand off.

## Extensions

| Slot | This skill |
|------|------------|
| **Subject** | Vague, foggy, or oversized work |
| **Probes** | Destination (1–2 lines); why it matters; competing framings that change the whole map; fog vs ticket; route step kinds; sequence/deps; out of scope |
| **Stop condition** | Destination named, visible frontier ticketed (with sequence/deps), remaining uncertainty recorded as fog or out of scope — enough to hand off **Next** |
| **Alignment artifact** | `ROADMAP.md` (path from WORKSPACE) — the map |
| **Readiness prompt** | "Does this map capture the destination and the next steps through the fog?" |
| **Opening** | Thin: "What are we trying to find our way to?" Rich: highest-leverage fog (destination, framing, or first takeable step). Existing map → [Continue the map](#continue-the-map) |
| **Scope guard** | Chart only — no destination implementation; no fake-settled requirements for later skills; tracker writes after approval are charting, not walking |

**Divergence here** changes destination, route shape, or Task existence/deps.
Choices that only change how a later skill answers belong on that Task — park a
one-line fog/Task pointer.

## Fog of war

**Fog or ticket?** Can you state the step precisely enough to act on *now* — not
whether you can answer it now.

| Put it here | When |
|-------------|------|
| **Route Task** | Sharp enough to hand to `/research`, `/model`, `/define`, or a concrete unblocker — even if blocked |
| **Not yet specified** (fog) | Sensed but not ticket-sized — do not pre-slice into fake Tasks |
| **Out of scope** | Beyond this destination — never graduates unless destination is redrawn |

Resolving a route Task should clear fog ahead. Re-invoking `/explore` **graduates**
what is now sharp into fresh Tasks.

## Route Task types

| Type | Role | Typical Next on frontier |
|------|------|--------------------------|
| **research** | Evidence the route waits on | `/research <KEY>` |
| **model** | Math / formal formulation before (or with) definition | `/model <KEY>` |
| **define** | User-agent alignment on particulars for a buildable slice | `/define <KEY>` |
| **task** | Other unblocker that earns its place by unblocking a later decision | Checklist on the Task |

Prefer **separate route Tasks with dependencies** when sequence matters; prefer
**one define Task** sharing a delivery unit only when research/model clearly belong
to the same unit.

Wire **Blocked by** after Tasks have keys. A Task is **unblocked** when every
blocker is **Done** (or waived). **Next** = first frontier Task's skill (respect
Order). Explore does **not** open delivery branches — downstream skills do.

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
| 1 | <title> | research / model / define / task | — | To Do | <KEY> |

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

1. Name the destination (align until "clear" is sayable).
2. Map frontier breadth-first — typed route steps over vague themes.
3. If no fog (already clear and small) — stop; ask `/define`, `/bug`, or just do the work. Do not invent a map for show.
4. Present ROADMAP; readiness prompt.
5. On approval → Tracker; **Next** = first frontier skill. Session ends.

### Continue the map

1. Load map at low resolution (Destination, Route, Cleared, fog).
2. Orient: what cleared? current frontier?
3. Graduate sharp fog into new Tasks; wire deps; drop graduated patches from fog.
4. Mis-scoped past destination → Out of scope (close those Tasks).
5. Update ROADMAP, Story comment, ISSUES; **Next** = new frontier. Default is rechart and hand off — walk a Task only if the user asks.

## Tracker (after approval)

1. Provider ops via [../tracker/reference.md](../tracker/reference.md).
2. **Story** for the map — Destination + Notes — **To Do**.
3. Each route row → **Task** linked to Story — **To Do**; body: Type, Question/step, Blocked by, fog pointers, which skill — **not** a pre-baked answer.
4. Second pass: record dependencies on parent and child.
5. Story comment with keys, deps, **Next**; upsert ISSUES; write ROADMAP (external root + push into Story when Artifact location is external). Report and end.

| Action | Required |
|--------|----------|
| Create Story + route Tasks | yes (chart) / newly graduated (continue) |
| Link Tasks → Story; type + Blocked by | yes |
| Status | **To Do** for new issues |
| Comment + **Next** on Story | yes |
| ISSUES mirror | yes when enabled |
| Delivery branch/PR | **no** (downstream) |
| Close | only mis-scoped Tasks ruled out of scope |

## Handoff

Prefer the frontier's declared type; if several unblocked, lowest **Order** (or ask once when ambiguous):

```markdown
## Next
`/research <TASK-KEY>` — <title>: evidence this route needs before definition
```

```markdown
## Next
`/model <TASK-KEY>` — <title>: math alignment this route needs next
```

```markdown
## Next
`/define <TASK-KEY>` — <title>: define the first unblocked buildable slice
```
