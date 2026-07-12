# Iteration 8: corrected debugging and trigger evidence

- Candidate: `a56f8e7d5711c690d46498cb7f990154facd1f0f`
- Baseline: `f5769bde68d879c8854fc8fb80b523c3d78958c0`
- Corrected debugging route: candidate 3/3; baseline 3/3
- Metadata-only routing: 22/22 once

The corrected debugging prompt supplies no named failure evidence. Both versions
properly keep the cause unknown rather than substituting another failure. The
routing result retains the exact seven description snapshots, selection method,
single-run provenance, and per-query output. It has no cross-model, execution,
timing, token, or variance claim. Analyzer notes identify non-discriminating and
historical name-biased assertions across iterations 5-8.
