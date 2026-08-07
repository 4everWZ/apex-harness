# Working Document Lifecycle

## Decide whether a working document is needed

Do not create a work plan for an ordinary single-session change that can be
completed and verified directly. Use one when work must resume across sessions,
multiple contributors or systems must coordinate, ordered dependencies matter,
blockers must remain visible, or the user explicitly requests a persisted plan.

Represent development stages as sections, milestones, or tasks in one plan
unless they have independent owners and lifecycles. Resuming the same work later
is not by itself a handoff; a handoff requires an actual transfer.

## Work plans

Use a work plan to drive unfinished work. During execution, keep only the claim,
evidence state, blockers, and next action needed to resume. Transfer rationale
when it becomes part of the current contract or an independently owned decision,
then replace plan detail with a link to its durable owner.

At closure, transfer remaining durable facts and preserve required execution
evidence in the system named by the specification or repository convention.
Durable documents keep stable references or current conclusions, never raw run
logs. Do not delete the plan while it is the only surviving pointer to required
evidence. A named next phase means the work is still open; otherwise retire the
plan under the topology procedure.

## Handoffs

Keep one handoff at the canonical path for the current transfer and replace its
contents in place for the same transfer.

A handoff is ready to retire only after its transfer completes or is abandoned
and its still-current facts have a durable or working owner. Apply the topology
retirement procedure before writing a new handoff, carrying forward only current
facts and canonical links. A handoff has no legacy lifecycle.
