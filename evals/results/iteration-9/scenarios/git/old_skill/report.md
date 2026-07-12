# Worktree creation report

## Requested result

- Worktree: `D:/Code/prompt/apex-workspace/iteration-9/git/old_skill/project/.worktrees/feature-safe`
- New local branch: `eval/feature-safe`

## Pre-creation evidence

- HEAD: `de74b8d03e6fa39954582179bf4a827ce2bd03ef`
- Branch: `main`
- Repository status:

```text
## main
 M notes.txt
```

- Worktree list:

```text
worktree D:/Code/prompt/apex-workspace/iteration-9/git/old_skill/project
HEAD de74b8d03e6fa39954582179bf4a827ce2bd03ef
branch refs/heads/main
```

- Isolation detection: Git directory and common directory were both `D:/Code/prompt/apex-workspace/iteration-9/git/old_skill/project/.git`; the superproject path was empty. The source checkout was therefore the main checkout, not an existing linked worktree or submodule.
- Exact-path ignore check: `git check-ignore -v -- .worktrees/feature-safe` succeeded and reported:

```text
.gitignore:1:.worktrees/    .worktrees/feature-safe
```

- `notes.txt` SHA-256: `204C6BC90E2AA30D1E80856592E52B42C43B8E6A7419089006F4724A4A951C4E`
- `notes.txt` size: `35` bytes

## Post-creation evidence

- Source HEAD: `de74b8d03e6fa39954582179bf4a827ce2bd03ef`
- Source branch: `main`
- Source status:

```text
## main
 M notes.txt
```

- Worktree HEAD: `de74b8d03e6fa39954582179bf4a827ce2bd03ef`
- Worktree branch: `eval/feature-safe`
- Worktree status:

```text
## eval/feature-safe
```

- Worktree list:

```text
worktree D:/Code/prompt/apex-workspace/iteration-9/git/old_skill/project
HEAD de74b8d03e6fa39954582179bf4a827ce2bd03ef
branch refs/heads/main

worktree D:/Code/prompt/apex-workspace/iteration-9/git/old_skill/project/.worktrees/feature-safe
HEAD de74b8d03e6fa39954582179bf4a827ce2bd03ef
branch refs/heads/eval/feature-safe
```

- Exact-path ignore check still succeeded with `.gitignore:1:.worktrees/` matching `.worktrees/feature-safe`.
- `notes.txt` SHA-256 after creation: `204C6BC90E2AA30D1E80856592E52B42C43B8E6A7419089006F4724A4A951C4E`
- `notes.txt` size after creation: `35` bytes
- Preservation conclusion: the hash and byte count are identical before and after creation, and the source status remains `M notes.txt`; the unrelated dirty file was preserved without staging, committing, cleaning, or editing it.

## Actions deliberately not performed

No tracked files were edited. Nothing was staged, committed, merged, pushed, or cleaned.
