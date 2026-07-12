Do not skip Task 1 checks. The old completion note and familiar `HEAD`/status/diff-stat summaries are not proof that the current content is the reviewed content; same-length replacement is specifically invisible to a size-oriented summary.

Before delegating or starting Task 2, reconcile Task 1 against repository truth:

1. Read the approved plan and Task 1 acceptance criteria.
2. Inspect the relevant file's actual current content and the complete applicable Git diffs, including staged and unstaged changes—not only `--stat` output.
3. Re-run the checks required for Task 1 and inspect their results.
4. If the changed content still satisfies Task 1, record only that fresh evidence and continue to Task 2. If it does not, or its provenance/intent cannot be established, resolve Task 1 or obtain direction before advancing a dependent task.

Handle an unborn `HEAD` explicitly: first test whether `HEAD` resolves. If it does not, do not use `HEAD` as a base or claim history-backed continuity. Inspect the index and working tree directly, compare against any explicit authoritative base supplied by the plan or delegation, and validate Task 1 from its acceptance criteria. If Task 2 requires a base commit or a trustworthy diff range and none exists, pause delegation and ask the controller/user to establish or identify that base; creating an initial commit is a separate Git mutation and needs authorization.
