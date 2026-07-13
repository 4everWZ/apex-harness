# Project Documentation Topology

Use repository conventions first. When none exist, use this fallback:

| Artifact | Default location | Fallback template | Owns |
|---|---|---|---|
| development specification | `docs/specs/dev_*.md` | `assets/templates/dev-spec.md` | behavior, interfaces, ownership, acceptance |
| algorithm specification | `docs/specs/algo_*.md` | `assets/templates/algorithm-spec.md` | data, numerical, ML, evaluation, or research semantics |
| design record | `docs/design/` | `assets/templates/design-record.md` | an architectural decision, including cross-component choices, and its rationale |
| implementation plan | `docs/plans/` | `assets/templates/implementation-plan.md` | ordered implementation tasks and verification |
| traceability matrix | `docs/matrix_*.md` | `assets/templates/traceability-matrix.md` | requirement-to-implementation-to-evidence mapping |
| tradeoff log | `docs/tradeoffs.md` | `assets/templates/tradeoff-entry.md` | cross-artifact deviations or constraints and their disposition |
| status or handoff | repository convention | `assets/templates/status-handoff.md` | current state for an explicit handoff |

Template paths are relative to `managing-project-docs/`.

## Ownership

- One artifact owns each durable fact; other artifacts link to it.
- A specification defines the contract. A plan orders work against that
  contract. A matrix maps stable IDs without restating either.
- A design record owns the full architectural decision and option analysis,
  including cross-component choices. A tradeoff entry owns only a deviation or
  constraint that crosses artifacts; it links to the underlying spec or design.
- Create a status document only for a real handoff.
- Update an existing canonical artifact instead of adding a parallel fallback.

## Lifecycle

Track decision status separately from implementation status. Use explicit states
such as `draft`, `approved`, `rejected`, and `superseded`.

When no stronger convention exists:

- keep active specifications in `docs/specs/`
- move a specification to `docs/specs/legacy/` only after the active successor
  names `Supersedes` and the legacy document names `Superseded By`
- retain rejected and superseded decisions as history
- treat legacy documents as context, not current authority

For legacy code, record its current contract and classify it as retained,
compatibility-bound, migrating, or removal-approved. Keep one owning artifact
for its successor or retirement record. Name the target state, affected
consumers, recovery information when relevant, and evidence that the
contract—not merely the old files—has been retired.
