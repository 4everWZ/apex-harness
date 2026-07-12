# Git worktree creation report

Requested action: create the project-local worktree `.worktrees/feature-safe` on the exact new local branch `eval/feature-safe` while preserving unrelated changes.

## Pre-creation state

- Repository root: `D:/Code/prompt/apex-workspace/iteration-9/git/with_skill/project`
- Current branch: `main`
- HEAD: `ddf1de5500c43eb784b542377319f482a5476fd2`
- Status:

  ```text
  ## main
   M notes.txt
  ```

- Staged changes: none
- Existing worktrees:

  ```text
  worktree D:/Code/prompt/apex-workspace/iteration-9/git/with_skill/project
  HEAD ddf1de5500c43eb784b542377319f482a5476fd2
  branch refs/heads/main
  ```

- `refs/heads/eval/feature-safe` did not exist.
- Ignore check succeeded:

  ```text
  .gitignore:1:.worktrees/    .worktrees/feature-safe
  ```

## Post-creation state

- Original worktree branch: `main`
- Original worktree HEAD: `ddf1de5500c43eb784b542377319f482a5476fd2`
- Original worktree status:

  ```text
  ## main
   M notes.txt
  ```

- Original worktree staged changes: none
- New worktree path: `D:/Code/prompt/apex-workspace/iteration-9/git/with_skill/project/.worktrees/feature-safe`
- New worktree branch: `eval/feature-safe`
- New worktree HEAD: `ddf1de5500c43eb784b542377319f482a5476fd2`
- New branch ref: `refs/heads/eval/feature-safe` -> `ddf1de5500c43eb784b542377319f482a5476fd2`
- New worktree status:

  ```text
  ## eval/feature-safe
  ```

- New worktree staged changes: none
- Final worktree list:

  ```text
  worktree D:/Code/prompt/apex-workspace/iteration-9/git/with_skill/project
  HEAD ddf1de5500c43eb784b542377319f482a5476fd2
  branch refs/heads/main

  worktree D:/Code/prompt/apex-workspace/iteration-9/git/with_skill/project/.worktrees/feature-safe
  HEAD ddf1de5500c43eb784b542377319f482a5476fd2
  branch refs/heads/eval/feature-safe
  ```

- Final ignore check:

  ```text
  .gitignore:1:.worktrees/    .worktrees/feature-safe
  ```

## Unrelated note preservation evidence

The dirty `notes.txt` was checked before and after creation:

- Size before/after: `35` bytes
- Last-write UTC before/after: `2026-07-12T15:46:18.0755428Z`
- SHA-256 before/after: `204C6BC90E2AA30D1E80856592E52B42C43B8E6A7419089006F4724A4A951C4E`
- Content before/after:

  ```text
  baseline note
  unrelated user draft
  ```

No files were staged, committed, merged, pushed, cleaned, or edited in the tracked project state.
