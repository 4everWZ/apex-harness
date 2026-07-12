---
name: managing-git
description: Manages Git isolation and explicit branch lifecycle actions. Use when dirty or shared state, parallel work, or risk justifies a worktree, or when the user requests a merge, push/PR, branch retention, cleanup, or discard action.
---

# Managing Git

Own Git workspace isolation and branch lifecycle mechanics. This skill consumes
the active authority boundary; it never infers commit, ref, remote, merge, or
discard permission from implementation work.

## Inspect first

Before mutation, inspect the repository root, current branch and `HEAD`, linked
worktrees, status, staged content, and relevant refs. Preserve unrelated user
changes. Do not create nested isolation if the runtime already placed the task
in a dedicated worktree.

## Isolate when justified

Prefer a runtime-native worktree capability when one is actually exposed.
Otherwise use Git directly:

1. Follow an explicit repository or user location.
2. Else prefer an existing `.worktrees/`, then `worktrees/`; if neither exists,
   default to `.worktrees/` at the repository root.
3. For a project-local location, verify it is ignored before creation.
4. Creating a new branch requires authority for that exact ref. An authorized
   existing branch can be attached without creating a ref.
5. Run repository setup only after identifying its intended package manager and
   isolated target environment.
6. Establish a credible baseline. If it fails, report the failure before
   implementation so it is not confused with a regression.

If isolation is unavailable, work in place only when the active risk and
repository state make that safe.

## Finish only on request

Completion of coding does not select a branch action. When the user requests
one, inspect the final state and perform only the named operation:

- **keep**: preserve branch and workspace; report their location and `HEAD`
- **merge-local**: merge the named source into the named local base and verify
  the merged state; do not fetch or clean up implicitly
- **push-pr**: push the exact authorized ref, then create the PR only when that
  separate external action is authorized and supported
- **cleanup**: remove only a clean, agent-created worktree or an explicitly
  named target covered by authority
- **discard**: enumerate work that will be lost and require explicit destructive
  confirmation for those exact targets

Branch deletion, force updates, worktree removal, and loss of unpublished work
are distinct destructive effects. Never bundle them into merge or push.

## Report

State the requested action, affected refs and paths, observed final state,
verification outcome, and anything intentionally left untouched.
