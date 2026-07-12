# Research and ML Contracts

Load this reference only when implementation can change data, numerical,
algorithmic, evaluation, or empirical meaning.

## Define the semantic boundary

Record the applicable contract rather than assuming it:

- input/output shapes, dtypes, units, ranges, missing-value meaning, and label
  semantics
- dataset identity, split ownership, leakage boundary, preprocessing fit scope,
  and sampling policy
- randomness sources, seeding scope, determinism limits, and reproducibility
  inputs
- numerical precision, tolerances, convergence or stopping rules, non-finite
  behavior, and approximation guarantees
- metric definitions, aggregation, baselines, uncertainty, and comparison rules
- resource or latency constraints that change algorithm validity

Do not invent an unknown contract. Resolve it from accepted specifications,
code, data, or experiments, or return the material choice to the user.

## Separate evidence layers

- **Interface evidence** checks shape, type, schema, and failure behavior.
- **Algorithmic evidence** checks invariants and correctness on controlled data.
- **Empirical evidence** supports only the tested dataset, metric, seed, and
  uncertainty boundary.

A green interface test does not establish an empirical claim. A benchmark does
not establish algorithmic correctness. State contradiction conditions that
would invalidate the claim, and preserve enough environment, dependency, data,
and seed identity to reproduce the intended comparison when practical.
