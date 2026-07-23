---
name: governing-project-work
description: Establishes or reviews an explicit boundary for project risk, mutation authority, evidence strength and freshness, and completion claims. Use when the user requests that boundary or when work has material irreversible, external, public-contract, privacy, integrity, publication, or interpretation risk. Do not trigger for ordinary low-risk project work unless the boundary itself is requested.
---

# Governing Project Work

Externalize only the applicable project boundary.

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
