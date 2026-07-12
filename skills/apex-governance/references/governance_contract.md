# Governance Contract

APEX owns policy decisions when it is active. Workflow skills consume those
decisions as execution mechanisms; they do not silently broaden authority,
increase ceremony, or replace the selected verification path.

## 1. Decision Record

Before implementation, resolve the smallest decision record needed for the
task. It can be stated in prose; the field names below define the contract
between governance and workflow skills.

| Field | Allowed values | Meaning |
|---|---|---|
| `risk_tier` | `A`, `B`, `C` | Risk classification from `workflow.md` |
| `git_authority` | any subset of `edit`, `stage`, `commit`, `create-ref`, `push`, `force-push`, `delete-ref`, `merge`, `worktree`, `discard` | Maximum local/remote Git authority granted by higher-priority instructions |
| `external_mutations` | explicit named operations or `none` | Non-Git external changes such as deploy, message, issue update, or cloud-resource mutation |
| `delegated_git_authority` | subset of `git_authority`, or `none` | Git authority explicitly delegated to subagents; omission means read-only |
| `delegated_roles` | explicit role names or `none` | Subagent roles authorized for the phase, such as implementer, investigator, spec-document-reviewer, task-reviewer, or final-reviewer |
| `design_gate` | `satisfied`, `required` | Whether material intent is already approved |
| `execution_mode` | `inline`, `delegated`, `parallel-investigation` | Selected coordination mode for the current task or phase |
| `selected_mechanisms` | explicit subset of brainstorming, plan, TDD, debugging, worktree, delegation, parallel investigation, spec review, review, branch finishing | Workflow mechanisms whose predicates were evaluated and selected |
| `phases` | optional ordered phase records | Scope-specific decision records when investigation, implementation, and review legitimately use different modes |
| `verification_level` | `focused`, `standard`, `critical` | Evidence strength required for the changed claims |
| `documentation_obligations` | paths or `none` | Existing or required sources of truth that must remain aligned |
| `platform_capabilities` | observed capabilities and limits | Tools or parameters that may be used without guessing |

Omit fields that do not affect the task. Do not invent values for missing
authority or platform capabilities. Missing Git, delegated, or external
mutation permission means that mutation is not authorized. `execution_mode`
does not itself grant mutation authority.

Use `phases` only for a genuinely mixed workflow, for example read-only
parallel investigation followed by inline implementation. Each phase names its
scope, execution mode, selected mechanisms, and applicable authority; authority
does not carry into a later phase unless that phase states it.

## 2. Authority Rules

Higher-priority platform, system, developer, user, and repository instructions
establish the authority ceiling. A workflow skill may choose a cheaper
implementation detail inside that ceiling, but it must not:

- turn edit authority into commit, push, or other external mutation authority
- turn an inline decision into delegated execution
- add a design approval gate after the same material direction was approved
- replace a selected verification path with a ritual unrelated to the claim
- create documentation artifacts that governance marked unnecessary
- guess an unavailable tool, model selector, API, or runtime feature

A leaf skill may stop for safety or because its concrete preconditions are not
met. It may not treat that stop as permission to activate a larger workflow.

## 3. Mechanism Preconditions

Use a mechanism only when all of its predicates are true.

| Mechanism | Required predicates |
|---|---|
| Brainstorming | Listed in `selected_mechanisms`, `design_gate=required`, and a material choice cannot be resolved from repository truth |
| Durable plan | Listed in `selected_mechanisms`; work is multi-step and future execution, review, or handoff benefits from a persisted plan |
| TDD | Listed in `selected_mechanisms`; a failing automated test can credibly define the changed contract before implementation |
| Systematic debugging | Listed in `selected_mechanisms`; a bug or unexplained failure requires causal investigation before a fix can be selected |
| Worktree | Isolation is justified, supported by `platform_capabilities`, selected in `selected_mechanisms`, and any required Git/filesystem mutation is authorized |
| Delegated execution | `execution_mode=delegated`, delegation is in `selected_mechanisms`, every required phase role is in `delegated_roles`, tasks have safe boundaries, and the runtime plus `delegated_git_authority` provide the isolation/review capabilities required by the selected workflow |
| Parallel investigation | `execution_mode=parallel-investigation`, the mechanism is selected, two or more investigations are independent without unauthorized shared-state mutation, and each delegated investigator role is in `delegated_roles` with authorized/supported delegation |
| Spec document review | `spec review` is listed in `selected_mechanisms`; the artifact path and governing repository/governance contract are supplied; the lifecycle decision justifies independent readiness review; the review checks progressive disclosure and proportional document size; and a reviewer is available. A delegated reviewer additionally requires `spec-document-reviewer` in `delegated_roles` plus authorized, supported read-only delegation |
| Code review | `review` is listed in `selected_mechanisms`; the risk or lifecycle decision justifies independent review and an independent reviewer is available. Only a delegated subagent reviewer additionally requires its role in `delegated_roles` and authorized/supported delegation |
| Branch finishing | Listed in `selected_mechanisms` and the user requested integration, publication, retention, or cleanup |

Availability alone is not a predicate. The existence of subagents, tests,
worktrees, or documentation templates does not require their use.

