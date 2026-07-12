# Iteration 9: fixture-backed workflow preservation

- Candidate: `a56f8e7d5711c690d46498cb7f990154facd1f0f`
- Baseline: `f5769bde68d879c8854fc8fb80b523c3d78958c0`
- Scenarios: debugging, TDD, documentation ownership, Git worktree safety,
  independent investigation/review
- Result: both configurations passed every assertion once

This establishes that the compact series retained the tested operational
contracts; it does not show candidate superiority. Each scenario retains its
metadata, report, grading, machine-readable evidence, and relevant output
snapshot in skill-creator's standard
`eval-*/<configuration>/run-1/outputs/` layout. The subagent scenario retains controller reports but not full platform
transcripts, so fresh-agent process claims remain weaker than file/Git/test
evidence. Timing and token metrics were not exposed; no variance claim is made.
The machine-readable benchmark records one run. Generate the official viewer
without `--benchmark`: its summary formatter renders absent single-run standard
deviation as `±0`, which would overstate the evidence.

Reproduction command:

```bash
python "$SKILL_CREATOR_PATH/eval-viewer/generate_review.py" \
  evals/results/iteration-9 --skill-name using-apex --static review.html
```
