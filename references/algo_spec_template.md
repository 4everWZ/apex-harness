# Algorithm Spec Template

Use this template for `docs/specs/algo_<topic>.md`. Keep the small common core,
then add only the modules triggered by the algorithm's numerical, randomized,
learned, experimental, distributed, security, or privacy properties. Keep run
results in evidence artifacts rather than copying them into the stable spec.

# [Algorithm or Research Module] Specification

- **Spec Type:** algo
- **Decision Status:** draft | approved | deferred | rejected | superseded
- **Implementation Status:** not-started | in-progress | partial | implemented | not-applicable
- **Established:** YYYY-MM-DD
- **Decision Authority:** [Person or authority that may change decision status]
- **Algorithm Properties:** deterministic | randomized | learned | experimental
  (choose every property that affects the contract)

Apply lifecycle, decision-reference, and readiness rules from
`spec_governance.md`.

Add `Supersedes`, `Superseded By`, `Related Design`, `Matrix`, or global
`Tradeoffs` links only when they exist.

## Claim and Scope

### Goals

- [Algorithmic objective or supported claim]

### Non-goals

- [Excluded behavior, population, operating regime, or interpretation]

### Intended Claims and Limitations

[State what conclusions the algorithm may support and the boundaries beyond
which those conclusions do not hold.]

## Definitions and Assumptions

[Define notation, units, domains, shapes, dtypes, ranges, preconditions, and
assumptions when relevant. Do not guess an unspecified semantic contract.]

## Algorithm Contract

### Operations and Lifecycle

[Define operations such as solve, fit, predict, transform, or evaluate, and the
state required before each operation.]

### Inputs, Outputs, and Parameters

[Define semantic meaning, type, shape, units, valid range, defaults, ordering,
and normalization where applicable.]

### Errors and Undefined Conditions

[Define invalid inputs, infeasible states, non-convergence, and unsupported
operating regimes.]

## Algorithm Semantics

### Mathematical or Logical Definition

[Specify the objective, procedure, or governing logic precisely enough to
distinguish conforming from non-conforming implementations.]

### Invariants and Edge Cases

[Cover empty, duplicate, missing, non-finite, degenerate, or adversarial cases
that affect the contract.]

### Complexity

[State time, space, resource, or approximation bounds when they constrain the
claim or implementation.]

## Code Mapping

[Map algorithm concepts to modules, functions, configuration, tests, and
evidence entry points.]

## Verification and Acceptance

Separate interface conformance, algorithmic correctness, and empirical claim
support. Use the default no-ID form below. Add a stable acceptance-ID column
only when traceability risk or an active matrix justifies it.

| Requirement or claim | Oracle, metric, or decision rule | Verification / evidence |
|---|---|---|
|  |  |  |

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

Add only the modules triggered by the algorithm:

- floating-point, iterative, or approximate: precision, tolerance, convergence,
  non-finite handling, overflow, and device variation
- randomized: RNG sources, seed derivation, determinism scope, repeats, and
  aggregation
- learned or data-dependent: dataset identity, sample and label semantics,
  splits, leakage boundaries, preprocessing, and allowed uses
- training: objective, optimizer, stopping, checkpoint selection, hyperparameter
  search space, budget, and selection protocol
- empirical or research claim: baseline, exact metric, aggregation, slices,
  uncertainty, decision rule, evidence, and contradiction conditions
- performance-sensitive: workload, hardware, warmup, batch, measurement method,
  latency or throughput statistic, and regression budget
- stateful, distributed, security, or privacy sensitive: state ownership,
  communication, consistency, recovery, threat, and data-handling constraints
