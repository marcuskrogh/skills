---
name: explore
description: >-
  Clear the fog on a vague or oversized piece of work. Charts a shared map
  (ROADMAP.md + Story) of sequenced, dependent route Tasks — research, model,
  define, and other investigations — then hands off the frontier. Use when the
  destination is felt but the way there is not yet visible.
---

# Explore

Applies [CONCEPT_ALIGNMENT](../concepts/CONCEPT_ALIGNMENT.md) to **wayfinding** —
finding a course through foggy work, not charging at the destination.

A loose idea has arrived: too vague, too large, or both. The way from here to the
**destination** is not visible yet. Explore charts that way as a **shared map**,
then sets up a **route** of associated Tasks to be worked **in sequence** (with
dependencies). Resolving those Tasks is what clears the fog — Explore charts;
downstream skills walk.

**On invoke:** read [../concepts/CONCEPT_ALIGNMENT.md](../concepts/CONCEPT_ALIGNMENT.md),
[../workflow/reference.md](../workflow/reference.md), and
[../tracker/SKILL.md](../tracker/SKILL.md) (loads `WORKSPACE.md` + provider backend).

## Intent

Explore is **fog-clearing wayfinding**. The user may bring something extremely
foggy; the agent helps name a destination, surface what is already ticketable,
record the rest as fog, and leave a ordered route for later skills.

| Explore does | Explore does not |
|--------------|------------------|
| Name the **destination** this effort is finding its way to | Execute the destination (build, ship, or lock the final design) |
| Chart a **map** of the exploratory space | Pretend the whole journey is already sharp |
| Create **route Tasks** — research, model, define, and other steps — with sequence and dependencies | Pre-answer what `/research`, `/model`, or `/define` must still ask or find |
| Leave **fog** and **out of scope** explicit | Force fog into fake tickets just to look complete |
| Hand off the **frontier** (first takeable Task) | Resolve more than charting requires in this session |

**Plan the route; don't walk it.** Creating a research/model/define Task is not the
same as running that skill. The pull to just do the work usually means the map's
edge is reached — hand off.

## Extension contract

