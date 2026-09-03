# Concept: Guidance

Paced walkthrough of a task the user wants walked. Uninvokable — load only when a skill's On-invoke pointer fires.

## Intent

Walk the user through a manual task — coding they perform, setup, installation, hardware, or any other sequence they asked to be guided on. Show **one step** per turn. Wait for **advance** or a **block** that forces the remaining **sequence** to be reevaluated.

## Leading words

- **step** — one actionable unit shown, then waited on
- **sequence** — remaining ordered steps; kept internal until presented
- **actor** — who performs the current step (user, or agent after this advance)

## Invariants

- **One step per turn.** Each user-facing message presents exactly one current **step**. Remaining steps stay unpublished.
- **Wait.** End the turn after the step. The next step is reached only after **advance**.
- **Advance continues.** Treat yes, okay, move on, and similarly approving replies as **advance**. A successful result or "I did it" is **advance** even without a ritual word.
- **Block reevaluates.** A problem with the current step, a misunderstanding, a failed command, or an environment/hardware mismatch is a **block**. Revise the remaining **sequence**, then present the new current step.
- **Name the actor.** Each step says who acts.
- **Continue cue.** Each waited message ends on a short invitation to **advance** or report a **block**.
- **Understandable.** Short, concrete action.
- **Active pace owns the turn.** While a guidance sequence is open, **advance** and **block** stay in this concept. Explicit `/skill` names and **ship** still override.

## Extensions

| Slot | Required | Purpose |
|------|----------|---------|
| **Subject** | must | The task being walked |
| **Stop condition** | must | When the sequence is complete (default: last step advanced) |
| **Opening** | may | Thin vs rich first move; one environment question when the first fork depends on it |
| **Actor default** | may | Who performs steps unless a step names otherwise |
| **Scope guard** | may | What this walkthrough will not start |

## Flow

1. **Open** — Thin: one question naming the task. Rich (task already named): form the **sequence** internally; if an early fork depends on environment or hardware, ask that one question first; otherwise present step 1. Done when the first step is shown or the opener is asked.
2. **Pace** — Present one step → wait. **Advance** → next remaining step. **Block** → reevaluate remaining sequence → present the new current step. Done when **stop condition** holds.
3. **Close** — State that the task is complete; hand off. Done when the user has the Next cue (resume in-flight Task, or none).
