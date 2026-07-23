# Project Documentation Topology

- [Topology](#topology)
- [Resolve paths](#resolve-paths)
- [Own information](#own-information)
- [Synchronize specifications](#synchronize-specifications)
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

The date in a decision path is when that decision record was first established,
including when it began as a proposal. Keep that path when the record becomes
active or rejected. When the lifecycle rules call for a successor, create and
cross-link a new dated record. If its base path already owns a different
decision, append `-NN` before `.md`, treating the unsuffixed path as generation
`01` and using one greater than the highest suffix recorded in the current tree
or Git history.

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
- An active specification owns the accepted current contract. A draft
  specification owns a proposed contract in its change context and does not
  claim that the implementation already conforms.
- A decision record owns a material decision with an independent lifecycle and
  links to the affected specification.
- A work plan owns unfinished execution. Add traceability there when many
  requirements, components, or phases need an explicit mapping.
- A handoff owns the current state for one explicit transfer.
- A project boundary remains governance-owned at its governance-resolved path.
  Project documents reference it by link while it is active. Resolve those links
  before closing the boundary.

### Resolve content conflicts

Use an explicit user or repository canonical designation first. Otherwise use
the active canonical artifact that owns the information: a specification for
the current contract, a decision record for the choice and rationale, a work
plan for unfinished execution, a handoff for the current transfer, and a project
boundary for its governance fields. Within the same ownership, prefer active or
current material over draft, superseded, or legacy material; recency alone does
not establish authority. If active canonical artifacts still conflict within
the same ownership, resolve the inconsistency with their named authority or ask
the user rather than choosing by date.

### Promotion boundary

Promote rationale from a specification or work plan to a decision record only
when it becomes a durable decision beyond its originating artifact or needs a
distinct owner, lifecycle, or audience. Otherwise keep it in the owning
specification.

Keep a local unresolved question in the specification's `Open decisions` while
it blocks that contract. Create a proposed decision record only when a candidate
direction needs an independent owner, lifecycle, or audience, or spans
artifacts. Link it from the open item. When the decision becomes active, update
the specification and remove the open item; when it is rejected, retain the
open item only if the question remains unresolved.

## Synchronize specifications

Prefer drafting a new or changed contract before implementation when its
observable behavior, interfaces, invariants, or acceptance can reasonably be
defined. Exploratory implementation may precede a draft, but it does not
establish the contract by itself.

Treat behavior or a choice as accepted only when the user or a named owner or
authority selects it, or when it passes the repository's established acceptance
or review process. Its presence in the implementation does not establish
acceptance.

When changing an existing active specification, write the draft at its canonical
path only in an isolated change context, such as a Git branch, worktree, or
change request, whose integration baseline retains the active version. Do not
move the baseline artifact to legacy or mark it superseded merely to begin the
draft. In a shared current tree without that isolation, keep the active
specification unchanged and carry the intended delta as unfinished work in the
work plan until an isolated context or an explicit user-selected proposal path
is available. A new contract with no active predecessor may begin as a draft at
its resolved canonical path.

An explicit proposal path is temporary and noncanonical unless the user
separately designates it as the successor's canonical path. When accepting an
amendment from a proposal path, transfer the accepted contract to the existing
canonical specification, mark that specification active, redirect links that
should remain current, and delete the proposal. Do not leave both copies active.
If the user separately changes the canonical path, apply the path-move and
inbound-link rules instead.

During implementation, classify each discovery before changing durable
documentation:

- transfer accepted behavior or semantics that affect the current contract to
  the owning specification
- when an accepted material choice or its rationale needs an independent
  lifecycle, record it in a decision record and transfer only the resulting
  contract to the specification
- treat a bug, accidental nonconformance, or temporary workaround as unfinished
  work; do not normalize it by rewriting the specification unless the changed
  contract is explicitly accepted
- omit implementation detail that does not constrain observable behavior,
  interfaces, invariants, acceptance, or authoritative technical semantics

Synchronize at accepted decision points, stable implementation checkpoints, and
before a merge, release, handoff, or completion claim. Intermediate edits need
not keep a draft synchronized moment by moment. Apply an accepted contract
change, its material decision when one exists, and the affected verification in
the same logical change.

Activate a specification only after its open decisions are resolved, the
accepted contract is implemented, and the verification required by its
acceptance supports the affected requirements. Stable evidence references may
point to tests, verification commands, CI checks, or an external evidence
system; keep individual run logs and activity history outside durable
documentation. When a project boundary governs evidence strength or freshness,
link to it rather than redefining those requirements here.

If the implementation, verification, active decisions, and specification
disagree at a synchronization point, treat the disagreement as unresolved.
Do not treat documentation synchronization as complete. When a project boundary
governs the work, surface the disagreement to its completion boundary.

## Manage lifecycle

### Durable

Maintain active specifications and active decision records in place as current
truth. Keep drafts and proposed records visibly marked and apply their accepted
result at activation. Git owns document change chronology; operational logging
owns runtime events.

When a specification draft is rejected or abandoned:

- for a new contract with no active predecessor, resolve its inbound links and
  delete the draft; it has no legacy lifecycle
- for an amendment in an isolated change context, discard the draft change so
  the active integration baseline remains canonical
- for a draft at an explicit proposal path, redirect or remove its inbound links
  and delete it
- before deletion, transfer a still-current material rejection constraint to a
  rejected decision record only when it needs an independent owner, lifecycle,
  or audience

When activating or superseding a decision changes the current contract, update
the owning specification in the same logical change. The decision owns the
choice and rationale; the specification owns the resulting contract. Until
they are synchronized, treat their disagreement as an unresolved documentation
conflict rather than choosing one artifact as complete truth.

When revisiting a decision:

- update it in place when the governed choice is unchanged and only its context,
  rationale, or consequences need clarification
- create and cross-link a successor when the governed choice changes materially,
  then mark the predecessor `superseded`
- when it no longer constrains the project and has no successor, resolve its
  inbound links and delete it; Git retains its history

When superseding a durable artifact, transfer current facts to their owner. Keep
the old artifact while its rationale remains useful, a non-lineage consumer
still references it, or audit requires it. When retaining the old artifact, set
its status to `superseded` and its `Superseded by` field to the new artifact;
set the new artifact's `Supersedes` field to the old one. When not retaining a
superseded specification, do not materialize or mark the predecessor in the
current tree: clear the successor's `Supersedes` field, redirect current links
to the successor, and let Git own the predecessor's history.

Lineage fields do not by themselves require retention. Before deleting a
retained predecessor, update its direct successor: point `Supersedes` to the
predecessor's earlier retained ancestor, or clear the field when none remains.
Redirect other inbound links to the successor, then delete the predecessor.

To retain a superseded specification, preserve the predecessor—the last active
version, not a successor draft—at the next legacy `<topic>-NN.md` path. When a
successor draft already occupies the canonical path in an isolated change
context, materialize the predecessor from the integration baseline or Git at
the legacy path; do not move the successor draft. Otherwise move the active
predecessor to the legacy path before writing the successor at the resolved
canonical path. Update older lineage fields that identified the predecessor at
its former active path so they identify its legacy path. Keep current-contract
links on the canonical path, and apply the directional lineage fields above to
predecessor and successor. Keep a retained decision record at its resolved
decision path.

Keep a rejected decision record while that rejection remains a current material
constraint with an independent owner, lifecycle, or audience. Delete it after
the constraint ends and resolve its inbound links through the path rules.

For legacy code, keep its current contract in the owning specification. Use a
decision record when successor or retirement reasoning needs an independent
lifecycle. Record the target state, affected consumers, relevant recovery
information, and evidence that the contract has retired. When an active
specification's contract retires without a successor, first transfer every
still-current fact and any independently owned retirement decision, resolve its
inbound links, then delete the specification; Git retains its history. Do not
leave a retired contract marked active or invent a successor solely to retain
the file.

### Working

Use a work plan to drive unfinished work. During execution, transfer rationale
as soon as it becomes part of the current contract or an independently owned
decision, then replace its plan detail with a link to the owning specification
or decision record. At closure, transfer any remaining durable facts, then
preserve required execution evidence in the system named by the specification,
repository convention, or active project boundary. Durable documents keep only
stable references or current conclusions, never raw run logs. Do not delete the
plan while it is the only surviving pointer to required evidence. Delete it
after these transfers unless a named next phase continues to use it.

### Transient

Keep one handoff at the resolved canonical path for the current transfer. For
the same transfer, replace its contents in place.

Before deleting a handoff for a completed or abandoned transfer, transfer every
still-current enduring fact to its durable or working owner. Then delete the
stale handoff before writing a new one, carrying forward only still-current
facts and canonical links. A handoff has no legacy lifecycle; after the transfer
and deletion, remove any directory left empty by that deletion.
