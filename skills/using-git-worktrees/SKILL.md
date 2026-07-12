---
name: using-git-worktrees
description: Use when governance, change risk, a dirty or shared working tree, parallel branch work, or explicit user preference requires isolation; ensures an isolated workspace exists via native tools or git worktree fallback. Do not use automatically for every implementation plan or small clean single-branch change.
---

# Using Git Worktrees

## APEX boundary

This leaf owns workspace isolation after APEX or the user selects it. It consumes Git authority, platform capability, and environment policy; it cannot infer permission to create a branch, edit ignore rules, install dependencies, or remove a workspace. Without a full decision record, the `using-apex` lightweight boundary applies and safe in-place work is preferred when isolation is optional.

## Overview

Ensure work happens in an isolated workspace. Prefer your platform's native worktree tools. Fall back to manual git worktrees only when no native tool is available.

**Core principle:** Detect existing isolation first. Then use native tools. Then fall back to git. Never fight the harness.

**Announce at start:** "I'm using the using-git-worktrees skill to set up an isolated workspace."

## When Isolation Is Justified

Use a worktree for high-risk or broad changes, parallel branch work, a dirty or shared checkout, or an explicit repository, governance, or user requirement. Skip creation for low-risk local edits, clean single-branch work that does not need isolation, and sessions already running in an isolated workspace.

## Step 0: Detect Existing Isolation

**Before creating anything, check if you are already in an isolated workspace.**

```bash
GIT_DIR=$(cd "$(git rev-parse --git-dir)" 2>/dev/null && pwd -P)
GIT_COMMON=$(cd "$(git rev-parse --git-common-dir)" 2>/dev/null && pwd -P)
BRANCH=$(git branch --show-current)
```

**Submodule guard:** `GIT_DIR != GIT_COMMON` is also true inside git submodules. Before concluding "already in a worktree," verify you are not in a submodule:

```bash
# If this returns a path, you're in a submodule, not a worktree — treat as normal repo
git rev-parse --show-superproject-working-tree 2>/dev/null
```

**If `GIT_DIR != GIT_COMMON` (and not a submodule):** You are already in a linked worktree. Skip to Step 2 (Project Setup). Do NOT create another worktree.

Report with branch state:
- On a branch: "Already in isolated workspace at `<path>` on branch `<name>`."
- Detached HEAD: "Already in isolated workspace at `<path>` (detached HEAD, externally managed). Branch creation needed at finish time."

**If `GIT_DIR == GIT_COMMON` (or in a submodule):** You are in a normal repo checkout.

If active governance already selected worktree isolation, do not ask the user to
approve that mechanism again. Continue to the concrete path/ref disclosure and
authority check in Step 1.

Without a full decision record, if isolation is optional and the user has not
expressed a preference, ask whether it is desired:

> "Would you like me to set up an isolated worktree? It protects your current branch from changes."

The answer selects isolation; it does not yet authorize a particular path or
branch effect. If the user declines, re-evaluate the active governance boundary: work in place only when
the risk, cleanliness, sharing state, and requested isolation purpose make that
safe. Otherwise report that required isolation was declined and stop before
setup or implementation.

## Step 1: Create Isolated Workspace

**You have two mechanisms. Try them in this order.**

Before either mechanism, determine and disclose the exact target path, branch,
and whether the mechanism creates a ref. Require `worktree` in the active APEX
Git authority. Any mechanism that creates a branch or tag—including a native
tool that creates one implicitly—also requires `create-ref` for that exact ref;
without it, attach only an already authorized existing branch or stop. When no
full decision record exists, obtain an explicit higher-priority instruction
after this disclosure. General consent to isolation or tool availability is
not mutation authority.

### 1a. Native Worktree Tools (preferred)

Do you already have a native worktree tool such as `EnterWorktree`,
`WorktreeCreate`, a `/worktree` command, or a `--worktree` flag? Inspect its
documented path and ref effects. Use it only after the exact effects have the
required `worktree` and, when applicable, `create-ref` authority; then skip to
Step 2.

Native tools handle directory placement, branch creation, and cleanup automatically. Using `git worktree add` when you have a native tool creates phantom state your harness can't see or manage.

Only proceed to Step 1b if you have no native worktree tool available.

### 1b. Git Worktree Fallback

**Only use this if Step 1a does not apply** — you have no native worktree tool available. Create a worktree manually using git.

#### Directory Selection

Follow this priority order. Explicit user preference always beats observed filesystem state.

1. **Check your instructions for a declared worktree directory preference.** If the user has already specified one, use it without asking.

2. **Check for an existing project-local worktree directory:**
   ```bash
   ls -d .worktrees 2>/dev/null     # Preferred (hidden)
   ls -d worktrees 2>/dev/null      # Alternative
   ```
   If found, use it. If both exist, `.worktrees` wins.

3. **If there is no other guidance available**, default to `.worktrees/` at the project root.

