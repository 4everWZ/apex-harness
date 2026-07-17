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

1. an explicit user-selected path
2. the repository's established convention for that artifact type
3. an explicit convention in the accepted project documentation
4. the fallback path in the topology table

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
dated record for a materially new decision. If its base path already owns a
different decision, append `-NN` before `.md`, treating the unsuffixed path as
generation `01` and using one greater than the highest suffix recorded in the
current tree or Git history.

Apply the same path-resolution order to these supporting records:

- retained superseded specification fallback:
  `docs/specs/legacy/<topic>-NN.md`, using one greater than the highest
  generation recorded for that topic in the current tree or Git history,
  beginning with `01`

Before moving an artifact or deleting one with a successor, redirect its inbound
links to the new canonical path or successor. Repair relative links or path
references inside a moved file. When deleting without a successor, remove the
inbound links. Check that current repository documents no longer reference the
old path, then remove directories left empty by the change.

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
- A project boundary remains governance-owned at its governance-resolved path.
  Project documents reference it by link while it is active. Resolve those links
  before closing the boundary.

## Manage lifecycle

### Durable

Maintain specifications and decision records in place as current truth. Git
owns their change chronology; operational logging owns runtime events.

When superseding a durable artifact, transfer current facts to their owner. Keep
the old artifact while its rationale remains useful, a non-lineage consumer
still references it, or audit requires it. Set its status to `superseded` and
its `Superseded by` field to the new artifact; set the new artifact's
`Supersedes` field to the old one.

Lineage fields do not by themselves require retention. Before deleting a
retained predecessor, update its direct successor: point `Supersedes` to the
predecessor's earlier retained ancestor, or clear the field when none remains.
Redirect other inbound links to the successor, then delete the predecessor.

To retain a superseded specification, move the active file to the next legacy
`<topic>-NN.md` path before writing the successor at the resolved active path.
Update older lineage fields that identified the predecessor at its former active
path so they identify its legacy path. Keep current-contract links on the active
path, and apply the directional lineage fields above to predecessor and
successor. Keep a retained decision record at its resolved decision path.

Keep a rejected decision record while that rejection remains a current material
constraint with an independent owner, lifecycle, or audience. Delete it after
the constraint ends and resolve its inbound links through the path rules.

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
