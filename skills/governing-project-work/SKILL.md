---
name: governing-project-work
description: Establishes or reviews an explicit boundary for project risk, mutation authority, evidence strength and freshness, and completion claims. Use when the user requests such a boundary, or when work can cause material irreversible or external effects, change a public contract, expose private data, compromise integrity, or support a consequential completion claim. Do not trigger for ordinary reversible repository edits.
---

# Governing Project Work

Externalize only the applicable project boundary.
A boundary is warranted only when omitting it could materially change how the
work should be authorized, verified, or described as complete.

## Establish the boundary

State only the applicable fields:

- **Risk** — what can go wrong, who or what is affected, and which consequence
  changes how the work should proceed.
- **Authority** — the already-authorized file, Git, or external mutations
  relevant to the task, plus any explicit exclusions. This record documents
  authority; it does not grant or withdraw it.
- **Evidence** — which claim must be supported, the evidence strong enough and
  fresh enough for that claim, and any relevant input that Git cannot identify.
- **Completion** — the exact claim that may be made when done, plus exclusions
  or residual risks that must remain visible.

Use a short prose boundary for the current task. Read
[boundary.md](references/boundary.md) when the boundary must survive a handoff,
resume, or long-running change; a persisted record follows the working lifecycle
defined there.

Project documentation links to a persisted boundary while it is active but does
not own it.
