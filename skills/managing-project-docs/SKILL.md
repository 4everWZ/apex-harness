---
name: managing-project-docs
description: Maintains project specifications, decision records, work plans, and handoffs by ownership and lifecycle. Use when defining or changing a maintained project contract, establishing its missing documentation owner, or creating, reorganizing, consolidating, superseding, or retiring these documents. Does not define execution risk or verification policy.
---

# Managing Project Docs

Keep documentation small and useful: give information a clear owner, avoid duplicates, and keep task history and run logs out of project documents. Determine ownership and lifecycle before choosing a file; reuse an existing artifact only when it owns that information.

The specification states the accepted current contract. Implementation is the actual system state; evidence supports whether it conforms. Inputs supply requested targets or constraints. A work plan is optional and tracks the unfinished transition, not the current contract. Do not add documents, status fields, approvals, or reports just to demonstrate that this workflow was followed.

Follow explicit user instructions and established repository conventions first. Use this skill's default locations, linking, and lifecycle rules only when the repository has no convention for the case. When the user asks to review or consolidate the existing documentation structure, make the requested change without silently overriding unrelated conventions.

## Terms

- **Canonical** — the single authoritative identity or location for a document.
- **Current** — still applicable; a plan or handoff remains current while its execution or transfer remains open.
- **Artifact ownership** — the information a document is responsible for keeping current.
- **Input artifact** — material supplied to define or constrain a task, such as requirements, an external specification, an issue, a brief, a benchmark definition, or a user-provided plan.

Using a document as task input does not by itself establish or remove its maintained role. Preserve maintenance responsibilities established by user instructions or repository conventions. Repository location, filename, detail, or formal structure alone does not establish that role.

Absorb the accepted system or algorithm contract from SRS and other requirements into its specification owner through the workflow below, rather than archiving the SRS by default. Still-needed task conditions, external rules, and reference information outside that contract may be retained in full as inputs. Do not rewrite, annotate, or synchronize source material unless maintaining it is authorized. Keep a complete source only when it has a distinct reference purpose; a temporary path or Git exclusion alone does not justify a copy.

Use this order:

1. Make no documentation change when no durable or working information changes.
2. Identify whether the information belongs to a durable contract, an independently maintained decision, unfinished execution, or a transfer.
3. Update or extend the existing canonical owner for that role, including a maintained section of another document when repository conventions assign it that role.
4. Create a separate file only when it owns a distinct scope of information that needs to be maintained or used separately. For specifications, this may be a technical layer of the same contract; follow the specification lifecycle.

When work defines or changes durable behavior, interfaces, invariants, or acceptance, read the [specification lifecycle](references/specifications.md) before choosing its owner, including when the project currently has only a plan. A work plan's existence does not satisfy specification ownership.

The existence of a template, implementation unit, algorithm, development stage, experiment, review, date, or task is not by itself a reason to create a file. Create a work plan only for work that must remain coordinated or resumable, and a handoff only for an actual transfer of responsibility.

By default, an ordinary single-session change needs no project document. A durable contract may use one specification or useful specification layers. Add a decision record only when its choice or rationale needs to be accepted, maintained, or referenced independently. Use one current work plan for coordinated or multi-session work, and a handoff only for an actual transfer.

When enough independently trackable requirements make partial implementation or scope drift realistically easy to miss, add a compact spec-to-implementation mapping to the existing canonical specification or current work plan. For input baselines without maintenance responsibilities, keep the execution mapping in working context or the current plan. Do not create a separate matrix by default; follow an established repository matrix convention when one exists.

Writing or editing a document does not by itself make a proposed contract authoritative; follow the repository's normal acceptance process.

Read [topology.md](references/topology.md) when choosing which document is authoritative, resolving its path, consolidating documents, or retiring one. Also read the lifecycle reference for any [decisions](references/decisions.md) or [work plans and handoffs](references/working-docs.md) in scope.
