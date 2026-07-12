---
name: subagent-driven-development
description: Execute an approved multi-task implementation plan through fresh implementer and reviewer subagents when APEX has selected delegated, commit-based execution. Do not use for design discovery, read-only investigation, unborn or dirty repositories, or when delegation/review authority is absent.
---

# Subagent-Driven Development

## APEX boundary

This leaf owns delegated execution of an already approved plan. It consumes the
active APEX scope, Git authority, delegated roles, and verification boundary. It
cannot approve product choices, expand scope, create worktrees, or grant commit
authority. Use `executing-plans` when inline execution is safer or delegation is
unavailable.

## Preconditions

Use this workflow only when all of these are true:

- the plan has bounded tasks and no unresolved material decision
- APEX selected delegation and independent review
- implementer, task-reviewer, and final-reviewer roles are available and
  authorized
- `git rev-parse --verify HEAD` resolves to a commit
- the Git-visible workspace and index are clean
- controller Git authority includes the edits and task commits the workflow
  needs; delegated authority explicitly names any implementer mutations

If a precondition fails, stop before dispatch or choose an inline workflow. Tool
availability alone never selects delegation.

## State and freshness

Git and the approved plan are the sources of truth. Do not create a parallel
run-context, progress ledger, serialized workspace identity, report file, or
review-package file.

Before each dispatch, record in the controller's active task state:

- full `HEAD`
- `git status --short --branch`
- staged and unstaged diff summaries
- the exact plan task and acceptance criteria
- relevant paths and every explicit extra input
- delegated edit, stage, and commit authority, if any

These summaries describe the observed state; they are not content identity. If
relevant uncommitted content or an extra input may have changed, inspect the
actual diff or content-sensitive identifier and refresh only the affected
evidence.

After compaction or interruption, reconcile the plan with full commit SHAs,
`git log`, status, and relevant diffs. Never skip a task because a task number or
old summary says it was complete. If the evidence is ambiguous, re-inspect or
re-review the affected task.

## Task loop

For each task:

1. Capture the task's `BASE` as the current full `HEAD`.
2. Dispatch one fresh implementer with only:
   - the exact task text and acceptance criteria
   - necessary architectural context and interfaces
   - relevant paths and explicit inputs
   - an authority record that separates edits, staging, and commits
   - the required tests and response contract
3. The implementer returns `DONE`, `DONE_WITH_CONCERNS`, `NEEDS_CONTEXT`, or
   `BLOCKED`, plus changed paths, tests run and results, commit SHA if delegated,
   and concerns. It does not write separate handoff artifacts.
4. Inspect the returned evidence and the real Git state. Reject changes outside
   the authorized path set or evidence that does not cover the task.
5. If the controller owns the commit, require an empty index, stage only the
   task allowlist, verify the cached path list, then create one coherent commit.
   If delegated commit authority was explicit, verify the reported `BASE..HEAD`
   range and do not create a second commit.
6. Dispatch an independent task reviewer with the task contract, relevant
   explicit inputs, implementer result, and the actual `BASE..HEAD` diff (or the
   scoped working-tree diff for authorized edit-only work).
7. The reviewer returns separate spec-compliance and implementation-quality
   verdicts with Critical, Important, and Minor findings.
8. Send all blocking findings to one bounded fixer, then re-review. A fix that
   exposes a material decision returns to the user before implementation.
9. Mark the task complete in the active plan/todo only after the review is clean
   and the recorded full commit range still matches Git.

Do not run implementers in parallel against the same working tree. Read-only
investigations belong to `dispatching-parallel-agents`.

## Dispatch contracts

### Implementer

The implementer may edit only when delegated `edit` authority is explicit. It
may stage or commit only when those capabilities are separately explicit. A
plan containing `git add` or `git commit` is not an authority source.

The response must include:

- status
- changed paths
- tests and exact outcomes
- TDD red/green evidence when TDD was selected
- commit SHA or “changes remain uncommitted”
- concerns and missing context

### Reviewer

The reviewer is read-only. It receives one task, not accumulated session
history, and independently inspects the actual diff. It must not infer worktree,
edit, commit, merge, push, or external-mutation authority.

Critical and Important findings block the task. Minor findings are recorded for
the final whole-branch review and are not silently discarded.

## Final gate

After all tasks:

1. Compute the branch range from the recorded starting commit or merge base.
2. Run the verification needed for the final code and explicit inputs.
3. Dispatch one fresh final reviewer with the approved plan and actual full
   branch diff.
4. Fix and re-review blocking findings.
5. Claim completion only when the final evidence is relevant and fresh.

Branch integration, publication, or cleanup requires a separate user request
and the `finishing-a-development-branch` boundary.

## Stop conditions

Stop and return to the user when:

- the plan contradicts itself or a material choice is unresolved
- the repository becomes dirty with unrelated work
- required delegation, review, or Git authority is missing
- a subagent reports a scope, product, data, evaluation, or public-contract
  decision
- the actual Git range cannot be reconciled with the task evidence
