# Changelog

## [Unreleased]

- **Added:** A workspace can name a ticket framework and a review standard. Team names, templates, and review checks come from that standard. With nothing named, tracking and review stay as they are. On Jira, an installed `jira-ticket` skill is used unless you name another or set `none`. The ticket framework is applied after define approves the spec, not during the interview. A framework states its four logical status names in a labelled map. A skill name counts only when that skill is already loaded.
