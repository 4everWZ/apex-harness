---
name: requesting-code-review
description: Dispatches an independent code review. Use when active governance, implementation risk, or a requested merge/review gate calls for reviewer judgment and a suitable reviewer is available.
---

# Requesting Code Review

## APEX boundary

This leaf owns independent review dispatch and its evidence handoff. It consumes the APEX review selection, scope, roles, and authority; it cannot manufacture a review gate, worktree, commit, or mutation. Without a full decision record, the `using-apex` lightweight boundary applies and review remains read-only.

Dispatch a code reviewer subagent to catch issues before they cascade. The reviewer gets precisely crafted context for evaluation — never your session's history. This keeps the reviewer focused on the work product, not your thought process, and preserves your own context for continued work.

**Core principle:** Review early, review often.

## When to Request Review

**Required when selected by the active workflow or governance:**
- At task gates in subagent-driven development
- After a major or high-risk feature when independent judgment is part of the verification path
- Before merge when repository policy or the user requires review

**Optional but valuable:**
- When stuck (fresh perspective)
- Before refactoring (baseline check)
- After fixing complex bug

Reviewer availability alone does not make review mandatory. For low-risk work,
prefer the least expensive credible verification path chosen by governance.

## How to Request

**1. Select a review scope:**

For committed work, use a commit range:
```bash
BASE_SHA=$(git rev-parse HEAD~1)  # or origin/main
HEAD_SHA=$(git rev-parse HEAD)
```

For authorized edits that are intentionally uncommitted, do not create a
commit merely to enable review. Give the reviewer:

- the base `HEAD`
- `git status --short --branch`
- staged and unstaged summaries from `git diff --cached --stat` and
  `git diff --stat`
- the focused diff or changed paths the reviewer must inspect
- an explicit list of untracked, ignored, generated, external, or otherwise
  Git-invisible inputs that can affect the review, with the best available
  version or source identifier

State which mode applies. A reviewer must not assume `HEAD` includes working-tree
changes.

Freeze the review-relevant paths and explicit extra inputs from capture until
the reviewer returns. These summaries describe the observed state; they are not
a byte-for-byte identity and cannot detect every later edit. Before reporting,
the reviewer rechecks `HEAD`, status, and the relevant diff summaries. If the
scope may have changed or equivalence cannot be established cheaply, restart
the review or narrow the freshness claim to the observed inspection.

**2. Dispatch code reviewer subagent:**

If read-only delegation is authorized and supported, dispatch a
`general-purpose` subagent using [code-reviewer.md](code-reviewer.md). If
delegation is forbidden, use an already-authorized human or external reviewer
when available. Otherwise report that the required independent review cannot be
performed and stop at that boundary; controller self-review is not relabeled as
independent review. Reviewer availability alone never grants delegation or an
external message/update permission.

**Placeholders:**
- `{DESCRIPTION}` - Brief summary of what you built
- `{PLAN_OR_REQUIREMENTS}` - What it should do
- `{REVIEW_SCOPE}` - committed range or working-tree scope and untracked files
- `{BASE_SHA}` - Starting commit for committed-range mode
- `{HEAD_SHA}` - Ending commit for committed-range mode

**3. Act on feedback:**
- If edit authority exists, fix Critical issues before proceeding
- If edit authority exists, fix Important issues before proceeding
- If the request authorized review only, report findings and request direction;
  review authority never implies edit authority
- Note Minor issues for later
- Push back if reviewer is wrong (with reasoning)

## Example

```
[Just completed Task 2: Add verification function]

You: Let me request code review before proceeding.

BASE_SHA=$(git log --oneline | grep "Task 1" | head -1 | awk '{print $1}')
HEAD_SHA=$(git rev-parse HEAD)

[Dispatch code reviewer subagent]
  DESCRIPTION: Added verifyIndex() and repairIndex() with 4 issue types
  PLAN_OR_REQUIREMENTS: Task 2 from docs/plans/deployment-plan.md
  BASE_SHA: a7981ec
  HEAD_SHA: 3df7661

[Subagent returns]:
  Strengths: Clean architecture, real tests
  Issues:
    Important: Missing progress indicators
    Minor: Magic number (100) for reporting interval
  Assessment: Ready to proceed

You: [Fix progress indicators]
[Continue to Task 3]
```

## Integration with Workflows

**Subagent-Driven Development:**
- Review after EACH task
- Catch issues before they compound
- Fix before moving to next task

**Executing Plans:**
- Review after each task or at natural checkpoints
- Get feedback, apply, continue

**Ad-Hoc Development:**
- Review before merge
- Review when stuck

## Red Flags

**Never:**
- Skip a review required by the active governance or lifecycle decision
- Ignore Critical issues
- Proceed with unfixed Important issues
- Argue with valid technical feedback
- Modify code merely because review was requested

**If reviewer wrong:**
- Push back with technical reasoning
- Show code/tests that prove it works
- Request clarification

See template at: [code-reviewer.md](code-reviewer.md)
