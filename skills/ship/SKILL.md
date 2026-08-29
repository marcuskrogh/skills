---
name: ship
description: >-
  Shipping of all remaining work for a ready-to-build Task. Detects the stage,
  composes implementation, test, harden, and review-fix when needed, then merges
  the delivery PR and completes Done closeout. Use for ship, finish, or
  close-it-out cues.
disable-model-invocation: true
---

# Ship

Orchestrates **remaining** delivery through Done for one pipeline Task. **ship**
is a [continuation keyword](../workflow/reference.md#continuation-keywords):
detect the stage, run only the remaining skills, then close the same delivery
PR after CLEAN.

**On invoke:** read [../workflow/reference.md](../workflow/reference.md),
[../workflow/ship.md](../workflow/ship.md),
[../workflow/changelog.md](../workflow/changelog.md),
[../workflow/delivery.md](../workflow/delivery.md),
[../workflow/tracker-sync.md](../workflow/tracker-sync.md), and
[../tracker/SKILL.md](../tracker/SKILL.md). After stage detection, read only the
remaining composed skill contracts:
[../implement/SKILL.md](../implement/SKILL.md) and/or
[../review-fix/SKILL.md](../review-fix/SKILL.md). When the remaining tail
includes them, also read [../test/SKILL.md](../test/SKILL.md) and/or
[../harden/SKILL.md](../harden/SKILL.md).

Requires authenticated `gh` + tracker auth.

## Steps

1. **Resolve issue** — Resolve key/URL → single active ISSUES row → ask once; fetch Task, children, Story, PLAN/BUG/TWEAK/REFINE/REWORK/ITERATE, and linked PR. Done when one Task and its delivery state are identified, including an already-Done result.
2. **Detect stage → remaining** — Apply the [remaining workflow](../workflow/ship.md#remaining-workflow) and tell the user the detected tail in one short line:

| Evidence | Remaining |
|----------|-----------|
| No ready-to-build artifact | **Stop** — `/define` (or `/iterate`) first; manual `/bug`/`/tweak`/`/refine`/`/rework` also ready-to-build |
| Defined; To Do; no meaningful impl on delivery PR | implement → test → harden → review-fix → closeout |
| In Progress; impl incomplete | finish implement → test → harden → review-fix → closeout |
| In Progress; impl complete; testing phase not done | test → harden → review-fix → closeout |
| In Progress; testing done; harden bound and not done | harden → review-fix → closeout |
| In Review; unresolved REQUEST_CHANGES / must-fix | review-fix → closeout |
| In Review; clean code review **or** no review yet but user wants full finish | review-fix if needed → closeout; else closeout only |
| PR merged; Task not Done | closeout |

   Done when exactly one remaining path is selected.
3. **Run remaining** — Run each selected skill's full contract in order, preserving its delegation and verification rules. Drop `/test` or `/harden` when the binding skips that phase. Done when the tail reaches CLEAN or a named implement/test/harden/review-fix hard stop.
4. **Close out** — Run the [closed-loop closeout](../workflow/ship.md#closeout) on the recorded delivery PR, including [changelog](../workflow/changelog.md) detection and entry when the repo maintains one. Done when its closeout criterion holds or merge failure is reported without closing tracker work.

## Tell the user

Task Done (or stop reason); stage detected + steps run; Sub-tasks closed; Story status;
PR URL; closed-loop confirmation when merged; changelog path + entry when updated (or
skip reason when omitted); Next hint for next phase, `/iterate` when post-ship
straightforward, or `/sandbox` when each turn needs inspectables. No skill
handoff when Task is Done.
