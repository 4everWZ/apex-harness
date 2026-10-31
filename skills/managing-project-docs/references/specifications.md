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

At synchronization, each specification contains the accepted contract for its scope, and independently owned choices link to their decisions. Keep unaccepted targets or deviations in working context, the plan, or a clearly distinguished draft version. Keep implementation progress, conformance gaps, and unfinished acceptance checks in working context or the plan rather than accumulating them in the specification.

Synchronize accepted changes with their owning specification in the same logical change.

Contract acceptance establishes what is required; it does not prove implementation conformance. An accepted contract can precede its implementation. Before claiming delivery or conformance, check the implementation against that contract and the evidence supporting the claim. A failing or missing check leaves conformance unresolved; it does not weaken the contract. Reference existing durable evidence when useful; keep run logs in their external system. Do not create evidence artifacts or identity metadata solely to make documentation more traceable. Apply `apex-harness` evidence requirements during verification.

## Reject a draft

For a rejected or abandoned draft:

- discard the draft Git version; an existing accepted version remains canonical
- if no accepted version exists, retire the artifact under the topology procedure
- first transfer a still-current rejection constraint to a rejected decision record when the constraint needs to be maintained or referenced independently; otherwise keep it in the current document that still depends on it

A rejected draft has no legacy lifecycle.

## Supersede or retire

Resolve a retained specification's legacy path with the topology path precedence, using `docs/specs/legacy/<topic>-NN.md` as its fallback in place of the topology table's step 4. Use the next unused generation, beginning with `01`.

Deletion is the default after supersession. Retain a predecessor only when the topology retention rule applies. Before placing it under `legacy/`, record `Retention reason` and `Remove when`; add `Superseded by` only when navigation is required by the user, an audit requirement, or repository convention. Do not assign a legacy generation merely to preserve a complete sequence.

Exclude retained legacy specifications from normal current-document navigation. Read them only to resolve lineage, audit, or a documented historical dependency.

When retaining a superseded specification, preserve the actual last accepted content, not the successor draft or an assumed Git version. Acceptance may include uncommitted changes; use a Git version only after confirming that it contains the accepted content. Apply the topology recovery rule before replacing the predecessor. Keep the successor at the canonical path. If a direct navigation link was intentionally retained, repair older lineage fields that named the predecessor's former path; otherwise recoverable Git history provides lineage. Apply the topology lineage rules.

When not retaining a superseded specification, apply the topology retirement procedure.

For legacy code, keep the current contract in its specification. Create a separate decision record for successor or retirement reasoning only when the choice or rationale needs to be accepted, maintained, or referenced independently; otherwise keep the reasoning with the specification. Record the target state, affected consumers, relevant recovery information, and evidence that the contract retired.

When a contract retires without a successor, apply the topology retirement procedure. Do not leave a retired contract as the current contract or invent a successor only to retain the file.
