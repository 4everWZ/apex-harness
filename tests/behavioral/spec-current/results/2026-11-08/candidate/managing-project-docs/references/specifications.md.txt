# Specification Lifecycle

## Select the contract boundary

A current specification records the accepted normative contract: what the system is required to do. It does not describe whatever the implementation happens to do or the chronology of developing it. A coherent contract may use one specification or an overall specification with subordinate technical specifications. Split substantial subsystem or algorithm detail when a focused reference makes implementation, verification, or maintenance clearer; these layers need no separate release, acceptance process, or lifecycle. Keep simple details as sections.

The overall specification owns scope, shared constraints, and relationships; technical specifications own their detailed definitions and acceptance criteria. Link to those owners instead of repeating their content. Preserve the interfaces, formulas, state and error semantics, invariants, and acceptance needed to implement and verify each part; neither summarizing nor splitting justifies omitting them.

An existing README, API document, or other maintained artifact may already own that specification role under repository conventions; update it rather than creating a parallel specification. If no suitable owner exists, establish a specification for the contract involved in the task. Move accepted contract content out of a work plan into that owner; keep unaccepted targets clearly proposed and execution state in working context or the plan. Taking over an existing project does not require reconstructing specifications for unrelated contracts.

Implementation stages, experiments and run histories, candidate reviews, confirmation records, generated manifests, runtime snapshots, method-revision history, and task notes are not specifications by themselves.

## Resolve draft and current state

An accepted specification owns its part of the current contract. A draft describes a proposed contract and does not replace the accepted one. Use Git context and the repository's existing acceptance process to distinguish them; no extra file or status field is required just to represent that distinction.

Input requirements may propose changes to the accepted contract; coordinate authorized changes in working context or a work plan when needed.

When establishing a missing specification, distinguish observed implementation behavior, the authorized target, and unresolved questions. Code and tests inform the draft but do not by themselves establish that a behavior is an accepted contract.

## Draft and synchronize

Prefer drafting a new or changed contract before implementation when its observable behavior, interfaces, invariants, or acceptance can reasonably be defined. Exploratory implementation may precede a draft, but it does not establish the contract. Judge completeness by whether a reader can understand the intended use, implement the accepted behavior consistently, and assess conformance without unstated assumptions; keep material gaps explicit rather than inventing answers.

At synchronization, each specification contains the accepted contract for its scope, and independently owned choices link to their decisions. Keep unaccepted targets or deviations in working context, the plan, or a clearly distinguished draft version. Keep detailed implementation progress and unfinished acceptance work in working context or its current working document. Make important unimplemented or unverified gaps visible through a reference to their existing plan, task, or acceptance evidence. If no other artifact owns that state, a specification may briefly state the gap separately from its normative requirements. Update or remove that notice as the state changes; do not append a progress history or duplicate another owner's tracking.

Synchronize accepted changes with their owning specification in the same logical change.

Contract acceptance establishes what is required; it does not prove implementation conformance. An accepted contract can precede its implementation, and the absence of a plan does not establish conformance. Before claiming delivery or conformance, check the implementation against that contract and the evidence supporting the claim. A failing or missing check leaves conformance unresolved; it does not weaken the contract. Reference existing durable evidence when useful; keep run logs in their external system. Do not create evidence artifacts or identity metadata solely to make documentation more traceable. Apply `apex-harness` evidence requirements during verification.

## Reject a draft

For a rejected or abandoned draft:

- discard the draft Git version; an existing accepted version remains canonical
- if no accepted version exists, retire the artifact under the topology procedure
- first transfer a still-current rejection constraint to a rejected decision record when the constraint needs to be maintained or referenced independently; otherwise keep it in the current document that still depends on it

## Update or retire

Update the canonical specification in place when an accepted contract changes. Retrieve historical versions from Git rather than creating predecessor files or adding revision hashes, lineage fields, or historical navigation to specifications. Apply the topology recovery rule before replacing content that still needs preservation; the relevant accepted content may include uncommitted changes.

Create a separate decision record for replacement or retirement reasoning only when the choice or rationale needs to be accepted, maintained, or referenced independently; otherwise keep the necessary rationale with the specification.

When a contract retires without a successor, apply the topology retirement procedure. Do not leave a retired contract as the current contract or invent a successor only to retain the file.
