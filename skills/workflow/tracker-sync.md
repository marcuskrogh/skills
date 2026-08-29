# Tracker sync matrix

Every pipeline skill updates the configured tracker (and markdown mirror when
enabled). Load when creating issues, transitioning status, commenting, or closing.

## Status chain

```text
To Do / Backlog  →  In Progress  →  In Review  →  Done
  explore/define      implement         harden         ship
  research/model      iterate           review
  sandbox             test              review-fix
  bug / tweak / refine / rework
```

## Matrix

| Skill | Create / update | Status | Comments / links | Close |
|-------|-----------------|--------|------------------|-------|
| **explore** | Story (map) + typed route Tasks; Blocked by; prefer one define-typed delivery Task | Leave **To Do** | Story: child keys + deps + **Next**; ISSUES; no map-only PR | Mis-scoped; any explore-only open PR at handoff |
| **bug** | Task (+ optional Sub-tasks); link BUG.md; start delivery branch/PR | Leave **To Do** | Task: BUG.md + branch/PR + **Next**; ISSUES | — |
| **tweak** | Task (+ optional Sub-tasks); link TWEAK.md; start delivery branch/PR | Leave **To Do** | Task: TWEAK.md + branch/PR + **Next**; ISSUES | — |
| **refine** | Task (+ optional Sub-tasks); link REFINE.md; start delivery branch/PR | Leave **To Do** | Task: REFINE.md + branch/PR + **Next**; ISSUES | — |
| **rework** | Task (+ optional Sub-tasks); link REWORK.md; start delivery branch/PR | Leave **To Do** | Task: REWORK.md + branch/PR + **Next**; ISSUES | — |
| **iterate** | **New** Task; link ITERATE.md; Relates → prior | In Progress (implement/test); **In Review** after harden | Prior + new Task comments; **Next** `/test`; ISSUES | — (ship closes) |
| **research** | Enrich **delivery** Task; commit `RESEARCH.md` on delivery branch (**no PR**) | Unchanged on delivery Task; **Done** when supportive-only route Task completes | RESEARCH.md path + branch + **Next**; ROADMAP/PLAN/ISSUES | Supportive-only Task after docs are on the delivery branch |
| **model** | Enrich **delivery** Task; commit `MODEL.md` on delivery branch (**no PR**) | Leave **To Do** on delivery Task unless further along; **Done** when supportive-only route Task completes | MODEL.md path + branch + **Next**; links + ISSUES | Supportive-only Task after docs are on the delivery branch |
| **sandbox** | Enrich **delivery** Task; commit `SANDBOX.md` + isolation tree on delivery branch (**no PR**) | Unchanged on delivery Task; **Done** when supportive-only route Task completes | SANDBOX.md path + isolation path + branch + **Next**; PLAN/ISSUES | Supportive-only Task after harness is on the delivery branch |
| **sandbox** (post-merge) | **New** Task; link SANDBOX.md; Relates → prior; branch from base (**no PR**) | Leave **To Do** until implement | Prior + new Task comments; **Next** `/sandbox` or `/implement`; ISSUES | — (ship closes after implement) |
| **define** | Enrich Task; Sub-tasks per package; start/reuse delivery + draft PR; record Classification + Workflow binding | Stay **To Do** | PLAN.md, class, template/params/chain, branch, PR, Sub-task keys, **Next**; ISSUES | — |
| **implement** | May add missing Sub-tasks (incl. Testing); **reuse** delivery | Task → In Progress; Sub-tasks → Done as finished; stay **In Progress** after Build (closeout gate then `/test`) | Session + packages + **same** PR + **Next**; ISSUES | Sub-tasks only — not parent |
| **implement** (fix-forward) | — | In Progress if needed → **In Review** | Threads addressed + **Next**; ISSUES | — |
| **test** | May add Testing Sub-tasks | Stay **In Progress**; Next `/harden` | Testing outcome + **Next**; ISSUES | — |
| **harden** | May add Harden Sub-tasks | **In Review** when the structure pass completes (or skip) | Harden outcome + **Next** `/review-fix`; ISSUES | — |
| **review** | — | Must already be **In Review**; do not Done | Depth + lasers + summary + **Next**; ISSUES | — |
| **review-fix** | — | Laser + code-review publish + fix-forward status | After lasers, after code review, and after fix-forward; ISSUES | — (ship closes) |
| **ship** | May compose sandbox / implement / test / harden / review-fix first | See [ship.md](ship.md) | Task + Story; pre-merge continuity on delivery branch | **Yes** after CLEAN — merge **that** PR; close Task / Sub-tasks / Story when complete |
| **summarise** | — | Read-only (may fix stale mirror **Next** text) | — | — |
| **guide** | — | — | Chat Next only (resume in-flight) | — |
| **explain** | — | — | Chat Next only (resume in-flight) | — |

## Rules

1. **Always** comment (or markdown Comments) with **Next** when a skill finishes — except **guide** and **explain** (chat Next only).
2. **Always** upsert `docs/agents/ISSUES.md` when mirror is enabled — same status as the tracker.
3. Provider backends implement `transition` / close natively.
4. **Delivery** Tasks reach **Done** only via **ship**. **Supportive-only** explore
   route Tasks (research/model/sandbox/task that advance a different key) reach **Done**
   at their skill handoff once finding docs (or the sandbox harness) are on the
   downstream delivery branch (research/model/sandbox never open a PR).
5. Leave no Sub-tasks open after **ship**.
6. Research / model / sandbox / explore charting leave **no** open PRs of their own
   ([delivery.md](delivery.md#charting-vs-delivery)).
