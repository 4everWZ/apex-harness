# APEX contributor guidance

## Architecture

- `using-apex` is the only bootstrap entry.
- `apex-governance` owns risk, authority, verification, evidence, and
  documentation policy.
- leaf skills own focused mechanisms and consume the active APEX decision.
- keep leaf directory and frontmatter names stable unless a migration is
  explicitly approved.

Do not duplicate governance policy inside leaves. A leaf may state its narrow
preconditions and mutation needs, but it cannot create a second tier system,
authority schema, evidence identity, or documentation topology.

## Skill changes

Treat skills as behavior-shaping code. Use realistic should-trigger and
should-not-trigger cases, previous-version baselines for material changes, and
pressure tests for discipline rules. Static tests verify structure only.

Keep `SKILL.md` focused on routing and core behavior. Move deterministic work to
scripts and detailed variants to references with explicit loading conditions.

## Engineering

- preserve requested scope and existing source-of-truth documents
- do not guess runtime APIs, tool parameters, schemas, or environment semantics
- use repository-native tooling and explicit mutation authority
- keep changes cohesive and verify the claims actually changed
- keep adapters and manifests consistent with the `apex` identity