#### Safety Verification (project-local directories only)

**MUST verify directory is ignored before creating worktree:**

```bash
git check-ignore -q .worktrees 2>/dev/null || git check-ignore -q worktrees 2>/dev/null
```

**If NOT ignored:** Do not mutate `.gitignore` or commit automatically. If edit
authority permits, propose adding the selected directory to `.gitignore`; make
that edit only with the applicable repository/user authorization. Commit it
only when commit authority is also explicit. Otherwise choose an authorized
location or stop with the isolation boundary.

**Why critical:** Prevents accidentally committing worktree contents to repository.

#### Create the Worktree

With `create-ref` authority for the exact new branch:

```bash
path="$LOCATION/$BRANCH_NAME"
git worktree add "$path" -b "$BRANCH_NAME"
cd "$path"
```

Without `create-ref`, verify the explicitly authorized local branch already
exists, then attach it without `-b`:

```bash
path="$LOCATION/$EXISTING_BRANCH"
git show-ref --verify "refs/heads/$EXISTING_BRANCH"
git worktree add "$path" "$EXISTING_BRANCH"
cd "$path"
```

**Sandbox fallback:** If `git worktree add` fails with a permission error,
report that the sandbox blocked isolation. Work in place only after the same
safe-in-place check used for declined consent: risk and repository state must
show that isolation was optional. If isolation was required for safety, stop;
do not run setup, tests, or implementation in the current checkout.

## Step 2: Project Setup

Before running setup, read repository instructions and any active governance environment policy. Identify the intended package manager and target environment; never infer that a manifest authorizes installation into a base, system, global, or otherwise shared environment. Prefer the repository's standard toolchain, then its active project environment. If the correct target cannot be established safely, ask the user before changing dependencies.

Only after that environment gate, run the repository-appropriate setup. The commands below are examples, not blind auto-detection rules:

```bash
# Node.js
if [ -f package.json ]; then npm install; fi

# Rust
if [ -f Cargo.toml ]; then cargo build; fi

# Python
if [ -f requirements.txt ]; then pip install -r requirements.txt; fi
if [ -f pyproject.toml ]; then poetry install; fi

# Go
if [ -f go.mod ]; then go mod download; fi
```

## Step 3: Verify Clean Baseline

Run tests to ensure workspace starts clean:

```bash
# Use project-appropriate command
npm test / cargo test / pytest / go test ./...
```

**If tests fail:** Report failures, ask whether to proceed or investigate.

**If tests pass:** Report ready.

### Report

```
Worktree ready at <full-path>
Tests passing (<N> tests, 0 failures)
Ready to implement <feature-name>
```

## Quick Reference

| Situation | Action |
|-----------|--------|
| Already in linked worktree | Skip creation (Step 0) |
| In a submodule | Treat as normal repo (Step 0 guard) |
| Native worktree tool available | Use it (Step 1a) |
| No native tool | Git worktree fallback (Step 1b) |
| `.worktrees/` exists | Use it (verify ignored) |
| `worktrees/` exists | Use it (verify ignored) |
| Both exist | Use `.worktrees/` |
| Neither exists | Check instruction file, then default `.worktrees/` |
| Directory not ignored | Obtain edit/commit authority, or choose another authorized location |
| Permission error on create | Apply safe-in-place gate; otherwise stop |
| Tests fail during baseline | Report failures + ask |
| No repository-authorized setup path | Skip dependency changes |

## Common Mistakes

### Fighting the harness

- **Problem:** Using `git worktree add` when the platform already provides isolation
- **Fix:** Step 0 detects existing isolation. Step 1a defers to native tools.

### Skipping detection

- **Problem:** Creating a nested worktree inside an existing one
- **Fix:** Always run Step 0 before creating anything

### Skipping ignore verification

- **Problem:** Worktree contents get tracked, pollute git status
- **Fix:** Always use `git check-ignore` before creating project-local worktree

### Assuming directory location

- **Problem:** Creates inconsistency, violates project conventions
- **Fix:** Follow priority: explicit instructions > existing project-local directory > default

### Proceeding with failing tests

- **Problem:** Can't distinguish new bugs from pre-existing issues
- **Fix:** Report failures, get explicit permission to proceed

## Red Flags

**Never:**
- Create a worktree when Step 0 detects existing isolation
- Use `git worktree add` when you have a native worktree tool (e.g., `EnterWorktree`). This is the #1 mistake — if you have it, use it.
- Skip Step 1a by jumping straight to Step 1b's git commands
- Create worktree without verifying it's ignored (project-local)
- Skip baseline test verification
- Proceed with failing tests without asking

**Always:**
- Run Step 0 detection first
- Prefer native tools over git fallback
- Follow directory priority: explicit instructions > existing project-local directory > default
- Verify directory is ignored for project-local
- Resolve the repository toolchain and target environment before project setup
- Verify clean test baseline
