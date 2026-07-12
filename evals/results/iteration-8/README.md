# Iteration 8: corrected debugging and trigger evidence

- Candidate: `a56f8e7d5711c690d46498cb7f990154facd1f0f`
- Baseline: `f5769bde68d879c8854fc8fb80b523c3d78958c0`
- Corrected debugging route: candidate 3/3; baseline 3/3
- Historical metadata-only routing: 22/22 once, invalidated

The corrected debugging prompt supplies no named failure evidence. Both versions
properly keep the cause unknown rather than substituting another failure. The
routing evaluator could also read expected labels, so its 22/22 result is not
blind trigger evidence. The artifact is marked invalidated and superseded by
iteration 10's three blind runs. It has no cross-model, execution, timing, token,
or variance claim. Analyzer notes identify non-discriminating and historical
name-biased assertions across iterations 5-8.
