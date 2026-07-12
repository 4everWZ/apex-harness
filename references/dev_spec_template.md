# Development Spec Template

Use this template for `docs/specs/dev_<topic>.md`. Keep the core sections and
delete conditional sections that do not apply; do not fill the document with
`N/A`. Keep execution sequencing in `docs/plans/`, not in the spec.

# [Component or System] Development Spec

- **Spec Type:** dev
- **Decision Status:** draft | approved | deferred | rejected | superseded
- **Implementation Status:** not-started | in-progress | partial | implemented | not-applicable
- **Established:** YYYY-MM-DD
- **Decision Authority:** [Person or authority that may change decision status]

Apply lifecycle, decision-reference, and readiness rules from
`spec_governance.md`.

Add `Supersedes`, `Superseded By`, `Related Design`, `Matrix`, or global
`Tradeoffs` links only when they exist.

## Summary

[State the problem, proposed behavior, and expected outcome concisely.]

## Goals and Boundaries

### Goals

- [Observable goal]

### Non-goals

- [Explicitly excluded responsibility or behavior]

## Responsibilities and Ownership

[Define what this component owns, what it delegates, and which state or
resources it controls.]

## Interfaces and Contracts

### Inputs and Outputs

[Define public interfaces, schemas, protocols, configuration, and externally
observable behavior.]

### Errors and Failure Semantics

[Define invalid inputs, failure states, recovery behavior, and caller-visible
errors.]

## State and Data Flow

[Describe state transitions, persistence, concurrency, and component data flow
at the level required to preserve ownership and invariants.]

## Design

[Describe the selected component structure and important implementation
constraints. Link detailed schemas or diagrams instead of copying them.]

## Code Mapping

[Map responsibilities to existing or intended modules without prescribing
incidental file-level detail prematurely.]

## Verification and Acceptance

Use the default no-ID form below. Add a stable requirement-ID column only when
traceability risk or an active matrix justifies it.

| Observable requirement | Verification |
|---|---|
| [Required behavior or constraint] | [Test, inspection, demonstration, or analysis] |

## Local Tradeoffs

Use `tradeoff_template.md` to decide ownership. Keep either a local entry or a
`TRD-*` link with local application details, not a copied global narrative.

| Local ID | Decision | Alternatives | Consequences | Revisit trigger | Global reference |
|---|---|---|---|---|---|
| [LT-01] |  |  |  |  | none |

## Open Questions

[Keep only unresolved questions with an owner and resolution gate. An approved
spec must not contain a blocking open question. Remove this section when empty.]

## Conditional Modules

Add only the modules triggered by the change:

- public API or schema: versioning, deprecation, and migration
- persistent data: migration, rollback, replay, and partial failure
- online or distributed execution: rollout, version skew, observability, and recovery
- security boundary: threats, permissions, abuse paths, and audit
- performance-sensitive path: workload, baseline, budget, and benchmark method
- external dependency: availability, timeout, retry, degradation, and ownership
