# Verification Discipline

## Choose evidence

Verification exists to support the changed claim, not to maximize test activity.
Run existing relevant checks before creating new test machinery. Choose the
cheapest check that can distinguish the current hypotheses: inspect the call
chain or source of truth, load the real config or checkpoint, check a tensor
shape, run a minimal forward, or execute a focused regression as appropriate.

Do not refactor production code merely to make testing easier unless testability
is itself the problem. Avoid harnesses that only exercise mocks or unrelated
paths.

## Verification cycle

A cycle is a hypothesis, a check, and an observed result. It must produce new
evidence or reduce uncertainty about the changed claim. Do not rerun an
unchanged check when the code, inputs, environment, or hypothesis is unchanged.

If two consecutive cycles produce no new evidence, stop editing. Re-read the
source of truth, identify why the hypothesis did not discriminate, and change
the hypothesis or the check instead of applying another random patch.

## TDD is a technique

Use a test-first regression when a stable boundary can express the failure and
the test protects the intended behavior. TDD is not the default workflow for
exploratory ML, architecture analysis, generated artifacts, subjective visual
judgment, or infrastructure where a credible failing test cannot be constructed.

Those changes still need the most appropriate inspection, build, integration,
forward-pass, benchmark, or other claim-relevant evidence.

## Stop

Once the changed claim is credibly supported, stop. Do not expand verification
into adjacent unchanged behavior merely for reassurance. Report the evidence
and the remaining boundary rather than implying a stronger claim than the
checks support.
