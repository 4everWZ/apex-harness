# Workflow

## 1. Task Classification

Before implementation, classify the task.

### Tier A — Heavyweight
Use when changes affect:
- research logic, algorithms, math, losses, evaluation, baselines, or ablations
- training or inference semantics
- data preprocessing, dataset contracts, or label meaning
- architecture or cross-module contracts
- public APIs, storage schemas, or correctness-critical infrastructure
- any change that could materially alter scope, capability, claims, or downstream trust

### Tier B — Standard
Use when changes affect:
- internal backend logic
- medium bugfixes
- config behavior
- scripts
- moderate refactors
- local but behavior-changing code

Treat Tier B as substantial when one or more of these are true:
- it affects three or more files or more than one module boundary
- it changes config semantics, CLI behavior, user-visible behavior, or documented usage
- it changes behavior that future work will depend on
- the user explicitly asks for a handoff
- it needs a spec-to-implementation matrix to avoid losing track of partial scope

### Tier C — Lightweight
Use when changes are low-risk and local:
- UI text or styling
- logging
- comments or docstrings
- narrow parameter plumbing
- non-behavioral renames
- highly localized fixes

### Classification Rules
- Default to the lowest truthful tier.
- Escalate immediately when the task is found to affect a higher-risk boundary than initially classified.
- If uncertain, escalate one tier up.

## 2. Verification Policy

Verification intensity must match task intensity.

### Tier A
Must include:
- explicit success criteria
- observability check
- critical review
- dedicated harness or equally isolated verification path when existing tests are insufficient
- autonomous verification loop
- required documentation sync when relevant source-of-truth docs exist or are needed
- tradeoff logging for material deviation

### Tier B
Must include:
- concrete success criteria
- existing tests first
- minimal additional targeted verification if coverage is insufficient
- relevant local checks
- documentation updates only when relevant docs exist or are needed and behavior, usage, contracts, architecture, evaluation semantics, or non-obvious constraints materially change
- tradeoff logging only for material deviation

### Tier C
Must include:
- confirmation that the edit is truly low-risk and local
- lightweight validation such as smoke checks, linting, visual confirmation, or narrow test runs
- no dedicated harness unless no cheaper credible validation exists
- no heavy documentation routing unless behavior, architecture, or contracts are affected

### Global Verification Rules
- Existing reliable tests are preferred over redundant new harnesses.
- Irrelevant green checks do not count as verification.
- Verification must cover the changed claim, not merely execute some part of the repository.
- If outputs cannot be observed locally, verification claims must be narrowed accordingly.
- Before implementation, state the task tier, success criteria, verification path, and any required documentation artifacts when this skill is active.

## 3. User Consultation Boundary

Risk escalation means stricter verification and documentation, not automatic user interruption.

Human judgment remains a design input, especially in exploratory or vibe-coding work. Autonomy means resolving mechanical details from repository truth; it does not mean inventing product intent. Before implementation, obtain human confirmation when an underspecified direction would materially determine what is built, even if several implementations are technically viable.

Do not ask the user for confirmation for:
- routine debugging
- routine tier escalation
- local refactors
- implementation details that can be resolved mechanically from repository code and active specs

Ask the user only when:
- the requested change conflicts with the active spec, repository contract, or a prior explicit instruction
- multiple materially different implementations would satisfy the request but imply different product, research, maintenance, or evaluation tradeoffs, and the choice cannot be resolved mechanically
- proceeding would require changing scope, public behavior, evaluation semantics, data semantics, or external contracts beyond what the user requested
- a required external input, credential, approval, or product decision is missing
- the request is exploratory, aesthetic, or vibe-driven and the proposed direction would establish material product behavior, architecture, interaction semantics, or acceptance criteria that the user has not yet endorsed

The confirmation can be proportionate: a short proposed direction and one approval is enough for a small but consequential choice. Formal specs, repeated section-by-section approvals, and a second approval of the same decision are not required unless the risk, ambiguity, repository process, or user request justifies them.

For Tier A research tasks, ask the user before committing to materially different design choices in:
- objectives
- baselines
- evaluation protocols
- ablation scope
- data semantics
- architectural interpretation
- other decisions that would meaningfully change the research claim or experimental interpretation

Do not silently simplify, omit, downgrade, or narrow a requested feature, algorithm, evaluation setup, or spec-defined requirement merely because a cheaper implementation is easier to complete locally. If such a reduction would materially change scope, capability, scientific claim, or interpretation, surface the tradeoffs and ask the user before proceeding.

If none of the above applies, choose the most defensible implementation and continue autonomously.

### Brainstorming Routing