| Extension | This skill |
|-----------|------------|
| **Subject** | A vague, foggy, or oversized piece of work — initiative, feature, migration, investigation, or anything else that fits the shape |
| **Probes** | See [Probes](#probes) |
| **Stop condition** | Destination is named, the visible frontier is ticketed (with sequence/deps), and remaining uncertainty is recorded as fog or out of scope — enough to hand off **Next** |
| **Alignment artifact** | `ROADMAP.md` (path from WORKSPACE) — the map |
| **Readiness prompt** | "Does this map capture the destination and the next steps through the fog?" |

### Probes

Stay as coarse as the fog allows. Prefer orientation that shapes the **route**:

- What reaching the end looks like (**destination** — one or two lines)
- Why this matters / what itch or pressure brought it here (one sentence)
- Competing framings that would change the **whole map**, not a single later detail
- What is already sharp enough to ticket vs still dim (**fog vs ticket**)
- What kinds of step the route needs: research, model, define, or other work that unblocks a decision
- Rough **sequence** and **dependencies** among those steps (what blocks what)
- What is consciously **out of scope** for this destination

**Do not** use Explore to:

- Fully specify product scope, acceptance, APIs, schemas, or UX flows (that is `/define` on a define Task)
- Run the literature pass or lock math (that is `/research` / `/model` on those Tasks)
- Implement, prototype the destination, or ship
- Invent a dense fake roadmap when the honest view is still mostly fog

When tempted to ask a highly specific question, ask instead whether that question
belongs as a **route Task** (and of which type) — or still as fog.

### Opening

| Context | First move |
|---------|------------|
| **Thin** | "What are we trying to find our way to?" |
| **Rich** | One question on the highest-leverage fog: destination, framing, or which first step is takeable — never a packed questionnaire |
| **Existing map** (Story key / `ROADMAP.md` / URL) | Load the map; enter [Continue the map](#continue-the-map) |

### Scope guard

- No production implementation of the destination
- No pretending fog is settled
- No filling the map with settled requirements that later skills should still probe
- Charting may create tracker issues and write `ROADMAP.md` after approval — that is not "doing the destination"

### Divergence discipline

A divergence point **in explore** is a choice that changes the **destination**, the
**shape of the route**, or **which Tasks exist / how they depend**. Choices that only
change how a later research/model/define Task would be answered belong on that
Task — park a one-line pointer in fog or on the Task body, don't settle them here.

## Fog of war

The map is **deliberately incomplete**. Beyond live route Tasks lies fog — work you
can feel coming but cannot yet pin down, because it hangs on questions still open.

**Fog or ticket?** The test is whether you can state the step or question
**precisely enough to act on** now — not whether you can answer it now.

| Put it here | When |
|-------------|------|
| **Route Task** | The step is sharp enough to hand to `/research`, `/model`, `/define`, or a concrete unblocker Task — even if blocked by another Task |
| **Not yet specified** (fog) | You can sense an area ahead but cannot yet phrase a ticket-sized step. Don't pre-slice fog into fake Tasks |
| **Out of scope** | Beyond this destination. Scope, not sharpness. Never graduates unless the destination is redrawn |

Resolving a route Task (via its skill) should clear fog ahead of it. Re-invoking
`/explore` on the map **graduates** whatever is now sharp into fresh Tasks.

## Route Task types

Each child Task of the map Story is one step on the route. Name it by **title** in
narration (wrap the key/link inside the name). Mark the type in the Task body and
on the map.

| Type | Role | Typical Next when it is on the frontier |
|------|------|-----------------------------------------|
| **research** | Evidence or literature the route waits on | `/research <KEY>` |
| **model** | Math / formal formulation to align before (or with) definition | `/model <KEY>` |
| **define** | User-agent alignment on particulars for a buildable slice | `/define <KEY>` |
| **task** | Other unblocker — access, data shape, spike note, checklist — that earns its place by unblocking a later decision, not by delivering the destination | Precise checklist in the Task; human or agent as appropriate |

A **define** Task remains the pipeline owner from definition through ship for that
slice (same continuity rules as before). Research/model Tasks may stand alone on
the route, or enrich a define Task when the map says they share one key — prefer
**separate route Tasks with dependencies** when sequence matters and the work is
distinct; prefer **one define Task** with research/model as prior Next only when
they clearly share the same delivery unit.

### Dependencies and the frontier

Wire **Blocked by** / depends-on after Tasks have keys (second pass). Use the
provider's native blocking or relates when available; always also record deps on
the map and in each Task body so the route is readable everywhere.

- A Task is **unblocked** when every Task blocking it is **Done** (or explicitly waived).
- The **frontier** is the open, unblocked route Tasks — the edge of the known.
- **Next** after charting is the first frontier Task's skill (respect declared sequence).

Explore does **not** open a delivery branch/PR for route Tasks. Research / model /
define start or reuse delivery continuity when they run.

## Alignment artifact (the map)

`ROADMAP.md` is an **index**, not a store. Detail lives on the tickets; the map
gists and links.

```markdown
# Roadmap: [title]

## Destination
<what reaching the end looks like — one or two lines; every later session orients here>

## Notes
<domain hints; standing preferences; skills every session on this map should respect>

## Route
| Order | Task | Type | Blocked by | Status | Issue |
|-------|------|------|------------|--------|-------|
| 1 | <title> | research / model / define / task | — | To Do | <KEY> |
| 2 | <title> | define | <KEY of 1> | To Do | <KEY> |

## Cleared so far
<!-- one line per completed route Task: gist + link — do not restate the full answer -->
- [<title>](link) — <one-line gist>

## Not yet specified
<!-- in-scope fog: suspected questions/areas, still too dim to ticket -->
- …

## Out of scope
<!-- consciously beyond this destination; does not graduate -->
- …

## Tracker
- Provider: markdown | jira | github | linear
- Story (map): <KEY>
- Tasks: <KEY>, …

## Next
`/<skill> <KEY>` — <frontier Task title>: <why this is the next step through the fog>
```

Keep **Destination** short. Route rows are steps, not mini-plans. **Not yet
specified** should be non-empty whenever honest fog remains.

## Invocation

Two modes. Charting creates the map; continuing graduates fog after the route has
moved. Prefer **not** resolving downstream skill work inside Explore — hand off.

### Chart the map

User invokes with a loose idea (no existing map).

1. **Name the destination.** Align until you can say what "clear" looks like for
   this effort. The destination fixes scope.
2. **Map the frontier breadth-first.** Surface takeable steps and dim areas across
   the whole space — not a deep dive on one thread. Prefer typed route steps over
   vague theme labels.
3. **If there is no fog** — the way is already clear and small enough for one
   session — stop. Ask how they want to proceed (`/define`, `/bug`, or just do the
   work). Do not invent a map for show.
4. Present `ROADMAP.md` (Destination, Notes, draft Route, fog, out of scope). Ask
   the readiness prompt.
5. On approval → [Tracker](#tracker-after-approval): create Story + Tasks, wire
   dependencies, set **Next** to the first frontier skill. Session ends on handoff.

### Continue the map

User invokes with an existing map (Story key, `ROADMAP.md`, or equivalent).

1. Load the **map** at low resolution — Destination, Route table, Cleared, fog —
   not every Task body.
2. Orient: what cleared since last time? What is the current frontier?
3. Graduate fog that is now sharp into new route Tasks (create-then-wire deps);
   remove graduated patches from **Not yet specified**.
4. If a resolution showed something sits past the destination, move it to **Out of
   scope** (close mis-scoped Tasks rather than leaving them on the route).
5. Update `ROADMAP.md`, Story comment, ISSUES mirror; set **Next** to the new
   frontier. Do not run `/research` / `/model` / `/define` unless the user
   explicitly wants this session to walk a Task — default is rechart and hand off.

## Tracker (after approval)

1. Resolve provider ops via [../tracker/reference.md](../tracker/reference.md).
2. Create a **Story** for the map — Destination + Notes summary — status **To Do**.
3. For each route row, create a **Task** linked to the Story — status **To Do**.
   Task body includes: **Type**, **Question / step** (one session-sized prompt),
   **Blocked by** (keys or "none"), open fog pointers for that step, and which
   skill should run it — **not** a pre-baked answer.
4. Second pass: `link` / record dependencies so blockers are visible on parent and
   child.
5. `comment` on the Story with child keys, dependency sketch, and **Next**; upsert
   ISSUES mirror (Story + all Tasks).
6. Write/update `ROADMAP.md` (under the external artifact root, pushing its content
   into the Story, when **Artifact location** is `external`); report names (with
   keys/URLs) and **Next**. Session
   ends.

### Tracker duties

| Action | Required |
|--------|----------|
| Create Story + route Tasks | yes (chart) / yes for newly graduated Tasks (continue) |
| Link Tasks → Story | yes |
| Record type + Blocked by on each Task | yes |
| Status | **To Do** for new issues |
| Comment + **Next** on Story | yes |
| ISSUES mirror upsert | yes when enabled |
| Delivery branch/PR for a phase | **no** (downstream skills) |
| Close anything | only mis-scoped Tasks ruled out of scope |

### Handoff

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

Prefer the frontier's declared type. If several Tasks are unblocked, pick the
lowest **Order** (or ask once when order is genuinely ambiguous).

## Examples

User: `/explore` — I want to add forecasting to our energy platform.

Agent: What does "done" look like for this effort — a decision on whether to invest,
a defined first slice customers can use, or something else?

*(Not: which models, which data sources, which UI, or acceptance criteria — unless
those answers are required just to name the destination or the first route step.)*

---

User: We know we'll need a literature pass on probabilistic forecasts, then agree
the math, then define a narrow ops-facing wedge.

Agent: Charts Destination; Route: (1) research Task → (2) model Task blocked by 1 →
(3) define Task blocked by 2; fog for later slices; **Next** `/research <KEY>`.
