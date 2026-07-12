---
name: using-apex
description: Entry point for the APEX software-engineering skill series. Use once when APEX coordination is requested or bootstrapped, then route work to the smallest applicable APEX skill without reloading this entry for every task.
---

# Using APEX

APEX coordinates a small set of engineering workflows. It does not replace the
model's normal coding judgment or repeat higher-priority instructions.

If you are a subagent assigned one bounded role, follow that assignment. Do not
reload this entry or widen your role.

## Route the work

Use only the skills whose concrete trigger matches:

| Need | Skill |
|---|---|
| substantial risk, authority, evidence, or documentation decisions | `governing-project-work` |
| unresolved intent, competing designs, or a durable implementation plan | `shaping-solutions` |
| worktree isolation or an explicit branch lifecycle action | `managing-git` |
| independent investigations, delegated implementation, or independent review | `coordinating-subagents` |
| an unexplained failure whose cause is not established | `debugging-systematically` |
| deciding and applying a test-first or verification strategy | `testing-changes` |

For a routine, bounded edit, use no leaf unless one of those needs is present.

When a user names a pre-consolidation workflow, translate the intent through
the migration table in the repository README. The old directory name is not a
separate skill and does not bypass the current trigger or authority boundary.

## Shared boundary

Leaves consume decisions; they do not grant permissions or create extra
ceremony. Across the series:

- preserve the requested scope and obtain a user decision before a material
  product, research, data, evaluation, architecture, or public-contract tradeoff
- separate file edits, Git mutations, delegation, and external mutations
- use the tools and repository conventions actually present
- keep one source of truth for each decision or artifact
- verify the claim being made and state uncovered boundaries

Load `governing-project-work` when those decisions need an explicit record.
Otherwise apply this boundary in ordinary prose and continue.

## Composition

A common substantial flow is:

1. govern the work
2. resolve intent or diagnose cause
3. shape a plan only if persistence or coordination benefits from one
4. implement inline or with selected subagents
5. test the changed claims
6. perform only the Git lifecycle action the user authorized

This is a routing guide, not a mandatory pipeline. Announce the selected skill
briefly when one is used and explain why.
