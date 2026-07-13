# Workflow Contract

Use this reference only when a substantial task needs an explicit operating
boundary.

## Risk and verification

| Level | Typical scope | Evidence |
|---|---|---|
| focused | bounded behavior with low blast radius | targeted check of the changed claim |
| standard | multi-file or externally visible behavior | focused checks plus relevant integration or regression coverage |
| critical | security, migration, public contract, data/evaluation semantics, or costly failure | independent review and evidence across affected boundaries |

Risk can change as investigation reveals new facts. Increase or reduce the
mechanism accordingly; do not preserve ceremony for its own sake.

## Authority

Treat these as separate operations:

- edit working-tree files
- stage selected paths
- create a local commit
- create or delete a ref
- create or remove a worktree
- merge, push, or force-update a ref
- discard work
- delegate read-only or mutating work after explicit user enablement
- perform a named external mutation

Use the authority granted by higher-priority instructions literally. Stage only
task paths, and never include unrelated staged or working-tree changes in a
commit. Destructive and remote operations need an explicit target and authority.
Subagents are read-only unless their role and mutation scope are explicit.

## Evidence and freshness

Tie evidence to the claim and observed state. For Git-backed work record:

1. `HEAD` (or `HEAD: unborn` and branch)
2. `git status --short --branch`
3. staged and unstaged diff summaries
4. relevant paths or focused diff when summaries are ambiguous
5. explicit ignored, generated, external, or otherwise Git-invisible inputs
6. command exit status or inspection outcome and uncovered boundaries

These summaries describe observed state; they are not content identities.
Evidence remains reusable only while code and inputs relevant to the claim are
known to match. If that is unclear, rerun the smallest affected check. A message
boundary alone does not make evidence stale, and a clean `HEAD` does not identify
external inputs.

## Mechanism selection

- Shape intent only when a material design choice remains.
- Persist a plan only when later execution or coordination benefits.
- Use test-first development when an automated failing test can credibly define
  the contract before implementation.
- Debug before fixing when cause is unknown.
- Isolate with a worktree when repository state or parallel work makes in-place
  edits unsafe.
- Apply `coordinating-subagents` only when the user explicitly enables it for
  the current task and bounded roles have clear inputs, authority, and review
  boundaries. Otherwise leave subagent behavior to Codex and its runtime
  defaults without imposing this skill's workflow.
- Request independent review when risk or lifecycle justifies another judgment.
