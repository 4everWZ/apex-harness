# Documentation Topology

When a source-of-truth document describes changed behavior, keep it aligned. Do not create or update heavy documentation just because a small edit happened.

## 1. When Documentation Updates Are Required

Documentation updates are required when both are true:
- a relevant source-of-truth doc, accepted spec, design doc, matrix, README, or handoff document exists or is needed for the task
- the implementation change would make that document wrong, misleading, incomplete, or stale

Common triggers:
- architecture
- behavior
- usage
- evaluation semantics
- external contracts
- reproducibility
- maintainability

## 2. Update Rules by Tier

### Tier A
Documentation updates are usually required when active specs, design docs, evaluation docs, or matrices exist for the changed area.

### Tier B
Update docs when:
- interfaces change
- new config keys or flags are introduced
- behavior changes are user-visible
- the implementation adds a non-obvious constraint
- architecture or evaluation semantics change

### Tier C
Documentation updates are usually unnecessary unless the change crosses a behavior, architecture, or contract boundary.

## 3. Repository Layout Assumption

When formal spec evolution is required and the repository has no stronger
convention, use the smallest applicable subset of this neutral topology:

- `docs/specs/00_*.md` — overview and top-level decomposition
- `docs/specs/algo_*.md` — one per major algorithm or research module
- `docs/specs/dev_*.md` — one per integration or system component
- `docs/specs/integration_*.md` — end-to-end assembly and validation checklist
- `docs/specs/status_*.md` — current-state snapshots and handoff notes when the user explicitly requests handoff
- `docs/specs/legacy/` — superseded specifications
- `docs/plans/` — neutral implementation plans created from approved specs
- `docs/design/` — architecture and design records, including `YYYY-MM-DD-<topic>-design.md`
- `docs/matrix_*.md` — spec-to-implementation matrix
- `docs/tradeoffs.md` — material cross-spec decisions, approved compromises,
  and unavoidable project-level deviations

The `algo_*`, `dev_*`, and `integration_*` names are a research/complex-systems
profile, not mandatory names for ordinary application repositories. A
repository may use product, ADR, RFC, service, or other established naming
without translating it into the profile above.

Move the original pre-implementation spec to `docs/specs/legacy/` only when it
is superseded and the repository preserves superseded specs in that location.

Use the neutral topology above when the repository has no stronger convention. Do not make branded or tool-specific subdirectories such as `docs/superpowers/` the default home for specs, plans, matrices, tradeoff logs, or handoff snapshots.

Workflow tools must resolve their output paths through this order:
1. repository-defined documentation convention
2. active governance or accepted spec convention
3. the neutral topology in this document

Date-prefixed designs belong under `docs/design/YYYY-MM-DD-<topic>-design.md`. The date records when the design was established, not an immutable version. Update it while it represents the same living decision; when direction materially changes and history matters, create a new dated design and cross-link them with `Status: superseded`, `Supersedes: <path>`, or `Superseded by: <path>` as applicable. Keep requirements and contracts in `docs/specs/`; avoid duplicating their full content in design records.

Use progressive disclosure: link to related docs instead of copying them. Load matrix rows, tradeoff entries, or handoff notes only when the current task needs that layer.

### 3.1 Neutral Spec Governance

Neutral spec lifecycle, approval, evidence routing, and legacy rules live in
`references/spec_governance.md`; content shapes live in the dev/algo templates.
`SKILL.md` owns when to load them.

## 4. Required Anchor Documents

### 4.1 Overview
`00_*.md` must contain:

- project purpose
- scope and explicit non-goals
- primary success criteria
- top-level decomposition
- links to relevant docs

### 4.2 Algorithm Leaf Docs
Store algorithm, ML, evaluation, and research-module contracts in `algo_*.md`;
use `references/algo_spec_template.md` for their shape.

### 4.3 Development Leaf Docs
Store component, integration, state-ownership, and operational contracts in
`dev_*.md`; use `references/dev_spec_template.md` for their shape.

### 4.4 Tradeoff Layering Rule

Use `docs/tradeoffs.md` for global records and
`references/tradeoff_template.md` for ownership, promotion, and lifecycle.
Other docs reference stable `TRD-*` IDs instead of copying entries.

### 4.5 Spec-to-Implementation Matrix
`docs/matrix_*.md` is required when Tier A work has material requirement,
research-claim, evaluation, or cross-module traceability risk. It is optional
when existing tests and source-of-truth documents already provide equivalent
traceability. Use it for substantial Tier B work only when scope tracking would
otherwise be unreliable.

Purpose:
- map original intent to current implementation status
- show what exists, what is partial, what is deferred, and how each item is verified
- reference project-level deviations by tradeoff ID instead of duplicating long explanations
- serve as the requirement-level coverage source of truth

### 4.6 Implementation Plans
`docs/plans/` stores implementation plans created from approved specs.

Use this location when a plan is durable enough to keep with repository docs, but should not be treated as an active spec, design doc, matrix, tradeoff log, or handoff snapshot.

Use `references/plan_template.md` for the expected shape. Keep matrix and tradeoff references as optional links; do not create those artifacts just to fill a header.

### 4.7 Integration
`integration_*.md` must contain:

- end-to-end assembly view
- integration dependencies
- validation checklist
- benchmark / regression / harness entry points
- known hard boundaries
- final acceptance status

### 4.8 Status / Handoff
`status_*.md` is used when the user explicitly requests handoff.

Create or refresh the handoff document only when the user asks for handoff.

It should contain:
- objective and scope boundary
- high-level current state
- verification summary
- blockers / risks
- next steps
- references

Use this document as the primary handoff surface when the user asks for continuity notes. Do not overload `AGENTS.md` with changing project state.

Treat `status_*.md` as a **current-state snapshot**, not as an append-only diary or coverage matrix:
- overwrite the main sections as work advances
- link to `docs/matrix_*.md` when requirement-level status exists
- do not duplicate matrix rows, implementation pointers, or full verification pointers

## 5. Omission Rule

Use `references/spec_governance.md` for spec omission semantics. Do not confuse
an untriggered optional documentation section with approved scope that remains
unimplemented.

## 6. Alignment Check

When implementation changes materially:
- update affected leaf docs if they would otherwise become wrong or misleading
- update `docs/design/` if it exists and the high-level structure changed
- update the matrix if it exists and coverage or implementation status changed
- update integration docs if they exist and validation or assembly changed
- update status / handoff docs only when the user explicitly requests handoff

Remove stale docs, dead references, deprecated harnesses, and filler text when they are in the touched documentation path or would mislead future work.
