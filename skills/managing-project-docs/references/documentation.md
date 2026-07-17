# Project Documentation Topology

Resolve locations through the path contract below, then use this topology:

| Artifact | Lifecycle | Fallback path | Fallback template | Owns |
|---|---|---|---|---|
| specification | durable | `docs/specs/<topic>.md` | `assets/templates/specification.md` | current behavior, interfaces, acceptance, and optional algorithm, data, ML, evaluation, or research semantics |
| decision record | durable | `docs/design/YYYY-MM-DD-<topic>-design.md` | `assets/templates/decision-record.md` | a material design choice, cross-artifact tradeoff, or legacy successor or retirement decision |
| work plan | working | `docs/plans/<topic>.md` | `assets/templates/work-plan.md` | ordered execution, blockers, and optional requirement mapping |
| handoff | transient | `docs/handoffs/<topic>.md` | `assets/templates/handoff.md` | current state for one explicit transfer of work |

Template paths are relative to `managing-project-docs/`.

## Path contract

Resolve each artifact path in this order:

1. the repository's established convention for that artifact type
2. an explicit convention in the accepted project documentation
3. the fallback path in the topology table

Apply these rules after choosing the convention:

- Update an existing canonical artifact at its current path; do not create a
  parallel fallback file merely because its name differs from the fallback.
- Replace `<topic>` with a stable lowercase kebab-case subject. Name the owned
  contract, decision, or outcome—not the agent, tool, session, or current task.
- The date in a decision path is when that decision was established, not a
  version number. Update the record in place while it owns the same decision;
  create and cross-link a new dated record only for a materially new decision.
- Keep retained superseded specifications under
  `docs/specs/legacy/<topic>.md`. Move one there only when the lifecycle rules
  require retention; otherwise delete it and rely on Git history.
- Persist a separate project boundary, when one is actually needed, at
  `docs/plans/<topic>-boundary.md`. It remains a working governance record, not
  a fifth project-document type.
- When moving or deleting an artifact, update or remove its inbound repository
  links in the same change. Remove directories left empty by that change.
- Do not create branded or tool-specific documentation subdirectories such as
  `docs/apex/`.

## Artifact budget

- Start by updating one canonical artifact. A template does not justify a file.
- Copy only applicable template sections; remove empty guidance and placeholders.
- Split content only for a different owner, lifecycle, or audience.
- A specification owns the contract. A decision record links to that contract
  and owns only a decision needing an independent lifecycle.
- Keep local choices in the specification. Use a decision record for a
  cross-component choice, cross-artifact constraint, or durable legacy decision.
- Put traceability in the work plan only when many requirements, components, or
  phases make a separate mapping useful.
- Create a handoff only for an explicit transfer of work.
- Keep a project boundary separately owned. Durable specifications and decisions
  link to it rather than embed it; a work plan or handoff may carry it only for
  that artifact's lifetime. A separately persisted boundary follows its own
  governance-defined working lifecycle. Boundary links are valid only while the
  record is active; at closure, transfer still-current durable facts and remove
  or replace every link before deleting the record.

## Lifecycle

### Durable

Durable means canonical while the contract or decision remains relevant. It
does not mean append-only or permanently retained.

Maintain specifications and decision records in place as current truth. Do not
use them as changelogs, activity feeds, execution histories, test-run archives,
commit journals, or system logs. Git owns document change chronology;
operational logging owns runtime events.

When a durable artifact is superseded, link the successor only while the old
rationale remains operationally useful, is still referenced, or must be kept
for audit. Otherwise transfer any still-current fact to its owner and delete
the obsolete artifact; Git retains its history.

Delete rejected proposals by default. Retain a concise decision record only
when the rejection itself remains a current material constraint and merits an
independent owner, lifecycle, or audience; delete it when that constraint no
longer applies.

For legacy code, record the current contract in the owning specification. Add a
decision record only when successor or retirement reasoning needs an independent
lifecycle. Record the target state, affected consumers, recovery information
when relevant, and evidence that the contract—not merely old files—has retired.

### Working

A work plan exists to drive unfinished work, not to preserve completed-task
history. When the work closes, move durable facts into their owning
specification or decision record, then delete the plan unless a named next phase
still uses it.

### Transient

A handoff exists only until its recipient has taken over. Replace stale content
during the transfer, then delete the artifact or let the repository's explicit
handoff convention own its retention.
