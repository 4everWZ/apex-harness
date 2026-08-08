# Verification Discipline

## Choose evidence

Verification exists to support the changed claim, not to maximize test activity. Prefer an existing check when it directly covers the changed claim. Do not run a broad suite merely because it exists. Choose the cheapest check that can distinguish the current hypotheses: inspect the call chain or source of truth, load the real config or checkpoint, check a tensor shape, run a minimal forward, or execute a focused regression as appropriate.

Do not refactor production code merely to make testing easier unless testability is itself the problem. Avoid harnesses that only exercise mocks or unrelated paths.

## Expensive integrity checks

Treat cryptographic hashing, such as SHA-256, as claim-specific evidence, not a default verification step. A Tier A classification alone does not require a checksum. Use a full checksum only when the changed claim actually depends on byte identity, artifact integrity, reproducibility, or a repository or supply-chain contract that explicitly requires it.

For large files, datasets, or artifact trees, first determine whether cheaper evidence can establish the needed claim:

- file size and metadata;
- an existing trusted manifest or published checksum;
- checks on changed artifacts only;
- format or structural validation;
- representative reads or targeted samples;
- transfer-tool integrity guarantees.

Hash only the artifacts covered by the integrity claim. Do not hash an entire dataset or artifact tree merely to gain confidence in a local code change. For example, changing one dataloader branch does not justify hashing a multi-terabyte dataset; inspect the diff and use claim-relevant loading or focused checks instead.

Do not recompute a checksum for an unchanged artifact merely for reassurance. Recompute it when the artifact may have changed, the trusted reference has changed, or the integrity claim itself requires fresh evidence.

A checksum establishes byte identity relative to a reference, not correctness, authenticity, or provenance by itself. Without a trusted reference, a newly computed checksum is only an identifier for the observed bytes. Provenance or authenticity requires a trusted reference or verification mechanism, such as a publisher-provided or signed manifest.

Use a full checksum when a downloaded artifact must be compared with a trusted published checksum, a transfer requires byte-for-byte verification, a fixed dataset version is part of a reproducibility manifest, corruption is being investigated against a known-good reference, or security or supply-chain policy requires it.

Use direct loading, parser or structural validation, representative reads, metadata, or a transfer tool's own integrity result when those checks support the actual claim more directly.

## Avoid verification loops

Every verification attempt must produce new evidence or reduce uncertainty about the changed claim. Do not repeat a verification cycle unless the code, inputs, environment, hypothesis, or check has materially changed.

When a line of inquiry stops producing information, stop patching. Re-read the source of truth and reframe the hypothesis or choose a check that can discriminate between the remaining explanations.

## TDD is a technique

Use a test-first regression when a stable boundary can express the failure and the test protects the intended behavior. TDD is not the default workflow for exploratory ML, architecture analysis, generated artifacts, subjective visual judgment, or infrastructure where a credible failing test cannot be constructed.

Those changes still need the most appropriate inspection, build, integration, forward-pass, benchmark, or other claim-relevant evidence.

## Stop

Once the changed claim is credibly supported, stop. Do not expand verification into adjacent unchanged behavior merely for reassurance. Report the evidence and the remaining boundary rather than implying a stronger claim than the checks support.
