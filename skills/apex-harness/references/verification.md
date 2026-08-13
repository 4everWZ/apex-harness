# Verification Discipline

## Choose evidence

Verification exists to support the changed claim, not to maximize test activity. Prefer an existing check when it directly covers the changed claim. Do not run a broad suite merely because it exists. Choose the cheapest check that can distinguish the current hypotheses: inspect the call chain or source of truth, load the real config or checkpoint, check a tensor shape, run a minimal forward, or execute a focused regression as appropriate.

Do not refactor production code merely to make testing easier unless testability is itself the problem. Avoid harnesses that only exercise mocks or unrelated paths.

## Expensive integrity evidence

Treat expensive integrity checks as claim-specific evidence. Use checksums only when byte identity, artifact integrity, reproducibility, or an explicit repository contract is part of the changed claim. Otherwise prefer cheaper claim-relevant evidence, and do not repeat expensive checks merely for reassurance.

## Avoid verification loops

Every verification attempt must produce new evidence or reduce uncertainty about the changed claim. Do not repeat a verification cycle unless the code, inputs, environment, hypothesis, or check has materially changed.

When a line of inquiry stops producing information, stop patching. Re-read the source of truth and reframe the hypothesis or choose a check that can discriminate between the remaining explanations.

## Tests are evidence

Treat tests as one form of verification evidence, not a required workflow sequence. Prefer existing tests when they directly cover the changed behavior. Add or update a persistent regression test only when the behavior is stable and future regression risk justifies maintaining that coverage.

Treat test-first as optional. Use it when it helps isolate a reproducible bug or clarify a stable behavioral contract; do not treat writing the test before the implementation as a quality criterion.

Do not create test-only abstractions, mocks, fixtures, harnesses, or production refactors merely to perform TDD ceremony. For changes without a useful stable test boundary—including exploratory ML, architecture analysis, generated artifacts, subjective visual judgment, and infrastructure diagnostics—use the most direct claim-relevant inspection, build, integration, forward-pass, benchmark, or runtime evidence.

## Stop

Once the changed claim is credibly supported, stop. Do not expand verification into adjacent unchanged behavior merely for reassurance. Report the evidence and the remaining unverified scope rather than implying a stronger claim than the checks support.
