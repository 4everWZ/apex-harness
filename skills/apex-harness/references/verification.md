# Verification Discipline

## Choose evidence

Verification exists to support the changed claim, not to maximize test activity.
Prefer an existing check when it directly covers the changed claim. Do not run a
broad suite merely because it exists. Choose the cheapest check that can
distinguish the current hypotheses: inspect the call chain or source of truth,
load the real config or checkpoint, check a tensor shape, run a minimal forward,
or execute a focused regression as appropriate.

Do not refactor production code merely to make testing easier unless testability
is itself the problem. Avoid harnesses that only exercise mocks or unrelated
paths.

## Avoid verification loops

Every verification attempt must produce new evidence or reduce uncertainty
about the changed claim. Do not repeat a verification cycle unless the code,
inputs, environment, hypothesis, or check has materially changed.

When a line of inquiry stops producing information, stop patching. Re-read the
source of truth and reframe the hypothesis or choose a check that can
discriminate between the remaining explanations.

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
