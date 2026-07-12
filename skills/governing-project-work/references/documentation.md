# Documentation Ownership

Prefer repository conventions. When none exist, use this neutral topology:

| Artifact | Default location | Create or update when |
|---|---|---|
| specification | `docs/specs/` | behavior or semantics must be approved and remain authoritative |
| design record | `docs/design/` | an architectural decision and rationale must persist |
| implementation plan | `docs/plans/` | later execution needs ordered, testable tasks |
| traceability matrix | `docs/matrix_*.md` | requirements can otherwise be lost across many components |
| tradeoff log | `docs/tradeoffs.md` | a material cross-cutting compromise or deviation needs one owner |
| status or handoff | repository convention | the user asks for a durable handoff |

## Ownership rules

- One artifact owns each fact. Others link to it.
- A spec defines behavior and acceptance; a plan orders implementation; neither
  duplicates the other.
- Keep local design rationale near the owning spec or design. Promote only
  cross-cutting decisions to the tradeoff log.
- Matrices map stable requirement IDs to implementation and evidence; they do
  not restate requirements.
- Status documents summarize current state and link to durable sources. Do not
  create or refresh one without a handoff need.
- Update an existing canonical document instead of introducing the neutral
  fallback paths above.

## Minimal shapes

A durable specification needs scope, decisions, observable acceptance, and open
questions. Add interface, state, failure, data, numerical, reproducibility, or
operational sections only when the subject requires them.

A durable plan needs its source requirements, ordered independently testable
tasks, affected paths or responsibilities, verification, documentation impact,
and explicit unresolved blockers. Do not embed future implementation or invent
placeholder details.

A tradeoff record needs a stable ID, context, options considered, decision,
consequences, and approval or evidence. A matrix needs requirement ID, owner,
implementation location, verification, and status.
