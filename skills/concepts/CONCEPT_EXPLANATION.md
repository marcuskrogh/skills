# Concept: Explanation

Paced teaching of the current step and its decisions. Uninvokable — load only when a skill's On-invoke pointer fires.

## Intent

Explain in simple terms the current workflow step, a coding or design decision, an interface, a numerical consideration, or recent agent output — whatever the user named or the in-flight work involves. A short explanation completes in one turn. A long one is split into **beats**; each beat waits for **advance**.

## Leading words

- **beat** — one explanation unit (one decision, interface, or numerical point) shown, then waited on when more remain

## Invariants

- **Simple terms.** Established words; introduce specialised tokens on first use ([CONCEPT_LANGUAGE](CONCEPT_LANGUAGE.md)).
- **Why with what.** Each beat covers the fact or step and the decision behind it when a choice was made.
- **Short completes.** If one beat covers the subject, send it and close. Extra beats are not invented.
- **Long is paced.** When more than one distinct decision, interface, or numerical point remains, present one **beat** per turn. Wait for **advance** before the next.
- **Advance continues.** Treat yes, okay, move on, and similarly approving replies as **advance**.
- **Block reevaluates.** Confusion, a wrong assumption, or "that is not what I meant" is a **block**. Adjust remaining beats (or the subject), then present the new current beat.
- **Continue cue.** Each waited beat ends on a short invitation to **advance** or report a **block**.
- **Stay on subject.** Explain the named subject, the current workflow step, or last agent output.
- **Active pace owns the turn.** While an explanation sequence is open, **advance** and **block** stay in this concept. Explicit `/skill` names and **ship** still override.

## Extensions

| Slot | Required | Purpose |
|------|----------|---------|
| **Subject** | must | What is being explained |
| **Stop condition** | must | When the explanation is complete (default: no remaining beats) |
| **Opening** | may | Thin vs rich; missing subject → one question |
| **Sources** | may | Where to read the current step (PLAN, last output, code, …) |
| **Scope guard** | may | Exclusions (which-skill map is help; walkthrough is guidance) |

## Flow

1. **Open** — Resolve subject (user text, current workflow step, last agent output). If missing, ask once. Form remaining **beats** internally. Done when the subject is known.
2. **Pace** — Present one beat (or the whole explanation when it fits one beat). If more remain, wait. **Advance** → next beat. **Block** → reevaluate remaining beats → present the new current beat. Done when **stop condition** holds.
3. **Close** — State that the explanation is complete; hand off. Done when the user has the Next cue (resume in-flight Task, or none).
