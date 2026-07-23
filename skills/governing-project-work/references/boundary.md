# Project Boundary Record

Use this shape when the boundary must persist. Omit fields that carry no
information.

This is a working governance record, not durable project documentation or an
execution history. Maintain it in place only while the governed work is active.
At closure, transfer any still-current durable constraint or decision to its
owner, resolve every live reference to the record, then delete it. If independent
audit retention is required, transfer a frozen copy to a named audit system or
convention with an owner and retention condition, confirm the transfer, and
delete the working record. The audit copy grants no current authority and does
not by itself satisfy evidence freshness for a current claim.

## Path

When persisting the record in the repository, resolve its path in this order:

1. an explicit user-selected path
2. a repository instruction that names the project-boundary convention
3. the existing canonical boundary for the same subject
4. `docs/plans/<topic>-boundary.md`

At the same priority, select the candidate marked canonical or current, then the
candidate linked by current project documents. If candidates remain tied, ask
the user to name the canonical path.

Use a stable lowercase kebab-case `<topic>` that names the governed subject.

When an active boundary must move to a newly resolved path, transfer its current
content to that path, redirect every live reference, and confirm that the new
copy is the only canonical working record before deleting the old copy. If both
paths contain current edits, resolve or merge them through the named authority
instead of choosing by path priority alone. A project boundary has no legacy
lifecycle.

## Risk

- Consequence:
- Affected boundary:
- Condition that raises or lowers the risk:

## Authority

- Authorized file mutations:
- Authorized Git mutations:
- Authorized external effects:
- Explicit exclusions:
- Authority source or decision:

## Evidence

- Claim to support:
- Required evidence strength:
- Observed `HEAD`:
- `git status --short --branch` summary:
- Staged and unstaged diff summary:
- Explicit claim-relevant generated, ignored, external, or other Git-invisible inputs:

These Git summaries locate observed state; they are not content identities.
Freshness is established by verification, not by a timestamp or generalized
snapshot metadata. Reuse evidence only while claim-relevant inputs are known to
match; otherwise reacquire only the affected evidence.

Re-evaluate the applicable risk, authority, evidence, and completion fields
after a material scope, authority, or claim-relevant input change and before
closure. Update the working record and reacquire affected evidence rather than
carrying a stale boundary across a handoff or resume.

## Completion

- Completion claim:
- Evidence supporting completion:
- Unverified or excluded boundary:
- Remaining risk or required decision:
