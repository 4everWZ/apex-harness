# Project Documentation Topology

- [Topology](#topology)
- [Resolve paths](#resolve-paths)
- [Own information](#own-information)
- [Manage lifecycle](#manage-lifecycle)

## Topology

| Artifact | Lifecycle | Fallback path | Fallback template | Owns |
|---|---|---|---|---|
| specification | durable | `docs/specs/<topic>.md` | `assets/templates/specification.md` | current behavior, interfaces, acceptance, and optional algorithm, data, ML, evaluation, or research semantics |
| decision record | durable | `docs/design/YYYY-MM-DD-<topic>-design.md` | `assets/templates/decision-record.md` | a material design choice, cross-artifact tradeoff, or legacy successor or retirement decision |
| work plan | working | `docs/plans/<topic>.md` | `assets/templates/work-plan.md` | ordered execution, blockers, and optional requirement mapping |
| handoff | transient | `docs/handoffs/<topic>.md` | `assets/templates/handoff.md` | current state for one explicit transfer of work |

Template paths are relative to `managing-project-docs/`.

## Resolve paths

Resolve each artifact path in this order:

1. the repository's established convention for that artifact type
2. an explicit convention in the accepted project documentation
3. the fallback path in the topology table

Recognize an established convention from repository instructions or a document
index that names the path, or from current canonical artifacts of the same type
that consistently use it. Recognize an accepted project convention from an
active specification or decision that explicitly names it.

At the same priority, select the candidate marked canonical or current, then the
candidate linked by current project documents. If candidates remain tied, ask
the user to name the canonical location.

Update an existing canonical artifact at its current path. Use a stable
lowercase kebab-case `<topic>` that names the owned contract, decision, or
outcome.

The date in a decision path is when the decision was established. Update that
record in place while it owns the same decision. Create and cross-link a new
dated record for a materially new decision.

Apply the same path-resolution order to these supporting records:

- retained superseded specification fallback:
  `docs/specs/legacy/<topic>-NN.md`, using the lowest unused two-digit number
  beginning with `01`
- separately persisted project boundary fallback:
  `docs/plans/<topic>-boundary.md`

When moving an artifact, redirect inbound links to its new canonical path or
successor and repair relative links or path references inside the moved file.
When deleting an artifact without a successor, remove its inbound links. Check
that current repository documents no longer reference the old path, then remove
directories left empty by the change.

## Own information

- Start with one canonical artifact. Split when information has a distinct
  owner, lifecycle, or audience.
- Copy the applicable template sections and remove empty placeholders.
- A specification owns the current contract.
- A decision record owns a material decision with an independent lifecycle and
  links to the affected specification.
- A work plan owns unfinished execution. Add traceability there when many
  requirements, components, or phases need an explicit mapping.
- A handoff owns the current state for one explicit transfer.
- A project boundary remains governance-owned. Durable artifacts link to it;
  an active work plan or handoff may carry it for that artifact's lifetime.
  Resolve its links before closing the boundary.

## Manage lifecycle

### Durable

Maintain specifications and decision records in place as current truth. Git
owns their change chronology; operational logging owns runtime events.

When superseding a durable artifact, transfer current facts to their owner and
link the successor while the old rationale remains useful, referenced, or
required for audit. Otherwise delete the obsolete artifact and use Git history.

To retain a superseded specification, move the active file to the next legacy
`<topic>-NN.md` path, set its status to `superseded`, and link its `Superseded
by` field to the successor. Put the successor at the resolved active path and
link its `Supersedes` field to the retained file.

Keep a rejected decision record while that rejection remains a current material
constraint with an independent owner, lifecycle, or audience.

For legacy code, keep its current contract in the owning specification. Use a
decision record when successor or retirement reasoning needs an independent
lifecycle. Record the target state, affected consumers, relevant recovery
information, and evidence that the contract has retired.

### Working

Use a work plan to drive unfinished work. At closure, transfer durable facts to
their specification or decision record, then delete the plan unless a named
next phase continues to use it.

### Transient

Keep one handoff at the resolved canonical path for the current transfer. For
the same transfer, replace its contents in place. For a completed or abandoned
transfer, delete the stale handoff before writing the new one. Carry forward
only still-current facts and canonical links.

A handoff has no legacy lifecycle. After takeover, transfer enduring facts to
their durable owner, then delete the handoff and any directory left empty by
that deletion.
