# Tracker sync matrix

Every pipeline skill updates the configured tracker (and markdown mirror when
enabled). Load when creating issues, transitioning status, commenting, or closing.

## Status chain

```text
To Do / Backlog  →  In Progress  →  In Review  →  Done
  explore/define      implement         implement      ship
  research/model      iterate           iterate
  bug                                   review
```

## Matrix

| Skill | Create / update | Status | Comments / links | Close |
|-------|-----------------|--------|------------------|-------|
| **explore** | Story (map) + typed route Tasks; Blocked by | Leave **To Do** | Story: child keys + deps + **Next**; ISSUES | Mis-scoped only |
| **bug** | Task (+ optional Sub-tasks); link BUG.md; start delivery branch/PR | Leave **To Do** | Task: BUG.md + branch/PR + **Next**; ISSUES | — |
| **iterate** | **New** Task; link ITERATE.md; Relates → prior | In Progress → **In Review** when PR ready | Prior + new Task comments; **Next** `/review-fix`; ISSUES | — (ship closes) |
| **research** | Enrich pipeline Task; reuse/start delivery when committing | Unchanged (usually **To Do**) | RESEARCH.md + branch/PR + **Next**; ROADMAP/PLAN/ISSUES | — |
| **model** | Enrich Task (preferred); else create; reuse/start delivery when committing | Leave **To Do** unless further along | MODEL.md + branch/PR + **Next**; links + ISSUES | — |
| **define** | Enrich Task; Sub-tasks per package; start/reuse delivery + draft PR | Stay **To Do** | PLAN.md, branch, PR, Sub-task keys, **Next**; ISSUES | — |
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
4. Pipeline Task reaches **Done** only via **ship**.
5. Leave no Sub-tasks open after **ship**.
