# MD-1: Copilot ceiling is Gemini 4 Neon

| Field | Value |
|-------|-------|
| Type | Task |
| Status | In Review |
| Parent | |
| Children | |
| Artifact | docs/agents/PLAN.md |
| PR | https://github.com/marcuskrogh/skills/pull/76 |
| Created | 2026-11-19 |

## Summary

Gemini 4 Neon becomes the GitHub Copilot preferred ceiling. Gemini 4 Carbon stays the fallback slug on that row. MAI Code 2 and MAI Code 2 Flash do not get a row. The Copilot install extract names GPT-6.1 Terra for moderate work.

## Classification

- Class: tweak
- Confidence: high
- Template: delta-fast
- Parameters: implement.mode single; implement.verify tests; implement.iteration one-shot; test.mode dedicated; harden.mode dedicated; review.mode single; review.depth focused; review.lasers sequential; side_paths none; sandbox none
- Chain: architect → implement → test → restructure → review → ship

## Acceptance

- High rank 3 is Gemini 4 Neon (`gemini-4-neon`) with fallback `gemini-4-carbon`.
- The cost-split sentence and the Opus row name Neon.
- MAI Code 2 and MAI Code 2 Flash are not ranked. The pull request states why.
- The Copilot install extract names GPT-6.1 Terra for moderate work.
- `scripts/test_copilot_catalog.py` and the Copilot locks in `scripts/validate-skills.ps1` pass.
- Cursor, Claude Code, Codex, General, and the catalog index do not gain a Neon or MAI row.

## Comments

### 2026-11-19

Plan pre-approved by Marcus's standing order in the invoke. Do not stop for plan approval. Ticket framework is empty, so the built-in status names stay. Outcome ready. Plan commit `1f1047f`. PR https://github.com/marcuskrogh/skills/pull/76.

MAI Code 2 and MAI Code 2 Flash are not added. GitHub publishes list prices that match GPT-6.1 Terra and GPT-6 Luna. The quality comparison is Microsoft's own bench, and the quoted cost ratio uses the promo price. No independent Artificial Analysis index row was found.

Architect outcome ready. Shape is in `docs/agents/ARCHITECTURE.md`. No new module. Task stays To Do.

Implement outcome built. Single package on the manager (mode single). Rank 3 is Gemini 4 Neon with fallback `gemini-4-carbon`. The install extract names GPT-6.1 Terra for moderate work. MAI Code 2 and MAI Code 2 Flash are not rows.

```text
tests_added_or_updated: scripts/test_copilot_catalog.py; Copilot row locks in scripts/validate-skills.ps1
spec_locks: rank 3 exact row, Neon cost-split sentence, Carbon is not the preferred ceiling, Opus follows Neon, neon slug once, carbon slug once, MAI Code 2 absent, install extract names GPT-6.1 Terra, other catalogues do not gain Neon or MAI
how_to_run: python3 scripts/test_copilot_catalog.py; python3 scripts/test_pipelines.py; bash scripts/test-harness-install.sh; pwsh -File scripts/validate-skills.ps1
result: all four passed
working_surfaces: none — catalogue markdown and string locks
coverage_notes: string locks cover each pass-criteria row
testability_notes: no seam introduced
structure_notes: revealing names and one-thing rows hold on the edited sentences; meets
crap: no function added in the catalogue page; the lock script keeps the existing flat check helper
smells_fixed: none
seams: none deliberately
exceptions: none
```

Test outcome ready. Touched path `scripts/test_copilot_catalog.py`: `main` complexity 7, nested false, flat. CRAP 56 is the zero-coverage formula, not a nested chain. The script runs as a lock and passed. Each pass-criteria row has a string lock. No added test. `python3 scripts/test_copilot_catalog.py`, `python3 scripts/test_pipelines.py`, `bash scripts/test-harness-install.sh`, and `pwsh -File scripts/validate-skills.ps1` passed.

Restructure outcome ready. Touched units are markdown rows and the flat lock script. No catalog breach and no refactoring to apply. Task is In Review.

## Next
`/review MD-1` — focused sequential review of the catalogue diff
