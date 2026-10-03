# human review

Chain step when WORKSPACE **Shipping procedure** is `human review`. It is not a
separate workflow and it is not a second agent review. Load this when that step
is current on delivery, iterate, adopt, or the ship suffix.

The agent review (`review`, including its own fix-forward of must-fix findings)
has already ended `CLEAN`. A `FAILED` agent review does not enter this step.

## Wait

1. Leave the delivery pull request open.
2. Wait until a human has submitted a review on that pull request.
3. Do not run lasers. Do not publish an agent code review. Do not edit code in
   this step.
4. Outcome `ready` when that human review is on the pull request.
5. If it is not there yet, this step is unfinished. Stay on this step.

human review is the final review.

## Fix-forward after human review

The next chain step is `fix-forward`. It uses the review procedure on **this**
human review's findings only: always fix them, on the same pull request.

- Do not run lasers.
- Do not publish a code review. human review stays the final review.
- Outcome `CLEAN` when every must-fix finding is addressed, or the review had
  none.
- Outcome `FAILED` when a must-fix finding could not be fixed. Do not merge.

On adopt, re-run the preserve-behaviour gate after this fix-forward. That step
edits code. The same characterize commands have to stay green.
