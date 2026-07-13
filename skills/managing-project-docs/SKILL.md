---
name: managing-project-docs
description: Applies the project's preferred topology, ownership, and lifecycle for durable specifications or decision records, working plans, handoffs, supersession, and legacy documentation. Use directly when the user asks to create, reorganize, merge, or retire these project artifacts. Do not use for ordinary planning, status reporting, or legacy-code implementation unless the user explicitly asks for one of these project artifacts or its lifecycle. This skill is independent of project governance.
---

# Managing Project Docs

Apply the user's project-document organization without imposing a broader
engineering workflow.

## Use the documentation mechanism

Read [documentation.md](references/documentation.md) before selecting or
creating any of the four artifact types, or before moving, superseding, or
retiring a durable artifact. It defines:

- the fallback project-document topology
- which artifact owns each kind of information
- the lifecycle for active, rejected, superseded, and legacy material
- the fallback templates under `assets/templates/`

Prefer an established repository convention. When none exists, use the fallback
topology and copy only the applicable template; remove sections that carry no
information.

Start with one canonical artifact. Split content only when it has a distinct
owner, lifecycle, or audience; a bundled template is never by itself a reason
to create another file.

Keep one owner for each durable fact. Other artifacts link to that owner rather
than restating it. Governance records may be linked or stored when useful, but
`governing-project-work` and this skill trigger independently.
