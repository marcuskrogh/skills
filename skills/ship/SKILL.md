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

**On invoke:** read [../workflow/SKILL.md](../workflow/SKILL.md),
[../workflow/ship.md](../workflow/ship.md), and
[../workflow/changelog.md](../workflow/changelog.md). After stage detection, read only the
remaining composed skill contracts:
[../implement/SKILL.md](../implement/SKILL.md) and/or
[../review-fix/SKILL.md](../review-fix/SKILL.md). When the remaining tail
includes them, also read [../test/SKILL.md](../test/SKILL.md) and/or
[../harden/SKILL.md](../harden/SKILL.md).

Requires authenticated `gh` + tracker auth.

## Steps

1. **Resolve issue** — Resolve key/URL → single active ISSUES row → ask once; fetch Task, children, Story, PLAN/BUG/TWEAK/REFINE/REWORK/ITERATE, and linked PR. Done when one Task and its delivery state are identified, including an already-Done result.
2. **Detect position** — Apply the [remaining workflow](../workflow/ship.md#remaining-workflow). The order is the bound chain in [pipelines.md](../workflow/pipelines.md). Tell the user the detected position in one short line. Done when exactly one position is selected.
3. **Run the suffix** — Run each later step's full contract, in chain order, including a skill defining a required input that is missing. Mode is **immediate** until closeout or a hard stop. Class **adopt** follows [../adopt/route.md](../adopt/route.md). When Shipping procedure is human review, a CLEAN agent review continues to human review, then fix-forward ([../workflow/human-review.md](../workflow/human-review.md)), and closeout waits until that fix-forward is CLEAN. If that human review is not on the pull request yet, stop on the human review step. Done when automatic shipping reaches a CLEAN agent review, or that fix-forward is CLEAN, or a named hard stop.
4. **Close out** — Run the [closed-loop closeout](../workflow/ship.md#closeout) on the recorded delivery PR, including [changelog](../workflow/changelog.md) detection and entry when the repo maintains one. Done when its closeout criterion holds or merge failure is reported without closing tracker work. A FAILED agent review or a FAILED fix-forward does not merge.

## Tell the user

Task Done (or stop reason); stage detected + steps run; Sub-tasks closed; Story status;
PR URL; closed-loop confirmation when merged; changelog path + entry when updated (or
skip reason when omitted). When the Task is Done, **Next** is none. A later
request that is still wrong is a new iterate or sandbox workflow, not a
successor this skill writes.
