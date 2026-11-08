# Working Document Lifecycle

## Decide whether a working document is needed

Do not create a work plan for an ordinary single-session change that can be completed and verified directly. Use one when work must resume across sessions, multiple contributors or systems must coordinate, ordered dependencies matter, blockers must remain visible, or the user explicitly requests a persisted plan.

Represent development stages as sections, milestones, or tasks in one plan unless they have independent owners and lifecycles. Resuming the same work later is not by itself a handoff; a handoff requires an actual transfer.

## Work plans

Keep at most one current work plan for one coherent initiative. Before creating another plan, locate and extend the existing current plan. Create a separate plan only when the work has an independent owner, scope, or lifecycle.

Use a work plan to coordinate the unfinished transition from the current contract to the authorized target. Keep only the tasks, claim, evidence state, blockers, and next action needed to resume; remove stale detail instead of appending a work diary. Accepted contract content belongs to its specification owner even while the initiative remains open; apply the specification lifecycle when that owner is missing. Keep proposed changes distinct from the current contract. Transfer rationale when it becomes part of the current contract or an independently owned decision, then replace plan detail with a link to its durable owner.

When work uses input requirements, keep detailed implementation tracking, clarifications, and approved deviations in working context or the current plan. In a plan, reference the minimum relevant inputs and map tasks to existing requirement IDs or source sections only when needed to avoid omissions. Use direct references instead of transcribing inputs into another requirements document.

Treat the plan's stated Goal as its lifecycle boundary. An open task or blocker keeps the plan current only while it belongs to that Goal. Follow-on work or feedback outside that Goal does not prevent retirement; keep it with its appropriate acceptance or task owner. Create or extend another plan only when the follow-on work independently meets the work-plan criteria.

## Retire working documents

Retire a work plan when:

- its outcome is delivered, its changed claim is credibly verified, and accepted contract changes have been synchronized;
- the work is explicitly abandoned or cancelled;
- its scope is superseded or consolidated into another canonical plan or specification; or
- the initiative or a required dependency is closed and the plan is no longer resumable.

Before retiring a plan, synchronize the continuing acceptance owner when one exists and leave the current conformance conclusion in its specification. Move any still-needed constraints, blockers or cancellation reason to their appropriate owner. For delivery, replace the retiring work link with the maintained acceptance owner or evidence supporting the conclusion; for cancellation or abandonment, preserve the actual remaining implementation and verification gaps. Open verification within the plan's Goal keeps it current unless the work is explicitly closed, superseded, abandoned or cancelled.

When a retirement condition is met, apply the topology retirement procedure, including its recovery rule. Do not repeat its fact-transfer, link-repair, evidence, or retention checklist here. Delete the plan by default once those conditions are satisfied; retain it only for a concrete audit, consumer, recovery, or repository-convention reason. Do not add a retired status, archive directory, or retirement document.

## Handoffs

A handoff is a temporary record of a transfer, not a canonical project record.

Keep one handoff at the canonical path for the current transfer and update it in place instead of creating parallel handoffs. A later transfer may reuse the same path with new contents after applying the topology recovery rule to the prior transfer's history.

Reading a handoff does not constitute accepting it. Before acceptance, the handoff may temporarily be the primary transfer document.

After the recipient accepts the transfer, do not use the handoff as a long-term work tracker. If substantive unfinished work still needs to remain coordinated or resumable and meets the work-plan criteria, create or update the current work plan.

Otherwise move accepted contract content and independently durable rationale to their owners, and keep evidence in its existing system. Keep any remaining transfer blocker or next action in the handoff until the transfer completes; do not put unfinished work into a specification merely to remove the handoff. If its substantive information has been absorbed but the transfer is not yet complete, the handoff may remain temporarily as a record of the transfer; do not use it to accumulate plan tasks.

Retire a handoff only when its transfer completion condition is met or it is explicitly abandoned, no still-current information exists only in the handoff, and no open blocker or named next action remains owned by it. For an abandoned transfer, first move still-valid constraints, blockers, and the cancellation reason to the appropriate owner. Apply the topology retirement procedure, then delete the handoff by default. Retain it only for a concrete audit, consumer, recovery, or repository-convention reason.
