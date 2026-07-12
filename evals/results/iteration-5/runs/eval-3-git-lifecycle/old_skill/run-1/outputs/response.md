I can’t truthfully report this as merged or cleaned up yet. “Everything passes” does not establish the required evidence on the merged state, and I won’t infer workspace ownership from a directory name.

Your request authorizes a local merge into `main`, but not remote synchronization: I would first inspect `HEAD`, the source branch, local `main`, worktrees, and the working tree; run the relevant verification; merge the source branch into local `main` without fetching or pulling; then rerun verification on the merged state. A successful `merge-local` action preserves the source branch and workspace.

Cleanup is a separate, potentially destructive action. Please name the exact workspace path and branch you want removed. I’ll then list the commits, uncommitted changes, and path that would be lost; deletion would proceed only after you confirm by typing `discard`. Until then, no cleanup should be performed.
