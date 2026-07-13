---
name: managing-project-docs
description: Applies the project's preferred topology, templates, ownership rules, and lifecycle for durable documentation. Use directly for document hierarchy, spec or design artifacts, implementation-plan documents, matrices, tradeoff or status records, handoffs, supersession, legacy-document lifecycle, or code successor and retirement records. Do not use for ordinary planning or legacy-code implementation without a durable documentation request. This skill is independent of project governance.
---

# Managing Project Docs

Apply the user's project-document organization without imposing a broader
engineering workflow.

## Use the documentation mechanism

Read [documentation.md](references/documentation.md) when selecting, creating,
moving, superseding, or retiring a durable artifact. It defines:

- the fallback project-document topology
- which artifact owns each kind of information
- the lifecycle for active, rejected, superseded, and legacy material
- the fallback templates under `assets/templates/`

Prefer an established repository convention. When none exists, use the fallback
topology and copy only the applicable template; remove sections that carry no
information.

Keep one owner for each durable fact. Other artifacts link to that owner rather
than restating it. Governance records may be stored in an artifact when useful,
but `governing-project-work` and this skill trigger independently.
