# Documentation Ownership

Prefer repository conventions. When none exist, use this neutral topology:

| Artifact | Default location | Fallback template | Create or update when |
|---|---|---|---|
| development specification | `docs/specs/dev_*.md` | `assets/templates/dev-spec.md` | behavior, ownership, or interfaces must remain authoritative |
| algorithm specification | `docs/specs/algo_*.md` | `assets/templates/algorithm-spec.md` | numerical, data, ML, evaluation, or research semantics must persist |
| design record | `docs/design/` | `assets/templates/design-record.md` | an architectural decision and rationale must persist |
| implementation plan | `docs/plans/` | `assets/templates/implementation-plan.md` | later execution needs ordered, testable tasks |
| traceability matrix | `docs/matrix_*.md` | `assets/templates/traceability-matrix.md` | requirements can otherwise be lost across many components |
| tradeoff log | `docs/tradeoffs.md` | `assets/templates/tradeoff-entry.md` | a material cross-cutting compromise or deviation needs one owner |
| status or handoff | repository convention | `assets/templates/status-handoff.md` | the user asks for a durable handoff |

Template paths are relative to `governing-project-work/`. Prefer a repository's
existing template. Otherwise copy the smallest applicable fallback and remove
unused optional sections; templates are starting shapes, not mandatory forms.

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

## Lifecycle and legacy

Keep decision status separate from implementation status. Use explicit states
such as `draft`, `approved`, `rejected`, and `superseded`; record who may change
the decision. Do not rewrite an approved decision as though its old outcome
never existed.

When no stronger repository convention exists:

- keep active specifications in `docs/specs/`
- move superseded specifications to `docs/specs/legacy/` only after an active
  successor names `Supersedes` and the legacy document names `Superseded By`
- keep rejected and superseded tradeoffs as decision history
- treat legacy documents as context, not current authority; correct factual
  errors in place, but make new decisions in an active successor

For legacy code, first identify its current contract, callers, evidence, and
retirement authority. Classify it as retained, compatibility-bound, migrating,
or removal-approved. Prefer an owned adapter or migration boundary over flags
and scattered special cases. A removal or compatibility break needs an explicit
target state, consumer migration, rollback or recovery where relevant, and
verification that the governed contract—not merely the old files—has gone.
