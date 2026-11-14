# Tweak: Replace Copilot's Gemini 4 Argon ceiling with Gemini 4 Carbon

## Summary
- GitHub retires Gemini 4 Argon from Copilot on 2026-12-14. Gemini 4 Carbon replaces it as the preferred Copilot capability ceiling. Gemini 4 Hydrogen does not get a row.

## Desired change
- In the GitHub Copilot catalogue, remove Gemini 4 Argon and name Gemini 4 Carbon as the preferred high-tier ceiling, with the Copilot picker id `gemini-4-carbon`.
- Leave the other high, mid, and low rows in place. Opus 5.5 stays the Anthropic ceiling row. Its prefer cell names Carbon where it used to name Argon.
- Do not add Gemini 4 Hydrogen.

## Where
- `skills/concepts/platforms/github-copilot.md`: cost-split paragraph, high rank 3, and the Opus prefer cell that names the Google ceiling.
- `scripts/validate-skills.ps1`: the Copilot rows that lock Argon as that ceiling.
- Any other line that names Argon specifically as the Copilot ceiling.

## Precedent
- Commit `505c5db` ranked Gemini 4 Argon as this ceiling and locked the row in `scripts/validate-skills.ps1`.

## Pass criteria
- `github-copilot.md` high rank 3 is Gemini 4 Carbon, preferred ceiling, slug `gemini-4-carbon`, and the cost-split paragraph names that ceiling.
- `github-copilot.md` does not name Gemini 4 Argon or `gemini-4-argon`.
- The Opus prefer cell does not name Argon.
- `github-copilot.md` has no Gemini 4 Hydrogen row and no `gemini-4-hydrogen` slug.
- The Copilot ranked sections do not list Claude Fable 5, Claude Haiku 4.5, Gemini 3.8 Flash, Grok 4.6, or Kimi K3.
- `general.md` still lists Gemini 4 Argon. Rule 1 in `PLATFORM-CATALOGS.md` still names Argon as the shared ceiling. `cursor.md`, `claude-code.md`, and `codex.md` do not gain `gemini-4-carbon`.

## Out of scope
- `cursor.md`, `claude-code.md`, `codex.md`, and `general.md`. `general.md` keeps Argon for an unknown harness.
- Rule 1 in `PLATFORM-CATALOGS.md` (shared ceiling, not Copilot-specific).
- Re-ranking Grok 4.7, GPT-6.1 Sol, GPT-6.1 Terra, GPT-6 Sol, Claude Sonnet 5.5, GPT-6 Luna, or Claude Opus 5.5.

## Reasoning
- GitHub changelog, 2026-11-13, retires Gemini 4 Argon from Copilot on 2026-12-14 and names Gemini 4 Carbon as the suggested replacement. The same note retires Claude Fable 5, Claude Haiku 4.5, Gemini 3.8 Flash, Grok 4.6, and Kimi K3. Carbon has been in Copilot since the 2026-11-10 changelog. Hydrogen was added in the 2026-11-13 changelog.
- Copilot picker id `gemini-4-carbon` matches the Google model id in the 2026-11-10 Gemini 4 Carbon developer guide and the GitHub Copilot provider id on models.dev. The catalogue already uses that pattern for Argon (`gemini-4-argon`).
- Artificial Analysis LLM leaderboard, retrieved 2026-11-14. Intelligence Index and cost per task: Gemini 4 Carbon (high) 60 at $5.48; Gemini 4 Argon (high) 50 at $4.97; Gemini 4 Hydrogen (xhigh) 54 at $3.16; Gemini 4 Hydrogen (high) 51 at $1.87; GPT-6.1 Sol (max) 55 at $1.27; GPT-6.1 Terra (max) 51 at $0.96; Claude Opus 5.5 (max) 59 at $10.04.
- Carbon replaces Argon. At high effort the index is 60 versus 50, and cost per task is $5.48 versus $4.97. That is a clearly higher score at a similar cost, so Carbon stays the preferred ceiling after Grok 4.7 and GPT-6.1 Sol.
- Hydrogen gets no row. Hydrogen (high) matches GPT-6.1 Terra (max) at index 51, and Terra costs $0.96 against Hydrogen's $1.87, about half. GPT-6.1 Sol (max) scores 55 at $1.27, which beats Hydrogen (xhigh) at 54 and $3.16. A higher score at several times the price is a worse rank. Do not add a brand that costs more for a small score gain.
- The retiring models stay absent. Fable and Haiku stay banned. Grok 4.7 is already high rank 1. Kimi has no Copilot row.
- Opus 5.5 stays rank 4 because Copilot may rank more than one vendor and this tweak does not re-rank it. Opus (max) at 59 and $10.04 does not beat Carbon (high). The prefer cell only stops naming Argon.
- GitHub's Copilot price sheet lists Carbon and Argon at the same promotional token price through 2026-12-01 ($2 input and $10 output per 1M). From 2026-12-01 Carbon's list price is $4 and $20. The rank uses the Artificial Analysis cost-per-task snapshot above. A later list-price rise would make Carbon more of a ceiling, not an efficient pick.

## Work packages
1. Update the Copilot page and the validator rows that lock this ceiling.

## Tracker
- Task: MD-1
- Branch: cursor/md-1-copilot-carbon-5a46
- PR:

## Classification
- Class: tweak
- Confidence: high
- Why: approved by the catalogue owner as a small catalogue delta

## Workflow
- Template: delta-fast
- Parameters:
  - implement.mode: single
  - implement.verify: tests
  - implement.iteration: one-shot
  - test.mode: dedicated
  - harden.mode: dedicated
  - review.mode: single
  - review.depth: focused
  - review.lasers: sequential
  - side_paths: none
  - sandbox: none
- Chain: architect → implement → test → restructure → review → ship
- Rationale: localized catalogue text; test and harden stay dedicated
