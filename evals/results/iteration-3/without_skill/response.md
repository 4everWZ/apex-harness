Do not skip Task 1 checks. The old note and familiar HEAD/status/diff-stat are only hints; same-length content can differ without changing a diff stat, so they do not establish that the current working tree still satisfies Task 1.

Before resuming Task 2, re-establish the Git baseline and verify Task 1 against its actual acceptance criteria:

1. Test whether `HEAD` exists with `git rev-parse --verify HEAD`. Do not assume it does.
2. If `HEAD` exists, inspect the relevant file's actual diff/content (for example, `git diff -- <path>` and, where needed, compare it with `git show HEAD:<path>`), then run the Task 1 checks required by the plan.
3. If `HEAD` is unborn, do not run comparisons that require `HEAD`. Treat the index/working tree as the available source state, inspect `git status --short`, and compare staged content against Git's empty tree when useful. Verify Task 1 directly from the files and tests.
4. Continue to Task 2 only after those checks confirm Task 1 is complete. If they fail or the changed content cannot be reconciled with Task 1's criteria, stop and repair/re-plan Task 1 rather than relying on the stale completion note.

This is a verification gate, not a request to redo Task 1 automatically: inspect the minimum evidence needed, preserve unrelated changes, and record the verified baseline before implementing Task 2.
