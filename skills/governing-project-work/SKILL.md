---
name: governing-project-work
description: Governs substantial software, architecture, data, ML, research, or cross-module work when risk, mutation authority, evidence strength, or durable documentation needs an explicit decision. Skip for trivial local edits with an obvious contract and low blast radius.
---

# Governing Project Work

Create the smallest decision boundary that makes substantial work safe and
reviewable. Do not turn the boundary into a second project-management system.

## Start boundary

Before implementation, state only the decisions that matter:

- risk: focused, standard, or critical, with the reason
- success criteria and material non-goals
- allowed mutations: edits, specific Git actions, delegation, and named external
  effects are separate
- design status: resolved or requiring a user decision
- verification path and evidence strength
- existing or required documentation sources of truth

Omit irrelevant fields. Missing mutation authority is not permission.

Read [workflow.md](references/workflow.md) when classification, authority, or
fresh evidence needs more detail. Read
[documentation.md](references/documentation.md) only when durable project
documents are relevant.

## Governing rules

- Resolve facts from code, tests, accepted docs, and observed tools before
  asking the user. Ask when a remaining choice would materially change intent.
- Select planning, TDD, worktrees, delegation, review, or documentation because
  the task needs them, not because APEX provides them.
- Keep the touched source of truth aligned with behavior. Create a new artifact
  only when it will outlive the conversation or coordinate later work.
- Record material cross-cutting tradeoffs once. Leaf documents link to that
  decision instead of copying it.
- Scale verification to failure cost and claim breadth. A passing but unrelated
  command is not evidence.

## Completion boundary

Before a completion claim, reconcile:

1. requested scope and approved decisions
2. final Git-visible state and explicit Git-invisible inputs
3. relevant verification outcomes
4. documentation that would otherwise be false or misleading
5. remaining risks or unverified boundaries

Report a narrower result when evidence cannot support the full claim.
