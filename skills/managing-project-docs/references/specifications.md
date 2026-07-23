# Specification Lifecycle

## Interpret status

An active specification owns the accepted current contract. A draft owns a
proposed contract and does not claim that implementation already conforms.
Active and draft are Git versions of the same canonical artifact; Git owns their
coexistence and history.

## Draft and synchronize

Prefer drafting a new or changed contract before implementation when its
observable behavior, interfaces, invariants, or acceptance can reasonably be
defined. Exploratory implementation may precede a draft, but it does not
establish the contract.

Treat behavior or a choice as accepted only when the user or a named owner or
authority selects it, or when it passes the repository's established acceptance
or review process. Its presence in the implementation does not establish
acceptance.

Classify implementation discoveries before changing durable documentation:

- transfer accepted behavior or semantics that affect the contract to the
  specification
- put an accepted material choice in a decision record only when its rationale
  needs an independent owner, lifecycle, or audience; keep only its resulting
  contract in the specification
- keep bugs, accidental nonconformance, and temporary workarounds as unfinished
  work unless the changed contract is explicitly accepted
- omit implementation detail that does not constrain observable behavior,
  interfaces, invariants, acceptance, or authoritative technical semantics

Synchronize at accepted decision points, stable implementation checkpoints, and
before a merge, release, handoff, or completion claim; a draft need not match
every intermediate edit. Apply an accepted contract change, any independently
owned decision, and affected verification in the same logical change.

Activate only after open decisions are resolved, the accepted contract is
implemented, and its required verification supports the affected acceptance.
Stable evidence references may identify tests, commands, CI checks, or an
external evidence system; keep individual run logs outside durable documents.
When governance owns evidence strength or freshness, link to its boundary
instead of redefining those requirements.

If implementation, verification, active decisions, and the specification
disagree at a synchronization point, keep the disagreement unresolved and do
not treat documentation synchronization as complete. Surface it to an active
project completion boundary when one exists.

## Reject a draft

For a rejected or abandoned draft:

- discard the draft Git version; an existing active version remains canonical
- if no active version exists, resolve inbound links and delete the artifact
- first transfer a still-current rejection constraint to a rejected decision
  record only when it needs an independent owner, lifecycle, or audience

A rejected draft has no legacy lifecycle.

## Supersede or retire

Resolve a retained specification's supporting path with the topology path
precedence, using `docs/specs/legacy/<topic>-NN.md` as its fallback in place of
the topology table's step 4. Choose one greater than the highest generation for
that topic in the current tree or Git history, beginning with `01`.

When retaining a superseded specification, the legacy artifact is the last
active Git version, not the successor draft. Keep the successor at the canonical
path, repair older lineage fields that named the predecessor's former path, and
apply the shared directional lineage rules.

When not retaining a superseded specification, clear the successor's
`Supersedes` field and redirect current links to it. Git history retains the
predecessor.

For legacy code, keep the current contract in its specification. Put successor
or retirement reasoning in a decision record only when it needs an independent
lifecycle. Record the target state, affected consumers, relevant recovery
information, and evidence that the contract retired.

When a contract retires without a successor, transfer every still-current fact
and independently owned retirement decision, resolve inbound links, then delete
the specification. Do not leave a retired contract active or invent a successor
only to retain the file.
