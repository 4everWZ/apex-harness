---
name: finishing-a-development-branch
description: Use after verified implementation when the user explicitly requests a branch action such as local merge, push/PR creation, retention, or destructive discard. Do not use merely because coding is complete.
---

# Finishing a Development Branch

## APEX boundary

This leaf owns one explicitly selected branch-lifecycle action. It consumes APEX
Git and external-mutation authority; completion alone grants none. Remote sync,
push, PR creation, merge, branch deletion, and workspace removal are separate
actions.

## Preconditions

1. Verify the implementation with the selected evidence path.
2. Inspect `HEAD`, branch state, worktree state, base branch, and working tree.
3. If verification fails or unrelated changes make the action unsafe, stop.
4. Never infer workspace ownership from its directory name.

## Present actions

Offer only actions supported by the current state:

- **merge-local** — merge into the local base branch; preserve source branch and
  workspace afterward
- **push-pr** — push the named branch and create a PR only when both operations
  are authorized and the runtime exposes a verified PR capability
- **keep** — preserve branch and workspace unchanged
- **discard** — permanently delete the explicitly listed branch/workspace only
  after destructive confirmation

Use these action IDs in the user's choice and in execution. Detached `HEAD`
cannot use `merge-local` until an authorized named branch is created; do not
renumber actions into a different meaning.

## Execute the selected action

### merge-local

Require `merge` authority for the named source and base branches. Switch to the
local base and merge the source branch. Do not fetch or pull unless
the user separately authorizes remote synchronization. Re-run the relevant tests
on the merged state. Preserve the source branch and workspace; cleanup requires
a separate explicit request.

### push-pr

Push only the explicitly named branch/ref. Then use the PR capability actually
exposed by the runtime. If PR creation is unavailable or fails, report that the
branch was pushed but the PR was not created; do not claim the combined action
completed.

### keep

Report the branch name, `HEAD`, and workspace path. Make no mutation.

### discard

List the exact branch, commits, uncommitted changes, and workspace path that
would be lost. Require the user to type `discard` after seeing that list.
Deleting the named branch additionally requires `delete-ref` authority. Removing
a clean agent-created worktree requires `worktree` authority; losing any
uncommitted or unpublished work additionally requires `discard` authority.
Remove only confirmed targets covered by all applicable authorities. A host-managed workspace or a workspace
without recorded agent-creation provenance is preserved unless the user
explicitly names that exact path for deletion in the confirmation.

## Completion report

Report the requested action, commands or platform operations performed, final
branch/workspace state, verification result, and anything not completed. Never
turn a successful merge or push into implied cleanup.
