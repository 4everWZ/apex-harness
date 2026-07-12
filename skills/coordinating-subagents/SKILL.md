---
name: coordinating-subagents
description: Coordinates bounded work across subagents for independent investigation, delegated implementation, or independent review. Use when delegation is authorized and task separation adds real parallelism, context isolation, or reviewer independence; otherwise work inline.
---

# Coordinating Subagents

Delegate for a concrete benefit, not merely because agents are available. The
controller retains scope, authority, integration, and final-claim ownership.

## Select a mode

### Independent investigation

Use two or more read-only investigators when questions have no shared mutable
state or sequential dependency. Give each one a distinct question and expected
evidence. Run them concurrently when possible, then reconcile conflicts against
the repository rather than voting on conclusions.

### Delegated implementation

Use for an approved task boundary or plan with bounded tasks when fresh context
and per-task review justify the coordination cost. User-provided acceptance
criteria and path boundaries may be sufficient; require a durable plan only
when the work's risk or coordination needs one. Prefer inline work for tightly
coupled edits, unresolved design, dirty repositories that cannot be isolated
safely, or tasks too small to review independently.

For each task:

1. Supply the task acceptance criteria, allowed paths, relevant plan/spec links,
   base `HEAD`, status and diff summaries, and every explicit extra input.
2. State the agent's role, mutation authority, required checks, and return
   contract. Delegation alone is read-only.
3. Let one implementer own the bounded change. Avoid simultaneous edits to
   overlapping paths.
4. Inspect the real resulting diff and verification evidence.
5. Use a fresh reviewer when the selected risk calls for independent judgment.
6. Resolve findings before advancing dependent tasks.

Git and the approved task boundary or plan remain the source of truth. Do not
create a parallel run ledger, serialized workspace state, review package, or
report protocol.
Summaries describe observed state; they are not content identities. Reconcile
resume state from full Git history/status/diffs, the plan, and explicit inputs.

### Independent review

Give the reviewer the intended behavior, relevant source documents, exact diff
range or working-tree scope, verification evidence, and risk focus. The reviewer
inspects repository truth and returns findings ordered by severity with precise
paths and rationale. Absence of findings is not evidence that tests ran.

When receiving review feedback, verify the premise before editing. Clarify
ambiguous feedback, reject technically unsound advice with evidence, and apply
accepted findings one coherent change at a time. Do not agree merely to be
agreeable; accept or reject feedback based on evidence.

## Context and safety

- Fresh agents receive only the context needed for their role.
- Do not ask a subagent to approve a material user decision.
- Do not grant push, merge, discard, deployment, messaging, or other external
  authority through an implementation assignment.
- An agent report is an input. The controller checks the diff and closes stale
  or missing evidence before claiming completion.

## Return contract

Require a concise result: findings or changed paths, checks run and outcomes,
unresolved risks, and any deviation from the task. Integrate these results in
the controller's own final state assessment.
