---
name: managing-project-docs
description: Maintains the smallest coherent set of canonical project documents. Updates or consolidates existing artifacts before creating new ones, and applies ownership, synchronization, supersession, and retirement rules for specifications, decision records, work plans, and handoffs. Use when those artifacts are created, changed, reorganized, consolidated, superseded, or retired. Does not own execution risk or evidence policy.
---

# Managing Project Docs

Prefer no new artifact. When project information must change, update an existing
canonical artifact before creating another file.
Honor explicit user instructions and established repository conventions for
artifact topology or retention. Apply the selection, budget, linking, and
retirement defaults below only where they do not specify the behavior. When the
user asks to review or consolidate that topology, propose or apply the requested
change without silently overriding unrelated conventions.

## Terms

- **Canonical** — the single authoritative identity or location for an artifact.
- **Current** — still applicable; a plan or handoff remains current while its
  execution or transfer remains open.
- **Artifact ownership** — the information type an artifact is authoritative for.
- **Acceptance authority** — the user, person, team, role, or repository process
  authorized to accept or activate an artifact.

Use this order:

1. Make no documentation change when no durable or working information changes.
2. Update or extend the existing canonical artifact.
3. Create one artifact only when the content needs independent artifact
   ownership or lifecycle.
4. Split further only when every result remains independently maintained,
   accepted, or consumed.

The existence of a template, implementation unit, algorithm, development stage,
experiment, review, date, or task is not by itself a reason to create a file.
Create a work plan only for work that must remain coordinated or resumable, and
a handoff only for an actual transfer of responsibility.

As a default budget, an ordinary single-session change creates no project
document. A durable contract change uses one specification; independently useful
rationale may add one decision record; coordinated or multi-session work uses
one active plan; an actual transfer may add one handoff. Exceed this budget only
when each additional artifact has independent ownership or lifecycle.

When enough independently trackable requirements make partial implementation or
scope drift realistically easy to miss, add a compact spec-to-implementation
mapping to the existing canonical specification or active work plan. Do not
create a separate matrix by default; follow an established repository matrix
convention when one exists.

Proposed content becomes authoritative only through the user, a named authority,
or the repository's established acceptance process.

Read [topology.md](references/topology.md) for any project-topology decision,
including a change to canonical identity or location. Read the lifecycle
reference for every artifact type in scope:
[specifications](references/specifications.md),
[decisions](references/decisions.md), or
[work plans and handoffs](references/working-docs.md).

For a task spanning artifact types, read each applicable reference.