- Tier A: use an explicit design or decision pass before implementation when intent or approach is not already approved.
- Substantial Tier B: use brainstorming when requirements are ambiguous or multiple materially different designs remain; otherwise an existing approved spec or a concise implementation boundary is sufficient.
- Tier C and routine bug fixes: do not require brainstorming unless the user is actually choosing new behavior or experience.
- An approved design, accepted spec, or explicit user direction satisfies the design gate; do not ask the user to approve the same decision again merely because it was written to a file.

## 4. Execution Workflow

Follow this flow at the appropriate intensity:

1. Read relevant repository context.
2. Classify the task.
3. Define success criteria appropriate to the tier.
4. Ensure outputs are observable locally.
5. Perform a critical review of assumptions and risk.
6. Choose the least expensive verification path that still provides real confidence.
7. Implement the most defensible version of the change.
8. Run verification and iterate until criteria are met or a hard boundary is reached.
9. Synchronize documentation if required by scope.
10. If the user explicitly requests handoff, update the status / handoff document.

### Mechanism Intensity

Classification selects an appropriate mechanism; it does not activate an entire workflow stack.

| Mechanism | Tier A | Substantial Tier B | Lightweight Tier B / Tier C |
|---|---|---|---|
| Brainstorming | Use when intent or approach is not approved | Use only for material ambiguity or competing designs | Usually unnecessary |
| Durable plan | Usually appropriate | Use for multi-step, durable, or handoff-ready work | Usually unnecessary |
| Worktree | Recommended when risk or isolation needs justify it | Use only when isolation is useful | Usually unnecessary |
| Subagent-driven execution and per-task review | Use for a large plan with multiple substantially independent tasks | Optional when task boundaries justify the overhead | Do not use by default |
| Inline execution | Use when work is tightly coupled | Default when sufficient | Default |
| Implementation matrix | Required | Recommended when scope tracking is needed | Usually unnecessary |
| Tradeoff record | Use for material approved or unavoidable deviations | Use for material approved or unavoidable deviations | Usually unnecessary |

TDD is selected by whether a failing automated test can credibly define the changed contract before implementation, not by tier alone. Higher tiers require stronger evidence, which may be TDD, a dedicated harness, existing reliable tests, or another equally credible verification path depending on the claim.

## 5. Harness Rules

Harnesses are a tool, not a ritual.

### Build a Dedicated Harness When
- the task is Tier A
- risky boundaries are not adequately covered by existing tests
- shapes, interfaces, data contracts, or evaluation semantics must be validated in isolation
- repository tests are too coarse to localize the changed claim

### Do Not Build a Dedicated Harness When
- the task is narrow Tier C work
- existing tests already verify the changed behavior credibly
- the harness would be heavier than the change
- a smaller targeted check provides equivalent confidence

### Harness Requirements
A valid harness should:
- stay minimal
- use deterministic fixtures where feasible
- assert the critical claim directly
- expose observable outputs
- avoid fake confidence from unrelated mocks

## 6. Completion Rules

A task is complete only when, at the required tier:
- implementation matches the claimed scope
- relevant verification has passed, or the failure boundary is explicitly documented
- behavior-changing claims are supported by observed evidence
- required documentation updates, if any, are complete
- no known critical contradiction remains between code, tests, relevant documentation, and the implementation matrix

If blocked by a hard boundary such as missing credentials, unavailable hardware, missing datasets, external service failure, or unrecoverable environment limits:
- do not bluff
- state exactly what was verified
- state what remains unverified
- state the blocking boundary precisely

## 7. Handoff

Handoff is user-requested.

When the user asks for handoff:
- create or refresh the relevant status / handoff document
- summarize the current objective, high-level state, verification summary, blockers / risks, next steps, and relevant references
- keep it as a current-state snapshot, not a diary or requirement-level matrix
- link to the matrix when requirement-level implementation or verification status exists


## 8. Environment Policy

Follow repository-native tooling first.

Rules:
- Before using any Python interpreter, package manager, environment manager, or dependency-changing command, identify the intended target environment.
- If the repository clearly standardizes on a toolchain, package manager, or execution path, follow it.
- Otherwise prefer the currently active local environment.
- For Python, default to the active local conda environment unless the repository clearly uses something else.
- Do not install project dependencies into Conda `base`, system Python, global Python, or other shared environments unless the user explicitly asks for that target.
- Do not introduce a new environment manager unless the repository already uses it, the task explicitly requires it, or the current environment is provably insufficient and the change is documented.

## 9. Priority Order

When requirements conflict, prioritize:

1. Scientific defensibility
2. Implementation viability
3. Clear evaluation semantics
4. Contract correctness
5. Maintainability
6. Surface fidelity
7. Integration elegance

When uncertain, narrow the claim, increase verification, or state the uncertainty explicitly.
