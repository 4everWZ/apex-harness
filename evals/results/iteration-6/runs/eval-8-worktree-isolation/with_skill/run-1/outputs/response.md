Use APEX once as the router, then select only `managing-git`. The unrelated edits plus parallel feature work justify worktree isolation; they do not, by themselves, require shaping, debugging, testing, or governance leaves.

The safe route is:

1. Perform read-only inspection first: identify the repository root, current branch and `HEAD`, linked worktrees, working-tree status, staged content, and relevant refs. Confirm the runtime has not already placed the task in a dedicated worktree.
2. Leave the current checkout and all unrelated user edits untouched. Do not stash, reset, switch branches, clean files, or reuse that dirty checkout for the feature.
3. Establish the intended base ref. Because creating a branch mutates a ref, obtain authority for the exact new branch name if it has not been specified; “a new branch” alone does not identify the exact ref.
4. Once separately authorized to mutate Git, prefer a runtime-native worktree facility if available. Otherwise choose the user/repository-specified location, then an existing `.worktrees/` or `worktrees/`, defaulting to repository-root `.worktrees/`. Before creating a project-local worktree, verify that location is ignored.
5. Create the authorized branch and attach it to the separate worktree from the intended base. Run setup only after identifying the repository’s package manager and isolated target environment, then establish a credible baseline and report any pre-existing failure before implementation.
6. Keep implementation and verification confined to the isolated worktree. Completion grants no authority to merge, push, open a PR, remove the worktree, delete the branch, or discard anything; perform only a separately requested lifecycle action.

For this routing-only request, stop after describing and, where useful, read-only inspecting the route. Perform no Git mutation. Report the planned branch/ref and worktree path, the observed dirty state, and that the unrelated edits remain untouched.
