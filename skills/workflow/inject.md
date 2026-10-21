# Injectable standards

Personal skills decide **when** tracker and review work happens. A named
standard decides **how** that work is shaped. Load this file when a skill
reads, writes, or reviews a ticket.

## Fields

Resolve with the workspace ([../setup/format.md](../setup/format.md)):
repository overrides global, field by field.

| Field | Empty | `none` | Name or path |
|-------|-------|--------|--------------|
| **Ticket framework** | Provider is `jira` and a skill named `jira-ticket` is installed → that skill. Otherwise the built-in tracker tables | Built-in tables. On Jira, `docs/agents/jira.md` still applies | That skill or file |
| **Review standard** | [../review/checklist.md](../review/checklist.md) | Same as empty | That skill or file |

Look up a skill name in the skill folders the harness already loads. A path is
repo-relative, or absolute for a global file. Swapping the field is the whole
change. Personal skill files stay as they are.

## Precedence

A named standard wins on conventions: types, status names, templates, naming,
components, labels, and review checks. Personal workflow rules win on timing:
when to read, comment, transition, and which logical transitions are required.
A standard does not drop a transition the bound workflow requires. The workflow
does not replace an explicit convention from the standard with a built-in name.
Say which source you used.

## Missing standard

When the named skill or path does not load, say so once and use the built-in
default. Credentials stay on the tracker backend.

Read the standard at use time. Do not copy its templates, status names, or
checks into personal skill files.

## Tickets

Logical states stay `To Do`, `In Progress`, `In Review`, and `Done`. The
active ticket framework maps those names. Backend tables in
[../tracker/backends/](../tracker/backends/) apply only when no framework is
active.

When a ticket key is known from the user message or the current branch name,
fetch that ticket before acting, then leave it matching the work just done.
Do this for every skill, including a standalone run with no bound workflow.
Scope changes and notable findings go in the description or a comment.

Example: logical **In Review** uses the framework's status for that state. A
`jira-ticket` map that calls the state Ready for Review is the transition
that runs. The built-in Jira row `In Review` is not used for that step.

## Reviews

An active review standard supplies the checks and their names. The review
skill still chooses when review runs, laser order, fix-forward, and
`CLEAN` / `FAILED`. The standard does not skip those steps. The built-in
checklist does not replace checks the standard states.
