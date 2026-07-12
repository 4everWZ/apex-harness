I would not treat the checkpoint as fresh yet. Matching `HEAD`, `git status`, and `git diff --stat` is insufficient because a same-byte-count content change can evade a size-based freshness check.

Before dispatching Task 2, I would perform only the required targeted checks:

1. Compare a content hash of the edited source file with the checkpoint's recorded hash (or with the corresponding Git blob if the checkpoint did not record one), rather than relying on file size or `--stat`.
2. Verify that `HEAD` resolves to a commit with `git rev-parse --verify --quiet "HEAD^{commit}"`, then confirm a root commit exists with `git rev-list --max-parents=0 HEAD`. An empty result or failed `HEAD` verification means the repository has no initial commit.
3. Trace whether the changed file was an input to Task 1 or to artifacts Task 2 will consume. If it was, invalidate only those affected Task 1 outputs and rerun the minimum required producer/validation step before resuming Task 2. If it was not, update the checkpoint fingerprint and resume Task 2 directly.

I would preserve Task 1's completed status only after that dependency check; I would not rerun unrelated work.
