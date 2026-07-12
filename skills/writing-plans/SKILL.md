---
name: writing-plans
description: Creates durable, execution-ready implementation plans without duplicating the implementation. Use before coding when approved requirements span multiple dependent steps and a persisted plan adds value.
---

# Writing Plans

## APEX boundary

This leaf owns a durable execution plan only when APEX or the user selects one. It consumes approved intent, authority, verification, and document ownership; it cannot create a parallel spec or grant commit/delegation authority. Without a full decision record, the `using-apex` lightweight boundary applies.

## Overview

Write implementation plans that are complete for their intended executor and proportionate to task risk. Identify files, behavior, verification, and relevant documentation without duplicating an accepted spec. DRY. YAGNI. Use TDD and commit boundaries when justified by the active governance and repository workflow.

Assume they are a skilled developer, but know almost nothing about our toolset or problem domain. Assume they don't know good test design very well.

**Announce at start:** "I'm using the writing-plans skill to create the implementation plan."

**Context:** If working in an isolated worktree, it should have been created via the `using-git-worktrees` skill at execution time.

**Save plans to:** `docs/plans/YYYY-MM-DD-<feature-name>.md`
- (User preferences for plan location override this default)
- Repository and active governance documentation conventions override this fallback. Plans must link to, not replace, the active spec, design, matrix, or tradeoff source of truth.

## Scope Check

If the spec covers multiple independent subsystems, it should have been broken into sub-project specs during brainstorming. If it wasn't, suggest breaking this into separate plans — one per subsystem. Each plan should produce working, testable software on its own.

## File Structure

Before defining tasks, map out which files will be created or modified and what each one is responsible for. This is where decomposition decisions get locked in.

- Design units with clear boundaries and well-defined interfaces. Each file should have one clear responsibility.
- You reason best about code you can hold in context at once, and your edits are more reliable when files are focused. Prefer smaller, focused files over large ones that do too much.
- Files that change together should live together. Split by responsibility, not by technical layer.
- In existing codebases, follow established patterns. If the codebase uses large files, don't unilaterally restructure - but if a file you're modifying has grown unwieldy, including a split in the plan is reasonable.

This structure informs the task decomposition. Each task should produce self-contained changes that make sense independently.

## Task Right-Sizing

A task is the smallest unit that carries its own test cycle and is worth a
fresh reviewer's gate. When drawing task boundaries: fold setup,
configuration, scaffolding, and documentation steps into the task whose
deliverable needs them; split only where a reviewer could meaningfully
reject one task while approving its neighbor. Each task ends with an
independently testable deliverable.

## Bite-Sized Task Granularity

When TDD is required for a task, use explicit red-green-refactor actions:
- "Write the failing test" - step
- "Run it to make sure it fails" - step
- "Implement the minimal code to make the test pass" - step
- "Run the tests and make sure they pass" - step
- "Commit" - step only when the active Git policy authorizes commits

## Plan Document Header

**Every durable plan uses this header unless the repository or active
governance defines a canonical compatible template:**

```markdown
# [Feature Name] Implementation Plan

> **For agentic workers:** Use the repository's plan execution workflow, subagent-driven or inline, at the intensity justified by active governance. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** [One sentence describing what this builds]

**Architecture:** [2-3 sentences about approach]

**Tech Stack:** [Key technologies/libraries]

## Global Constraints

[The spec's project-wide requirements — version floors, dependency limits,
naming and copy rules, platform requirements — one line each, with exact
values copied verbatim from the spec. Every task's requirements implicitly
include this section.]

---
```

Optional reference lines, inserted after `Tech Stack` only when applicable:

```markdown
**Spec:** [Link to `docs/specs/...` when this plan comes from a written spec]
**Matrix:** [Link only when a spec-to-implementation matrix exists or is required]
**Tradeoffs:** [Link only when a project-level tradeoff entry is relevant]
```

## Task Structure

Use the five-step TDD shape below only when TDD is required for the task. Otherwise combine implementation with the smallest credible verification sequence, while still naming exact commands and expected observable results.

