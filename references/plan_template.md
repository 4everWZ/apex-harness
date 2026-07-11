# Implementation Plan Template

Use this for durable implementation plans in `docs/plans/`.

This format is compatible with task-by-task executors such as `writing-plans` and subagent-driven development.

```markdown
# [Feature Name] Implementation Plan

> **For agentic workers:** Use the repository's plan execution workflow to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** [One sentence describing what this builds]

**Architecture:** [2-3 sentences about the approach]

**Tech Stack:** [Key technologies/libraries]

## Global Constraints

[Project-wide requirements copied verbatim from the spec: version floors,
dependency limits, naming and copy rules, platform requirements, data/eval
constraints, or other values every task must obey.]

---

### Task N: [Component Name]

**Files:**
- Create: `exact/path/to/new_file.ext`
- Modify: `exact/path/to/existing_file.ext`
- Test: `tests/exact/path/to/test_file.ext`

**Interfaces:**
- Consumes: [exact signatures, config keys, schemas, or artifacts this task uses]
- Produces: [exact signatures, config keys, schemas, or artifacts later tasks use]

- [ ] **Step 1: [Specific action]**

Describe the exact edit, contract, or acceptance condition. Include complete
code only when it is necessary to remove a material ambiguity; otherwise keep
implementation details in the implementation and tests rather than duplicating
them in the plan.

- [ ] **Step 2: [Verification action]**

Run: `[exact command]`
Expected: `[observable result]`
```

Optional reference lines, inserted after `Tech Stack` only when applicable:

```markdown
**Spec:** [Link to `docs/specs/...` when this plan comes from a written spec]
**Matrix:** [Link to `docs/matrix_*.md` when one exists or is required]
**Tradeoffs:** [Link to `docs/tradeoffs.md#TRD-...` when relevant]
```

## Rules

- Put approved, durable implementation plans in `docs/plans/`.
- Include `Spec`, `Matrix`, and `Tradeoffs` links only when those artifacts exist
  or the active governance decision lists them in documentation obligations.
- Do not duplicate matrix rows, tradeoff narratives, or handoff status in the plan.
- Use links for progressive disclosure; load linked docs only when the current task needs them.
- Each task should be independently reviewable and testable.
- Plans specify responsibilities, interfaces, constraints, acceptance criteria,
  and verification. They are not a second copy of the implementation.
- Include commit boundaries only when the active Git policy authorizes commits;
  never infer push, merge, worktree, discard, or named external-mutation
  authority from a plan.
