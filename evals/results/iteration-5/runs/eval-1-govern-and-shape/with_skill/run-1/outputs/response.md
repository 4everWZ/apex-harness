I’m using APEX’s `governing-project-work` first, then `shaping-solutions`. This is **critical-risk** work because it changes a public interface, persisted data semantics, and evaluation methodology; those choices need an explicit boundary before behavior changes.

The initial boundary is:

- Success means one cohesive cache contract shared by the relevant modules; deterministic, versioned keys and schema; defined invalidation, corruption, concurrency, and old-entry behavior; an intentional CLI compatibility story; and a benchmark protocol whose results remain reproducible and interpretable.
- I will not change dataset meaning, silently re-baseline performance, or add unrelated storage/backend abstractions.
- Your request authorizes repository inspection and working-tree implementation. It does not by itself authorize commits, creating refs/worktrees, pushing, or other external effects. Subagents, if used, will initially be read-only and narrowly scoped.
- Evidence must cover CLI contract tests, cache unit and cross-module integration tests, schema/version transition behavior, and benchmark correctness plus before/after measurements under a pinned protocol. Documentation owning the CLI, cache format, and benchmark method must stay aligned.

I’ll first inspect the current branch/status and any existing worktree isolation, then trace the CLI entry points, dataset-loading/module boundaries, persisted formats, benchmark harness, tests, and existing design documents. Two read-only investigations are useful in parallel: one for the CLI/module/cache boundary and one for dataset and benchmark semantics. I’ll reconcile their findings against the repository myself.

After that inspection I’ll present the smallest repository-backed design, credible alternatives, and a recommendation. I will ask only about material choices the repository does not already settle—most importantly CLI compatibility, whether old cache entries are rejected/rebuilt or migrated, and whether benchmark continuity or a deliberate new baseline is required. I won’t implement an unresolved choice or guess its semantics. Once approved, I’ll persist a focused spec/plan only if the repository’s conventions or the multi-step execution need one, then implement in independently testable slices.

One Git authorization may block file edits: the repository rules require a scoped branch for risky cross-module work, while creating a ref/worktree is separate authority. If inspection shows this task is not already isolated, please authorize creation of `feature/cross-module-dataset-cache` (and a repository-local worktree if needed), or name the exact branch you want. Read-only inspection can proceed meanwhile.
