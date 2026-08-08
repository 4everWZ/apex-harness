# Workflow

## Classify by semantic consequence

Classify by the consequence of being wrong, not by domain, file count, or apparent implementation size.

Use the lowest tier justified by the changed contract or behavior; escalate only when the work crosses a higher-risk boundary. Uncertainty alone is not a reason to escalate.

### Tier A — High semantic or high-impact change

Use Tier A when being wrong could change a system contract, data meaning, a critical security or financial boundary, a migration result, or a user or research conclusion. Typical cases include:

- changes to an existing public API contract or response schema;
- database schema or deployment migrations;
- authentication, authorization, permission, or payment behavior;
- critical infrastructure or an architecture change that alters downstream contracts, availability, recovery, or data integrity;
- cross-module contracts or data semantics;
- training or inference semantics, evaluation protocols, algorithms, or research claims.

Start with an explicit claim and the evidence that could support it. Use a dedicated harness only when existing checks cannot isolate the changed claim.

### Tier B — Routine behavior change

Use Tier B for ordinary behavior changes whose impact is controlled and that do not cross a Tier A boundary: normal features, backend logic, medium bugfixes, config or script semantics, CLI behavior, local refactors, internal interface adjustments, or an additive REST endpoint with no migration, compatibility, security, payment, or existing-contract change.

Prefer an existing check when it directly covers the changed claim. When that coverage is missing, add only the smallest targeted regression or local check that can support the changed behavior. Do not run a broad suite merely because it exists.

### Tier C — Local low-risk change

Use Tier C for a genuinely local change that does not alter important behavior, data, evaluation, architecture, or contract semantics: for example, button color, logging, comments, docstrings, an obvious non-semantic local fix, a non-behavioral rename, or simple plumbing.

Use the cheapest relevant check that can falsify the changed claim. For non-behavioral edits, inspecting the diff may be sufficient. Do not create a dedicated harness or project document unless a real contract boundary is crossed.

### Boundary examples

- A new REST endpoint is normally Tier B; changing an existing response schema is Tier A.
- An internal service refactor is Tier B while its contract is unchanged; a cross-module contract, availability, or recovery change is Tier A.
- Replacing a cache is Tier B while external semantics are unchanged; a change to consistency, persistence, or user-visible behavior is Tier A.
- ML and research work is not automatically Tier A. Training or inference semantics, data or label meaning, evaluation, algorithms, and research claims are Tier A; training-log formatting is Tier C and a dataloader worker bug is Tier B.

## Consultation boundary

Repository code, current specifications, schemas, and call sites should resolve routine implementation choices without user interruption. Ask before choosing among materially different outcomes that change scope, public behavior, evaluation or data semantics, research interpretation, or an external contract.

Risk escalation changes verification and documentation, not the authority to make a product or research decision. Do not silently reduce a requested feature or experiment because a cheaper implementation is easier.

## Completion claims

A claim is complete only when the implementation matches the claimed scope and the relevant evidence supports the changed behavior. State separately:

- what was verified and with which fresh evidence;
- what was not verified or is outside the local evidence boundary;
- any remaining risk, blocker, or user decision.

Static checks establish structure and validity only; they do not establish behavioral routing or research correctness.

## Execution loop

1. Read the real contract and classify semantic risk.
2. Define the changed claim and what completion means.
3. Resolve choices from repository evidence; ask only at a material boundary.
4. Implement the smallest defensible change.
5. Run the cheapest evidence that can support or distinguish the claim.
6. Continue only while the claim remains unsupported and each subsequent check adds evidence or reduces uncertainty.
7. Stop when the claim is supported, or state the precise remaining unverified scope.