````markdown
### Task N: [Component Name]

**Files:**
- Create: `exact/path/to/file.py`
- Modify: `exact/path/to/existing.py:123-145`
- Test: `tests/exact/path/to/test.py`

**Interfaces:**
- Consumes: [what this task uses from earlier tasks — exact signatures]
- Produces: [what later tasks rely on — exact function names, parameter
  and return types. A task's implementer sees only their own task; this
  block is how they learn the names and types neighboring tasks use.]

- [ ] **Step 1: Write the failing test**

```python
def test_specific_behavior():
    result = function(input)
    assert result == expected
```

- [ ] **Step 2: Run test to verify it fails**

Run: `pytest tests/path/test.py::test_name -v`
Expected: FAIL with "function not defined"

- [ ] **Step 3: Write minimal implementation**

```python
def function(input):
    return expected
```

- [ ] **Step 4: Run test to verify it passes**

Run: `pytest tests/path/test.py::test_name -v`
Expected: PASS

- [ ] **Step 5: Commit** *(include only when commit authority is explicit)*

```bash
git add tests/path/test.py src/path/file.py
git commit -m "feat: add specific feature"
```
````

## No Placeholders

Every step must contain the contracts, decisions, and acceptance details an
engineer needs. These are **plan failures** — never write them:
- "TBD", "TODO", "implement later", "fill in details"
- "Add appropriate error handling" / "add validation" / "handle edge cases"
- "Write tests for the above" (without actual test code)
- "Similar to Task N" without naming the shared contract or reusable source
- Steps that omit the interface, acceptance condition, or verification needed to resolve material ambiguity
- References to types, functions, or methods not defined in any task

## Remember
- Exact file paths always
- Show complete code only when it removes material ambiguity; otherwise specify
  the responsibility, interface, constraints, and observable result without
  duplicating the future implementation
- Exact commands with expected output
- Include optional Spec / Matrix / Tradeoffs links only when those artifacts exist or are required; do not create extra documents just to fill the header
- Link related docs for progressive disclosure instead of copying their full contents into the plan
- DRY, YAGNI, risk-appropriate testing, coherent logical commits
- Include commit boundaries only when active governance grants commit authority;
  plans never imply push, merge, worktree, discard, or named external-mutation
  authority

## Self-Review

After writing the complete plan, look at the spec with fresh eyes and check the plan against it. This is a checklist you run yourself — not a subagent dispatch.

**1. Spec coverage:** Skim each section/requirement in the spec. Can you point to a task that implements it? List any gaps.

**2. Placeholder scan:** Search your plan for red flags — any of the patterns from the "No Placeholders" section above. Fix them.

**3. Type consistency:** Do the types, method signatures, and property names you used in later tasks match what you defined in earlier tasks? A function called `clearLayers()` in Task 3 but `clearFullLayers()` in Task 7 is a bug.

If you find issues, fix them inline. No need to re-review — just fix and move on. If you find a spec requirement with no task, add the task.

## Execution Handoff

After saving the plan, select or offer an execution mode proportionate to active governance and task structure. Default to inline execution for lightweight or tightly coupled work. Offer subagent-driven development for high-risk plans with multiple substantially independent tasks where per-task review earns its cost.

**"Plan complete and saved to `docs/plans/<filename>.md`. Two execution options:**

**1. Inline Execution (default when sufficient)** - Execute tasks in this session with proportionate checkpoints

**2. Subagent-Driven** - Dispatch a fresh subagent per independent task with per-task review

**Which approach?"**

**If Inline Execution chosen:**
- Use the repository's inline plan executor or execute directly in the current session.
- Match checkpoints to active governance; do not manufacture batch ceremony for a small plan.

**If Subagent-Driven chosen:**
- Use subagent-driven-development.
- Fresh subagent per task plus task review is justified only when the task boundaries are genuinely independent enough to benefit.

When `apex-governance` is active, use its `references/plan_template.md` as the canonical plan shape. Do not emit a second parallel plan format.
