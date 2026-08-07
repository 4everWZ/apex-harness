# Specification Lifecycle

## Select the contract boundary

A specification represents a stable contract, not the chronology of developing
it. Prefer one active specification for one coherent contract. Give an internal
algorithm, stage, or module its own specification only when it has an
independently maintained behavioral contract and at least one of independent
acceptance, consumers, replacement, or versioning.

Implementation stages, experiments and run histories, candidate reviews,
confirmation records, generated manifests, runtime snapshots, method-revision
history, and task notes are not specifications by themselves.

## Resolve draft and current state

An accepted specification owns the current contract. A draft owns a proposed
contract and does not claim that implementation already conforms. Draft and
accepted states are established by Git context and the repository's acceptance
process; the default specification template does not require a status field.

## Draft and synchronize

Prefer drafting a new or changed contract before implementation when its
observable behavior, interfaces, invariants, or acceptance can reasonably be
defined. Exploratory implementation may precede a draft, but it does not
establish the contract.

At synchronization, the specification contains the accepted contract,
independently owned choices link to their decisions, unaccepted deviations
remain unresolved, and non-contract implementation details remain outside the
specification.

Before activation or a claim that contract synchronization is complete, the
specification, implementation, evidence, and active decisions agree. Open
decisions are resolved and evidence supports acceptance. Reference stable
evidence; keep run logs in their external system. Apply `apex-harness` evidence
requirements during verification.

## Reject a draft

For a rejected or abandoned draft:

- discard the draft Git version; an existing active version remains canonical
- if no active version exists, retire the artifact under the topology procedure
- first transfer a still-current rejection constraint to a rejected decision
  record under the skill's promotion rule

A rejected draft has no legacy lifecycle.

## Supersede or retire

Resolve a retained specification's legacy path with the topology path
precedence, using `docs/specs/legacy/<topic>-NN.md` as its fallback in place of
the topology table's step 4. Use the next unused generation, beginning with
`01`.

Deletion is the default after supersession. Retain a predecessor only for
independently useful rationale not owned by a decision record, a current
non-lineage consumer, or an explicit audit or compliance requirement. Before
placing it under `legacy/`, record `Superseded by`, `Retention reason`, and
`Remove when`. Do not assign a legacy generation merely to preserve a complete
sequence.

Exclude retained legacy specifications from normal current-document navigation.
Read them only to resolve lineage, audit, or a documented historical dependency.

When retaining a superseded specification, the legacy artifact is the last
active Git version, not the successor draft. Keep the successor at the canonical
path, repair older lineage fields that named the predecessor's former path, and
apply the topology lineage rules.

When not retaining a superseded specification, apply the topology retirement
procedure.

For legacy code, keep the current contract in its specification. Put successor
or retirement reasoning in a decision record under the skill's promotion rule.
Record the target state, affected consumers, relevant recovery information, and
evidence that the contract retired.

When a contract retires without a successor, apply the topology retirement
procedure. Do not leave a retired contract active or invent a successor only to
retain the file.
