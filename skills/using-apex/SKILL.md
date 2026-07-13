---
name: using-apex
description: Bootstrap and full-series routing entry for APEX. Use when the user explicitly asks to bootstrap, load, or coordinate APEX as a whole and it has not already been injected. Do not select it merely because a directly discoverable leaf matches; managing-project-docs and user-enabled coordinating-subagents may trigger directly.
---

# Using APEX

APEX coordinates a small set of engineering workflows. It does not replace the
model's normal coding judgment or repeat higher-priority instructions.

This entry supplies the complete map when full APEX coordination is requested.
It is not a mandatory parent call before a runtime selects a concrete leaf.

If you are a subagent assigned one bounded role, follow that assignment. Do not
reload this entry or widen your role.

## Route the work

Use only the skills whose concrete trigger matches:

| Need | Skill |
|---|---|
| substantial risk, mutation authority, evidence strength, or completion boundaries | `governing-project-work` |
| document topology, templates, artifact lifecycle, handoffs, or legacy management | `managing-project-docs` |
| unresolved intent, competing designs, or a durable implementation plan | `shaping-solutions` |
| worktree isolation or an explicit branch lifecycle action | `managing-git` |
| user-enabled independent investigation, delegated implementation, or independent review | `coordinating-subagents` |
| an unexplained failure whose cause is not established | `debugging-systematically` |
| deciding and applying a test-first or verification strategy | `testing-changes` |

For a routine, bounded edit, use no leaf unless one of those needs is present.
`coordinating-subagents` is additionally gated by an explicit user request or
enablement for the current task; parallelism alone never selects it.
`managing-project-docs` is directly selectable when its trigger matches; do not
load this bootstrap or full governance first merely to use it.

When a user names a pre-consolidation workflow, translate its intent:

- `apex-governance` → `governing-project-work`
- `brainstorming` or `writing-plans` → `shaping-solutions`
- `using-git-worktrees` or `finishing-a-development-branch` → `managing-git`
- `dispatching-parallel-agents`, `subagent-driven-development`,
  `executing-plans`, `requesting-code-review`, or `receiving-code-review` →
  `coordinating-subagents` only when the user's wording explicitly enables it
  for the current task and delegation or independent review is justified;
  otherwise inline
- `systematic-debugging` → `debugging-systematically`
- `test-driven-development` or `verification-before-completion` →
  `testing-changes` only when its current trigger matches, otherwise ordinary
  verification

The old directory name is not a separate skill and does not bypass the current
trigger or authority boundary. Direct runtime lookup of a deleted name is a
documented breaking migration; do not recreate alias skills or silently claim
that lookup succeeded.

## Shared boundary

Leaves consume decisions; they do not grant permissions or create extra
ceremony. Across the series:

- preserve the requested scope and obtain a user decision before a material
  product, research, data, evaluation, architecture, or public-contract tradeoff
- separate file edits, Git mutations, delegation, and external mutations
- use the tools and repository conventions actually present
- keep one source of truth for each decision or artifact
- verify the claim being made and state uncovered boundaries

Load `governing-project-work` only when risk, mutation authority, evidence
strength, or the completion boundary needs an explicit decision. Route
unresolved intent to `shaping-solutions` and durable artifact ownership or
lifecycle to `managing-project-docs`. Otherwise continue in ordinary prose.

## Composition

A common substantial flow is:

1. govern risk, authority, evidence, or completion when needed
2. resolve intent or diagnose cause
3. select and manage durable documents when their lifecycle matters
4. shape a plan only if persistence or coordination benefits from one
5. implement, using the subagent skill only when the user enabled it
6. test the changed claims
7. perform only the Git lifecycle action the user authorized

This is a routing guide, not a mandatory pipeline. Announce the selected skill
briefly when one is used and explain why.
