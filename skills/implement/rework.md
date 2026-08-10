# Implement — rework comparative evaluation

When the Task spec is `REWORK.md`, verification is **comparative**: baseline
(current implementation) vs candidate (rework), against the artifact **Parity
bar**. Suite green alone is not enough. Paste into Implementation / Testing /
verify briefs for rework Tasks. Complements [testing.md](testing.md).

## Required packages (order)

1. **Baseline** — Measure current behaviour on the parity scenarios; record
   commands, inputs, and results (or reuse recorded baseline named in
   `REWORK.md`). Done when baseline numbers/artifacts are durable on the Task/PR.
2. **Candidate** — Implement the intended rework (seam/flag optional when dual
   run in one binary helps). Include tests for the new path. Done when candidate
   is runnable on the **same** scenarios as baseline.
3. **Compare** — Run candidate scenarios; diff vs baseline per metrics and
   tolerances. Done when a written comparison exists (pass/fail per metric).
4. **Reiterate** — Any metric outside the bar → revise candidate (or align with
   the user if the bar itself is wrong) and re-run Compare. Done when every
   parity metric is within bar **or** the user explicitly accepts a named miss.
5. **Verify** — Touched-area (or full) suite + lint per repo norm; PR documents
   baseline, candidate, comparison, and acceptance. Done when checks pass and
   evidence is on the delivery PR.

## Checklist

- [ ] Parity bar from `REWORK.md` is quoted in the package plan (metrics,
      scenarios, tolerances, baseline method)
- [ ] Baseline results recorded before treating the candidate as done
- [ ] Candidate measured on the **same** scenarios / fixtures as baseline
- [ ] Comparison table or equivalent: metric → baseline → candidate → delta →
      within bar? (yes/no)
- [ ] Failures outside the bar triggered rework packages, not a ship of “tests
      green”
- [ ] Suite/lint non-degradation per [testing.md](testing.md)
- [ ] PR test plan links or embeds comparative evidence

## Package report (rework extras)

In addition to the [testing.md](testing.md) report fields:

```text
parity_bar_ref: <section / quote from REWORK.md>
baseline_how: <command or artifact>
baseline_result: <summary or path>
candidate_how: <command>
candidate_result: <summary or path>
comparison: <pass | fail> — <one-line deltas>
reiterations: <count + what changed, or 0>
```
