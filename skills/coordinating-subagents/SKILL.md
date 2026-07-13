---
name: coordinating-subagents
description: Coordinates bounded Codex subagents for independent investigation, delegated implementation, or independent review. Use only when the user explicitly requests or enables subagents for the current task and separation adds real parallelism, context isolation, or reviewer independence. Otherwise do not apply this skill; leave behavior to Codex and its runtime defaults.
---

# Coordinating Subagents

Delegate for a concrete benefit, not merely because agents are available.

## Activation gate

This coordination workflow is opt-in. Select it only when the user explicitly
requests or enables subagents for the current task or phase. Do not infer
activation from task size, available concurrency, an existing plan, or a
possible speedup. If activation is absent, do not load or impose this skill and
do not ask merely to unlock it; Codex and its runtime retain their normal
defaults.

## Select a mode

### Independent investigation

Use read-only investigators when questions have no shared mutable state or
sequential dependency. Give each one a distinct question and expected evidence.
Let Codex schedule independent roles within the available concurrency, then
reconcile conflicts against the repository rather than voting on conclusions.

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

- The Codex controller retains scope, mutation authority, integration, evidence
  reconciliation, and final claims. Give every role the approved requirements
  or acceptance criteria, exact Git scope and observed state, relevant evidence,
  and explicit extra inputs needed for that role.
- Give each Codex subagent one concrete, bounded role. Reuse it for follow-up on
  that same role; start a separate role when independence matters.
- Share only the conversation turns needed for the assignment. For an
  independent or unpolluted review, start without inherited turns and provide
  the approved requirements, exact Git scope, evidence, and explicit extra
  inputs in the assignment itself.
- Codex subagents share the active workspace unless Git isolation was arranged;
  treat their edits as immediately visible and never schedule overlapping
  writers.
- Use the runtime's available scheduling, waiting, messaging, interruption, and
  concurrency behavior. Do not encode model selection or reasoning settings in
  this skill.
- Do not ask a subagent to approve a material user decision.
- Do not grant push, merge, discard, deployment, messaging, or other external
  authority through an implementation assignment.
- An agent report is an input, not completion evidence by itself.

## Return contract

Require a concise result: findings or changed paths, checks run and outcomes,
unresolved risks, and any deviation from the task. Integrate these results in
the controller's own final state assessment.
