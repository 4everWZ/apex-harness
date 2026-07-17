---
name: governing-project-work
description: Establishes an explicit boundary for project risk, mutation authority, evidence strength, and completion claims. Use when the user asks to establish or review a project-work boundary, or for consequential, irreversible, external, or public-contract work, including data or research work with material privacy, integrity, publication, or interpretation risk. Do not use for routine coding, planning, testing, Git, documentation, or low-risk read-only analysis or research unless the boundary itself is the task.
---

# Governing Project Work

Externalize the few decisions that are easy to lose during substantial work.
This is a boundary mechanism, not a general software-engineering policy.

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

## Keep it separate

Do not turn ordinary implementation choices into governance. If the work also
needs project documentation, keep the boundary separately owned at the path
resolved by [boundary.md](references/boundary.md). Project documents link to
that record. Neither skill requires the other.
