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

At synchronization, the specification contains the accepted contract,
independently owned choices link to their decisions, unaccepted deviations
remain unresolved, and non-contract implementation details remain outside the
specification.

Before activation or a claim that contract synchronization is complete, the
specification, implementation, evidence, and active decisions agree. Open
decisions are resolved and evidence supports acceptance. Reference stable
evidence; keep run logs in their external system. When governance owns evidence
strength or freshness, link to its boundary.

## Reject a draft

For a rejected or abandoned draft:

- discard the draft Git version; an existing active version remains canonical
- if no active version exists, resolve inbound links and delete the artifact
- first transfer a still-current rejection constraint to a rejected decision
  record under the skill's promotion rule

A rejected draft has no legacy lifecycle.

## Supersede or retire

Resolve a retained specification's legacy path with the topology path
precedence, using `docs/specs/legacy/<topic>-NN.md` as its fallback in place of
the topology table's step 4. Use the next unused generation, beginning with
`01`.

When retaining a superseded specification, the legacy artifact is the last
active Git version, not the successor draft. Keep the successor at the canonical
path, repair older lineage fields that named the predecessor's former path, and
apply the topology lineage rules.

When not retaining a superseded specification, clear the successor's
`Supersedes` field and redirect current links to it. Git history retains the
predecessor.

For legacy code, keep the current contract in its specification. Put successor
or retirement reasoning in a decision record under the skill's promotion rule.
Record the target state, affected consumers, relevant recovery information, and
evidence that the contract retired.

When a contract retires without a successor, transfer every still-current fact
and independently owned retirement decision, resolve inbound links, then delete
the specification. Do not leave a retired contract active or invent a successor
only to retain the file.
