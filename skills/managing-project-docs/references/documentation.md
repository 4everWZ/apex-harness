# Project Documentation Topology

Use repository conventions first. When none exist, use this fallback:

| Artifact | Lifecycle | Fallback template | Owns |
|---|---|---|---|
| specification | durable | `assets/templates/specification.md` | current behavior, interfaces, acceptance, and optional algorithm, data, ML, evaluation, or research semantics |
| decision record | durable | `assets/templates/decision-record.md` | a material design choice, cross-artifact tradeoff, or legacy successor or retirement decision |
| work plan | working | `assets/templates/work-plan.md` | ordered execution, blockers, and optional requirement mapping |
| handoff | transient | `assets/templates/handoff.md` | current state for one explicit transfer of work |

Template paths are relative to `managing-project-docs/`.

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
  governance-defined working lifecycle.

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
