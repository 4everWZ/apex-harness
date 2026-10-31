# Workflow

## Classify by semantic consequence

Classify by the consequence of being wrong, not by domain, file count, or apparent implementation size.

Use the lowest tier justified by the consequence of an error. Ordinary development is Tier B; escalate when the affected boundary carries a Tier A consequence, or use Tier C for local low-risk work. Uncertainty alone is not a reason to escalate. The tier identifies what needs protection; verification scope follows the changed claim and affected boundary, not the tier label.

### Tier A — High semantic or high-impact change

Use Tier A when an error could materially break compatibility, compromise security or financial controls, corrupt or reinterpret data, impair critical availability or recovery, or invalidate an evaluation or research conclusion. Typical cases include:

- breaking changes to an API, schema, or cross-module contract relied on by existing consumers;
- database or deployment migrations that put existing data, service continuity, or recovery at risk;
- changes to authentication, authorization, permission, or payment enforcement;
- infrastructure or architecture changes that affect required consistency, durability, critical availability, or recovery;
- model, method, data, or metric changes that alter experiment meaning, result comparability, or the basis for a research claim.

Start with an explicit claim and the evidence that could support it. Use a dedicated harness only when existing checks cannot isolate the changed claim.

### Tier B — Routine behavior change

Use Tier B for ordinary development whose impact is controlled and does not carry a Tier A consequence: features, backend logic, bugfixes, configuration or scripts, CLI behavior, internal algorithms, refactors, internal interface adjustments, and compatible API additions. Changing behavior or maintaining its specification does not by itself make the work Tier A.

Prefer an existing check when it directly covers the changed claim. Add the smallest focused persistent regression test only when future regression risk justifies maintaining that coverage; otherwise use the cheapest local check that can support the claim. Do not run a broad suite merely because it exists.

### Tier C — Local low-risk change

Use Tier C for a genuinely local change that does not alter important behavior, data, evaluation, architecture, or contract semantics: for example, button color, logging, comments, docstrings, an obvious non-semantic local fix, a non-behavioral rename, or simple plumbing.

Use the cheapest relevant check that can falsify the changed claim. For non-behavioral edits, inspecting the diff may be sufficient. Do not create a dedicated harness or project document unless a real contract boundary is crossed.

### Boundary examples

- A new endpoint or compatible optional response field is normally Tier B; removing or reinterpreting a field required by existing consumers is Tier A.
- Changing an internal algorithm or interface is Tier B when callers' obligations and data meaning are preserved; changing shared units or identity semantics is Tier A.
- Replacing a cache is Tier B when required consistency and durability are preserved; weakening either guarantee is Tier A. A user-visible feature change alone does not establish that consequence.
- A dataloader concurrency fix that preserves data identity and order is Tier B; changing the training objective, label meaning, or metric definition is Tier A. Training-log formatting is Tier C.

## Re-evaluate a failing approach

Do not assume that repeated local failures only require more local fixes. When repairs begin adding state, abstractions, lifecycle, compatibility machinery, assumptions, or other obligations mainly to preserve an earlier workaround, treat that compensating complexity as evidence against the underlying approach. Revisit the earliest still-changeable assumption or design decision responsible before adding another layer.

Continue local repairs while the approach remains sound. When a clearly simpler or safer alternative stays within the authorized scope and preserves the requested behavior, semantics, and evaluation criteria, replan autonomously. Validate the alternative's key assumption before investing further implementation work.

Stop when continuing requires a material choice that the user has not authorized and repository evidence cannot resolve. Before stopping, identify the failed assumption, the evidence against the current path, the additional compensating work it would require, and the smallest viable alternatives. Recommend one without silently choosing across the material tradeoff.

Treat stopping as a valid engineering outcome. Do not keep modifying the system merely to preserve autonomous progress or justify work already invested.

## Consultation boundary

Repository code, current specifications, schemas, and call sites should resolve routine implementation choices without user interruption. Ask before choosing among materially different outcomes that change scope, public behavior, evaluation or data semantics, research interpretation, or an external contract.

Risk escalation changes verification and documentation, not the authority to make a product or research decision. Do not silently reduce a requested feature or experiment because a cheaper implementation is easier.

## Completion claims

A claim is complete only when the implementation matches the claimed scope and the relevant evidence supports the changed behavior.

When reporting completion, give the evidence supporting the changed claim. Mention unverified scope, remaining risks, blockers, or user decisions only when they materially affect that claim or the next action.

Static checks establish structure and validity only; they do not establish behavioral routing or research correctness.

## Execution loop

1. Read the accepted current contract, actual implementation, and governing task inputs. Distinguish the requested target from the contract and classify semantic risk.
2. Define the changed claim and what completion means from the current contract and authorized target requirements, preserving the requested scope.
3. Resolve choices from repository evidence and governing inputs; ask only at a material boundary.
4. Implement the smallest defensible change; re-evaluate the approach when repairs begin creating compensating complexity. Do not rewrite input requirements to make the implementation appear conformant.
5. Run the cheapest evidence that can support or distinguish the claim.
6. Continue only while the claim remains unsupported and each subsequent check adds evidence or reduces uncertainty. When evidence undermines a material requirement or assumption, re-evaluate the approach and apply the consultation boundary before changing the requested outcome.
7. Synchronize accepted contract changes in the same logical change; this does not establish implementation conformance. Before claiming delivery, resolve any disagreement between the implementation and the authorized contract; do not revise the contract merely to match the implementation. When the claim is supported, synchronize any other canonical project document that would otherwise be wrong or misleading and stop; otherwise state the precise remaining unverified scope.
