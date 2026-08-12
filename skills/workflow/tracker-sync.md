# Tracker sync matrix

Every pipeline skill updates the configured tracker (and markdown mirror when
enabled). Load when creating issues, transitioning status, commenting, or closing.

## Status chain

```text
To Do / Backlog  →  In Progress  →  In Review  →  Done
  explore/define      implement         implement      ship
  research/model      iterate           iterate
  bug / tweak / refine / rework         review
```

## Matrix

| Skill | Create / update | Status | Comments / links | Close |
|-------|-----------------|--------|------------------|-------|
| **explore** | Story (map) + typed route Tasks; Blocked by; prefer one define-typed delivery Task | Leave **To Do** | Story: child keys + deps + **Next**; ISSUES; no map-only PR | Mis-scoped; any explore-only open PR at handoff |
| **bug** | Task (+ optional Sub-tasks); link BUG.md; start delivery branch/PR | Leave **To Do** | Task: BUG.md + branch/PR + **Next**; ISSUES | — |
| **tweak** | Task (+ optional Sub-tasks); link TWEAK.md; start delivery branch/PR | Leave **To Do** | Task: TWEAK.md + branch/PR + **Next**; ISSUES | — |
| **refine** | Task (+ optional Sub-tasks); link REFINE.md; start delivery branch/PR | Leave **To Do** | Task: REFINE.md + branch/PR + **Next**; ISSUES | — |
| **rework** | Task (+ optional Sub-tasks); link REWORK.md; start delivery branch/PR | Leave **To Do** | Task: REWORK.md + branch/PR + **Next**; ISSUES | — |
| **iterate** | **New** Task; link ITERATE.md; Relates → prior | In Progress → **In Review** when PR ready | Prior + new Task comments; **Next** `/review-fix`; ISSUES | — (ship closes) |
| **research** | Enrich **delivery** Task (preferred); reuse/start delivery when committing on that key | Unchanged on delivery Task; **Done** when supportive-only route Task completes | RESEARCH.md + branch/PR + **Next**; ROADMAP/PLAN/ISSUES; close supportive-only PR without merge | Supportive-only Task after durable handoff |
| **model** | Enrich **delivery** Task (preferred); else create; reuse/start delivery when committing on that key | Leave **To Do** on delivery Task unless further along; **Done** when supportive-only route Task completes | MODEL.md + branch/PR + **Next**; links + ISSUES; close supportive-only PR without merge | Supportive-only Task after durable handoff |
| **define** | Enrich Task; Sub-tasks per package; start/reuse delivery + draft PR; record Classification + Workflow binding | Stay **To Do** | PLAN.md, class, template/params/chain, branch, PR, Sub-task keys, **Next**; ISSUES | — |
| **implement** | May add missing Sub-tasks (incl. Testing); **reuse** delivery | Task → In Progress; Sub-tasks → Done as finished; Task → **In Review** | Session + packages + **same** PR + **Next**; ISSUES | Sub-tasks only — not parent |
| **implement** (fix-forward) | — | In Progress if needed → **In Review** | Threads addressed + **Next**; ISSUES | — |
| **review** | — | Must already be **In Review**; do not Done | Depth + summary + **Next**; ISSUES | — |
| **review-fix** | — | Review publish + fix-forward status (single pass) | After review and after fix-forward; ISSUES | — (ship closes) |
| **ship** | May compose implement / review-fix first | See [ship.md](ship.md) | Task + Story; pre-merge continuity on delivery branch | **Yes** after CLEAN — merge **that** PR; close Task / Sub-tasks / Story when complete |
| **summarise** | — | Read-only (may fix stale mirror **Next** text) | — | — |

## Rules

1. **Always** comment (or markdown Comments) with **Next** when a skill finishes.
2. **Always** upsert `docs/agents/ISSUES.md` when mirror is enabled — same status as the tracker.
3. Provider backends implement `transition` / close natively.
4. **Delivery** Tasks reach **Done** only via **ship**. **Supportive-only** explore
   route Tasks (research/model/task that advance a different key) reach **Done**
   at their skill handoff after any charting PR is closed without merge.
5. Leave no Sub-tasks open after **ship**.
6. Leave no hanging charting / supportive-only open PRs after explore or
   supportive handoff ([delivery.md](delivery.md#charting-vs-delivery)).
