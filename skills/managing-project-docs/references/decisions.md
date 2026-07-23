# Decision Record Lifecycle

## Promote a decision

Promote rationale from a specification or work plan only when it becomes a
durable decision beyond that artifact or needs a distinct owner, lifecycle, or
audience. Otherwise keep it with its current owner.

Keep a local unresolved question in the specification's `Open decisions` while
it blocks that contract. Create a proposed decision record only when a candidate
direction needs a distinct owner, lifecycle, or audience, or spans artifacts.
Link it from the open item. When the decision becomes active, update the
specification and remove the open item; when rejected, retain the open item only
if the question remains unresolved.

A proposed decision is a candidate, not an authoritative current constraint. An
active decision is accepted. Activate only when the user or a named owner or
authority selects it, or when it passes the repository's established acceptance
or review process.

## Preserve path identity

The date in `docs/design/YYYY-MM-DD-<topic>-design.md` is when the record was
first established, including as a proposal. Activation or rejection does not
rename it.

Apply the topology path precedence when creating, moving, or deleting a record
or successor, and its shared retention and lineage rules when superseding one.

For a material successor, create and cross-link a new dated record. If its base
path already owns a different decision, append `-NN` before `.md`, treating the
unsuffixed path as generation `01` and choosing one greater than the highest
suffix in the current tree or Git history.

## Change status

Update a record in place when the governed choice is unchanged and only its
context, rationale, or consequences need clarification. When the choice changes
materially, create and cross-link a successor, then mark the predecessor
`superseded`. Keep a retained decision record at its resolved path.

When an activated or superseded decision changes the current contract, update
the owning specification in the same logical change. The decision owns the
choice and rationale; the specification owns the resulting contract. Treat
disagreement as an unresolved documentation conflict.

Keep a rejected decision while its rejection remains a current material
constraint with an independent owner, lifecycle, or audience. When any decision
no longer constrains the project and has no successor, resolve inbound links and
delete it; Git retains its history.
