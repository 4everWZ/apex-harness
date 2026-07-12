# Iteration 5: seven-skill routing baseline

- Candidate: `068e3f618d02b8b8f1da836fd9e8ba3bcd12c8d6`
- Previous-series baseline: `f5769bde68d879c8854fc8fb80b523c3d78958c0`
- Runs: one response-only routing run per eval and configuration
- Historical recorded result: candidate 20/20; baseline 17/20

Later independent audit invalidated eval 2's causal assertion because it
rewarded substituting an unrelated OpenCode/WSL failure for the unspecified
unit-test symptom. Do not use this iteration's aggregate as current quality
evidence. The corrected prompt/assertion and rerun are retained in iteration 8.

This iteration does not claim task execution, mutation, timing, token usage, or
variance. The exact executor model was runtime-selected and not exposed. Eval 3
and eval 6 include response-level safety/proposed-verification assertions that
cannot prove repository state without fixtures or execution transcripts.

Raw metadata, responses, and grading are retained under `runs/`; the full static
viewer remains a generated workspace artifact.
