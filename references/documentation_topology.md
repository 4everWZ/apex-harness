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

When formal spec evolution is required, maintain a flat fixed-anchor topology:

- `docs/specs/00_*.md` — overview and top-level decomposition
- `docs/specs/algo_*.md` — one per major algorithm or research module
- `docs/specs/dev_*.md` — one per integration or system component
- `docs/specs/integration_*.md` — end-to-end assembly and validation checklist
- `docs/specs/status_*.md` — current-state snapshots and handoff notes when the user explicitly requests handoff
- `docs/specs/legacy/` — superseded specifications
- `docs/plans/` — neutral implementation plans created from approved specs
- `docs/design/` — architecture and design records, including `YYYY-MM-DD-<topic>-design.md`
- `docs/matrix_*.md` — spec-to-implementation matrix
- `docs/tradeoffs.md` — approved or unavoidable project-level deviations

Move the original pre-implementation spec to `docs/specs/legacy/` when it is superseded by formalized active documentation.

Use the neutral topology above when the repository has no stronger convention. Do not make branded or tool-specific subdirectories such as `docs/superpowers/` the default home for specs, plans, matrices, tradeoff logs, or handoff snapshots.

Workflow tools must resolve their output paths through this order:
1. repository-defined documentation convention
2. active governance or accepted spec convention
3. the neutral topology in this document

Date-prefixed designs belong under `docs/design/YYYY-MM-DD-<topic>-design.md`. They may capture an approved design, an architectural decision, or a design evolution record and should link to affected specs. Compatibility does not mean mechanically overwriting them: update an existing design when it remains the same living decision, or create a new dated record when the direction materially changes and history matters. Keep requirements and contracts in `docs/specs/`; avoid duplicating their full content in design records.

Use progressive disclosure: link to related docs instead of copying them. Load matrix rows, tradeoff entries, or handoff notes only when the current task needs that layer.

## 4. Required Anchor Documents

### 4.1 Overview
`00_*.md` must contain:

- project purpose
- scope and explicit non-goals
- primary success criteria
- top-level decomposition
- links to relevant docs

### 4.2 Algorithm Leaf Docs
Each `algo_*.md` must contain:
1. Goals & Boundaries
2. Math / Logic / Interfaces
3. Code Mapping
4. Tradeoffs
5. Verification

Use these for major model blocks, losses, data semantics, evaluation protocols, or research modules.

### 4.3 Development Leaf Docs
Each `dev_*.md` must contain:
1. Goals & Boundaries
2. Interfaces / Responsibilities
3. Code Mapping
4. Tradeoffs
5. Verification

Use these for service components, integration boundaries, state ownership, or operational subsystems.

### 4.4 Tradeoff Layering Rule

Tradeoffs are intentionally split across two layers.

**Leaf-doc tradeoffs (`algo_*.md` / `dev_*.md`)** record local design tradeoffs only:

- module-level or subsystem-level choices
- local limitations
- implementation-level alternatives and their consequences

**Global tradeoffs (`docs/tradeoffs.md`)** record project-level deviations only:

- original spec vs actual implementation
- approved compromises
- unavoidable deviations
- major rejected alternatives with project-wide implications

Do not copy the same full tradeoff narrative into both places.

If a topic appears in both places:
- keep the leaf doc version short and local
- keep the full deviation record in `docs/tradeoffs.md`
- reference the corresponding tradeoff entry by stable ID from the leaf doc when useful (for example, `TRD-001`)
- do not copy tradeoff entries into plans, matrices, or handoff docs

### 4.5 Spec-to-Implementation Matrix
`docs/matrix_*.md` is mandatory for Tier A and recommended for substantial Tier B work.

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

If a module is omitted, state exactly:

**Not implemented in the current version.**

## 6. Alignment Check

When implementation changes materially:
- update affected leaf docs if they would otherwise become wrong or misleading
- update `docs/design/` if it exists and the high-level structure changed
- update the matrix if it exists and coverage or implementation status changed
- update integration docs if they exist and validation or assembly changed
- update status / handoff docs only when the user explicitly requests handoff

Remove stale docs, dead references, deprecated harnesses, and filler text when they are in the touched documentation path or would mislead future work.
