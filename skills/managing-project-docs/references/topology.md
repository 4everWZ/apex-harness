# Project Documentation Topology

## Choose the owner

| Artifact | Lifecycle | Fallback path | Fallback template | Owns |
|---|---|---|---|---|
| specification | durable | `docs/specs/<topic>.md` | `assets/templates/specification.md` | current behavior, interfaces, acceptance, and optional algorithm, data, ML, evaluation, or research semantics |
| decision record | durable | `docs/design/YYYY-MM-DD-<topic>-design.md` | `assets/templates/decision-record.md` | a material design choice, cross-artifact tradeoff, or legacy successor or retirement decision |
| work plan | working | `docs/plans/<topic>.md` | `assets/templates/work-plan.md` | ordered execution, blockers, and optional requirement mapping |
| handoff | transient | `docs/handoffs/<topic>.md` | `assets/templates/handoff.md` | current state for one explicit transfer of work |

Template paths are relative to `managing-project-docs/`.
Copy the applicable template sections and remove unused placeholders.

Start with one canonical artifact. Split only for a distinct owner, lifecycle,
or audience. A project boundary remains governance-owned at its
governance-resolved path; project documents link to it while it is active.

## Resolve paths

Resolve each artifact path in this order:

1. an explicit user-selected path
2. the repository's established convention for that artifact type
3. an explicit convention in the accepted project documentation
4. the fallback path in the topology table

Recognize a repository convention from instructions, a document index that
names the path, or consistent current canonical artifacts of the same type.
Recognize a project convention only from an active specification or decision
that explicitly names it.

At the same priority, prefer the candidate marked canonical or current, then one
linked by current project documents. If candidates remain tied, ask the user to
name the canonical location.

Update an existing canonical artifact at its current path. Use stable lowercase
kebab-case topics that name the owned contract, decision, or outcome.

## Resolve content conflicts

Compare authority within the same Git version. Differences between active and
draft Git versions of one canonical artifact are not content conflicts.

Use an explicit user or repository canonical designation first. Otherwise use
the artifact that owns the information: a specification for its contract, a
decision record for the choice and rationale, a work plan for unfinished
execution, a handoff for the current transfer, and a project boundary for its
governance fields.

Within the same Git version and ownership, prefer active or current material over
draft, proposed, superseded, or legacy material; recency alone does not establish
authority. If active canonical artifacts still conflict, resolve the
inconsistency with their named authority or ask the user rather than choosing by
date.

## Preserve identity

Before moving an artifact or deleting one with a successor, redirect inbound
links to the new canonical path or successor and repair relative references
inside a moved file. When deleting without a successor, remove its inbound
links. Confirm that current repository documents no longer reference the old
path, then remove directories left empty by the change.

When superseding a durable artifact, first transfer current facts to their
owner. Retain the predecessor only while its rationale remains useful, a
non-lineage consumer references it, or audit requires it. For a retained
predecessor, set `Status` to `superseded`, set `Superseded by` to the successor,
and set the successor's `Supersedes` field to the predecessor.

Lineage alone does not require retention. Before deleting a retained
predecessor, point its direct successor's `Supersedes` field to the earlier
retained ancestor, or clear it when none remains. Redirect other inbound links
to the successor, then delete the predecessor. Git owns the chronology.

## Optional document index

Use `docs/README.md` only when the repository convention or the number of
artifacts warrants a human navigation entry point. The index owns navigation,
not contracts, decisions, status, rationale, or work state. Link to canonical
current artifacts and avoid copying their content. Omit the index when the
repository is already easy to navigate.
