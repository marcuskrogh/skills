# Concept: Delegation (value-aware model routing)

Before every sub-agent spawn, the **manager** scores **task difficulty** and
assigns a **worker** model for value-efficient execution. Uninvokable — load
only when a skill's On-invoke pointer fires (skills that spawn Task / sub-agents).

## Intent

Keep orchestration on the parent / high-capability session while routing each
worker to the lowest adequate tier. Detect harness → load the matching catalog
from [PLATFORM-CATALOGS.md](PLATFORM-CATALOGS.md) → the matching platform file
(or General) → pick within category from that file only.

## Leading words

- **Routine / Moderate / Demanding** — difficulty tiers → low / mid / high categories
- **Catalog-closed** — only slugs listed in the loaded platform file are legal
- **type** — harness `subagent_type`; type does not pick the model

## Invariants

- **Workers only.** Orchestration, plan merge, severity promotion, tracker/PR, and verification ownership stay on the manager.
- **Score before spawn.** Hardest matching signal wins; no Demanding/Moderate signal → Routine (low).
- **Bias down.** When unclear, prefer lower category. Importance ≠ difficulty.
- **Catalog-closed.** The `model` argument is a slug from the loaded platform file (prefer or fallback column) for the scored category. Harness-wide model lists, “latest of family,” type defaults, and vendor heuristics are not a catalog.
- **Every type.** Every `Task` / sub-agent spawn of any `subagent_type` is a worker spawn for catalog purposes. Type does not select the model.
- **Pass `model`.** When the harness supports per-worker `model`, every spawn of every type includes an explicit catalog slug. Omit / `inherit` only when the harness cannot set per-worker model; still record difficulty.
- **One-tier escalate.** Insufficient report → re-delegate same package one tier up with named gaps. If low and mid resolve to the same model, escalate directly to high.
- **Platform catalog.** Model selection follows the ranked list for the detected harness; General only when the harness is unknown (not Cursor / Claude Code / Codex / Copilot).

## Extensions

| Slot | Required | Purpose |
|------|----------|---------|
| **Default table** | may | Per-axis or package-type defaults — still value-biased |
| **Catalog override** | may | WORKSPACE / skill ranked lists replacing repo defaults |

## Flow

1. **Detect platform** — harness → catalog file. Done when catalog is selected.
2. **Score difficulty** — hardest matching signal → Routine / Moderate / Demanding. Done when tier is recorded.
3. **Assign model** — category from tier → highest-ranked available slug **in that platform file**; confirm the slug is catalog-closed; pass `model` when supported. Done when a legal model is chosen.
4. **Spawn** — full brief + difficulty one-liner + explicit catalog `model` on every type. Done when worker is launched.
5. **Evaluate** — insufficient → escalate one tier with named gaps. Done when report is adequate or high tier exhausted.

## Reference

### Roles

| Role | Model |
|------|-------|
| **Manager** | Parent / top available high-capability **from the platform catalog** |
| **Worker** | Category from difficulty, then highest-ranked available slug in that category |

### Difficulty → category

| Tier | Signals (any one) | Category |
|------|-------------------|----------|
| **Routine** | Localized; clear acceptance; known pattern; docs/rename; checklist Spec | Low |
| **Moderate** | Multi-file well-specified; standard tests; clear Integration; most Implementation/Testing/fix-forward | Mid |
| **Demanding** | Novel/ambiguous design; concurrency/security/crypto; subtle algorithms; large Architecture risk; prior mid miss on same package; high blast-radius API/migration | High |

If mid is unavailable: Moderate → low, then escalate insufficient work to high.

Record in the package plan:

```text
platform: cursor | claude-code | codex | github-copilot | general
difficulty: routine | moderate | demanding
category: low-capability | mid-capability | high-capability
model: <slug-or-alias>
reason: <one short line — deciding signal>
```

### Spawn contract

Each worker call includes: full brief; explicit catalog `model` when supported
(every `subagent_type`); difficulty one-liner. Before spawn, verify `model`
appears in the loaded platform file for the chosen category (prefer or
fallback). Off-catalog — including a type's default model — remap to that
category's top prefer slug, then spawn. When the harness would still run an
off-catalog model for that type, keep the work on the manager.

Load [PLATFORM-CATALOGS.md](PLATFORM-CATALOGS.md), then only the detected
platform file, when assigning models.
