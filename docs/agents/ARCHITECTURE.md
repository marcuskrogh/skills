# Architecture: Pass criteria and spec locks

## Shape
- Lives: `CONCEPT_DEFINITION` (pass criteria); `CONCEPT_IMPLEMENTATION` (spec lock); `implement/testing.md` (checklist)
- Depends on: existing PLAN / BUG / TWEAK / REFINE / REWORK / ITERATE artifacts
- Seams: none (docs)
- Will not add: a testing phase, a define sub-skill, or a new class

## Neighbourhood
- Opened modules/boundaries: definition artifacts, implement testing gate, `/test` analysis, review Spec
- Major refinement (or none): none — keyword and checklist only

## Tracker
- Task: MD-1
- Branch: md-1-spec-lock-pass-criteria
- PR: https://github.com/marcuskrogh/skills/pull/49

## Next
`/restructure MD-1` — Structure pass after implement (`test.mode=skip`)
