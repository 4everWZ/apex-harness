# Project Boundary Record

Use this shape when the boundary must persist. Omit fields that carry no
information.

This is a working governance record, not durable project documentation or an
execution history. At closure, every durable constraint or decision resides
with its owner, no live reference points to the boundary, and the working record
is deleted. A required audit copy has a named owner and retention condition; it
grants no current authority and does not establish freshness for a current
claim.

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

A location change preserves current content and references and leaves one
canonical working record. A project boundary has no legacy lifecycle.

## Risk

- Consequence:
- Affected boundary:
- Condition that raises or lowers the risk:

## Authority

- Authorized mutations or effects:
- Explicit exclusions:
- Authority source or decision:

## Evidence

- Claim to support:
- Required evidence strength and freshness:
- Claim-relevant observed state:
- Claim-relevant inputs outside that state:

Record only the state identity needed to delimit or reproduce the claim. Reuse
evidence while claim-relevant inputs match; otherwise reacquire the affected
evidence.

Re-evaluate the applicable risk, authority, evidence, and completion fields
after a material scope, authority, or claim-relevant input change and before
closure. Update the working record and reacquire affected evidence rather than
carrying a stale boundary across a handoff or resume.

## Completion

- Completion claim:
- Evidence supporting completion:
- Unverified or excluded boundary:
- Remaining risk or required decision:
