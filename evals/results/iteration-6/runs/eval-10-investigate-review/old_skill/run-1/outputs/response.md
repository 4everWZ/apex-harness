# APEX routing and coordination boundaries

Use `apex-governance` to establish a phased decision record, then route the two independent questions through `dispatching-parallel-agents` and the completed implementation diff through `requesting-code-review`. The scenario does not provide enough information to invent a Tier A/B/C classification; classify the actual implementation before it starts and record its success criteria, verification level, documentation obligations, and permitted Git/external mutations.

## Phase 1: parallel read-only investigation

- Select `execution_mode=parallel-investigation`, the `parallel investigation` mechanism, and two explicitly named investigator roles. Delegation must be authorized and supported; agent availability alone is not authorization.
- Give each fresh-context investigator one exact, genuinely independent question, its allowed files/logs/artifacts, the evidence needed, the report format, and an explicit non-mutation boundary. Provide only the context needed for that evidence domain.
- Investigators may read files, inspect logs, run non-mutating diagnostics, and report cited evidence. They may not edit or fix code, install dependencies, stage or commit, create worktrees, push, deploy, alter services, or contact external parties. Set delegated Git authority to `none`.
- Dispatch concurrently only if the runtime supports it. If not, run sequentially and say so. If the questions depend on one another, contend for mutable state, or begin to converge on one root cause, stop and repartition rather than pretending they remain independent.
- Require each report to distinguish a confirmed conclusion from a hypothesis or unknown and to include evidence, scope checked, risks/unknowns, and any next investigation. The controller inspects the cited evidence, checks scope compliance, and synthesizes the two reports.

Phase 1 ends with a causal synthesis, not a code change. Its read-only authority does not carry into implementation.

## Phase 2: implementation

Open a separate phase record after synthesis. Default to controller-owned inline implementation unless a separately authorized delegated implementation workflow is selected. Record explicit `edit` authority for the working tree and any separately granted stage/commit authority; do not infer commit, push, worktree, merge, or external-mutation permission from edit authority. Implement against the actual requirements and run the risk-calibrated verification selected by governance. Keep any existing source of truth aligned, but do not manufacture parallel plans or other documentation artifacts.

## Phase 3: fresh independent review

- Select the `review` mechanism and authorize a new, independent read-only reviewer role (for example, `final-reviewer`). Do not reuse an investigator as the “fresh” reviewer, and do not pass the controller's session history or reasoning; give the reviewer the requirements, a concise description of what was implemented, relevant verification evidence, and an exact diff scope.
- For committed work, provide a base and head SHA and review that commit range. For intentionally uncommitted work, provide base `HEAD`, `git status --short --branch`, staged and unstaged diff summaries, the focused diff/changed paths, and every relevant untracked, ignored, generated, or external input. Do not create a commit merely to make review convenient.
- Freeze review-relevant paths and explicit extra inputs while the review runs. The reviewer remains read-only and rechecks `HEAD`, status, and relevant diff summaries before reporting. If freshness cannot be established, restart or narrow the review claim.
- Require strengths, file-and-line-specific Critical/Important/Minor findings, recommendations, and a clear readiness verdict. Review authority does not imply fix authority: the controller may address findings only under the implementation phase's edit authority. Critical and Important findings block the requested next step until resolved or explicitly reported for user direction, and the final completion claim must be supported by fresh evidence for the final code state.

Across all phases, APEX leaf skills supply mechanisms, not authority. Higher-priority instructions set the ceiling; each phase must name its scope, execution mode, selected mechanism, roles, and applicable authority, and no permission silently carries from investigation to implementation or from review to remediation.
