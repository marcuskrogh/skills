# Concept: Skill

An invokable skill applies concepts and produces an output. Uninvokable — load
when a skill's On-invoke pointer fires, and from
[writing-for-agents](../writing-for-agents/SKILL.md) when authoring skills.

## Intent

A skill is a function: concepts in, one output out. It can run alone. A
**workflow** chooses the order of skills and how each step uses the previous
output. The skill does not name the skill that follows.

## Leading words

- **input** — an upstream artifact this skill applies. Required inputs are
  defined in this invocation when missing. Supportive inputs are used when
  they exist and skipped when they do not.
- **output** — the markdown spec or other result this skill writes
- **outcome** — the closed result token the workflow reads (`ready`, `built`,
  `CLEAN`, …). Not a skill name
- **successor** — the following skill in a workflow. Workflows own this

## Invariants

- **Function.** Apply the skill's concepts to the subject. Stop when the output
  and outcome exist. If the user must answer before that output exists, end
  the turn on that question. The workflow keeps **Next** on this same skill
  until the output exists.
- **Apply when present.** A required or supportive input that already exists is
  the authority. Use it. Do not rewrite it in this invocation.
- **Define when absent.** A required input that does not exist is written in
  this invocation by applying the concept that produces it, at that concept's
  proportional depth, as the same artifact the producing skill would write.
  Then apply it. Do not name another skill as the way to obtain it.
- **Opening is not an input.** A missing subject (what the user wants this
  skill to do) uses the skill's opening question. That is not an upstream spec.
- **No successor.** Do not write a following skill into the skill, the artifact
  template, or the tracker comment. Record the outcome only.
- **Workflow writes Next.** When a workflow is bound, the workflow contract
  records **Next** from [pipelines.md](../workflow/pipelines.md) after the
  outcome exists. Mode **immediate** runs the next skill in this session.
  Mode **cue** persists **Next** and stops. No bound workflow: **Next** is none.

## Extensions

| Slot | Required | Purpose |
|------|----------|---------|
| **Inputs** | must | Required vs supportive; which concept defines a missing required input |
| **Output** | must | Artifact or other result, plus outcome tokens |
| **Subject** | may | What the skill applies its concepts to |

## Flow

1. **Resolve inputs** — For each required input, apply the file when it exists;
   otherwise define it in this invocation, then apply it. Apply supportive
   inputs that exist. Done when every required input exists and has been applied.
2. **Produce** — Follow the skill's own steps. Done when the output matches the
   skill's completion criterion.
3. **Record the outcome** — Persist the output and the outcome token. Done when
   the workflow transition has been applied ([handoff.md](../workflow/handoff.md)).