## 4. Capability Negotiation

Inspect the actual runtime interface before selecting a mechanism. Distinguish
between required and optional capabilities.

- If a subagent API does not expose model selection, omit model selection and
  record that the runtime chose the model.
- If isolated workspaces are unavailable, work in place only when the selected
  risk and repository state make that safe; otherwise stop with the boundary.
- If a command example targets another shell or operating system, translate it
  using the observed platform rather than executing it literally.
- If a workflow depends on a missing capability for correctness, do not emulate
  it with guessed commands or parameters.

## 5. Evidence Contract

Verification evidence is reusable when it is both relevant and fresh. Record,
in the task report or equivalent evidence ledger:

- the claim being verified
- the command or inspection performed
- the committed `HEAD` SHA that the work is based on; for an unborn repository,
  record `HEAD: unborn`, the current branch name, and the complete Git-visible
  working-tree summary instead
- when the verified state is uncommitted, the working-tree summary described
  below; treat it as a contemporaneous description, not a stable identifier
- relevant fixture, config, dataset, dependency-lock, or external-input versions
- the exit status for commands, or the recorded outcome for inspections,
  visual checks, and checklists
- who or what produced the evidence
- any boundary the evidence did not cover

Evidence becomes stale when code, fixtures, config, dependencies, datasets, or
external inputs that can affect the verified claim no longer match the recorded
`HEAD`, working-tree description, or input versions. Changes proven unrelated
to the claim do not invalidate it. A message boundary alone does not make
evidence stale, and a recent command does not make irrelevant evidence
sufficient.

### Uncommitted working-tree summary

For evidence produced from an uncommitted state, record the smallest useful
summary that lets another reviewer understand what was present:

1. base `HEAD` from `git rev-parse HEAD`, or `HEAD: unborn` plus the current
   branch when the repository has no commit yet
2. `git status --short --branch`
3. unstaged and staged diff summaries, normally `git diff --stat` and
   `git diff --cached --stat`
4. the relevant changed paths or focused diff inspected for the claim when a
   stat summary alone would be ambiguous
5. every ignored, external, generated, or otherwise Git-invisible input that
   can affect the claim, with the best available version, digest, timestamp, or
   source identifier; state plainly when no stable identifier is available

These records describe the state observed during verification. They do not
prove byte-for-byte identity, detect later edits that preserve the same diff
statistics, or make an uncommitted tree safely reusable across workers. Reuse
uncommitted-state evidence only when the relevant files and explicit extra
inputs are known not to have changed. If that cannot be established cheaply,
re-run the affected verification before making the completion claim.

Evidence from an unborn repository is uncommitted evidence and is reusable only
under the narrow working-tree rule above. Committed evidence may be reused
across sessions when `HEAD` and every relevant
explicit extra input still match. A dirty working tree does not automatically
invalidate committed evidence when its changes are demonstrably unrelated to
the claim, but the report must state that boundary. When external inputs cannot
be identified reliably, narrow the freshness claim to the observed run rather
than implying reproducibility.

Reviewers may consume implementer evidence while independently inspecting the
change. The controller remains responsible for ensuring that final completion
claims are supported by fresh evidence for the final code state. Re-run only
the checks needed to close stale, missing, or high-risk evidence gaps.

## 6. Mutation Ownership

Apply `git_authority`, `delegated_git_authority`, and `external_mutations`
literally:

- `edit` permits working-tree changes only.
- `stage` permits adding or removing explicitly authorized paths in the Git
  index; it does not authorize editing, committing, or staging unrelated paths.
- `commit` permits a coherent local commit only when the index was empty before
  task staging, only active-task allowlisted paths were staged explicitly, and
  the final cached path list is a subset of that allowlist. If unrelated staged
  content already exists, stop without altering or committing it. Do not use
  `commit -a` or a broad staging command.
- `create-ref` permits creating the explicitly named branch or tag required by
  the selected workflow; it does not permit updating, pushing, or deleting it.
- `push` permits a normal fast-forward update of an explicitly named branch to
  an explicitly named remote. It does not permit force, lease override, ref
  deletion, tag mutation, or pushing unrelated refs.
- `force-push` and `delete-ref` are separate destructive authorities requiring
  an explicit target ref, impact disclosure, and destructive confirmation.
  Creating review artifacts or
  updating issues requires a separately named `external_mutations` entry.
- `merge` permits integration into another branch.
- `worktree` permits creating a worktree and removing a clean, agent-created
  worktree when the selected branch-finishing action explicitly includes
  cleanup. Never remove an externally managed worktree. If removal would delete
  uncommitted or unpublished work, `discard` authority and explicit destructive
  confirmation are additionally required.
- `discard` permits destructive cleanup only with explicit confirmation.

Delegated agents are read-only unless their phase role appears in
`delegated_roles` and `delegated_git_authority` explicitly
grants a subset of the controller's `git_authority`. The controller owns edits
and commits that were not explicitly delegated. Push, merge, discard, deploy,
message, issue-update, and other external authority are never inferred from
implementation or delegation authority.

## 7. Completion

Completion requires consistency among the decision record, implementation,
fresh evidence, and required documentation. Report narrower claims when a
capability or external boundary prevents full verification.
