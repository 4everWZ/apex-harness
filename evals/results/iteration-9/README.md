# Iteration 9: fixture-backed workflow preservation

- Candidate: `a56f8e7d5711c690d46498cb7f990154facd1f0f`
- Baseline: `f5769bde68d879c8854fc8fb80b523c3d78958c0`
- Scenarios: debugging, TDD, documentation ownership, Git worktree safety,
  independent investigation/review
- Result: both configurations passed every assertion once

The retained fixture outputs associated with both recorded configurations
satisfy the tested operational contracts once; they do not establish candidate
superiority or prove which skill commit an executor actually loaded. No
executor transcript or skill snapshot was retained, so commit attribution is a
process record rather than independently auditable evidence. Each scenario
retains metadata, report, grading, machine-readable evidence, and relevant
output snapshot in skill-creator's standard
`eval-*/<configuration>/run-1/outputs/` layout. The subagent scenario retains controller reports but not full platform
transcripts, so fresh-agent process claims remain weaker than file/Git/test
evidence. Timing and token metrics were not exposed; no variance claim is made.
`single-run-summary.json` is a repository-specific comparison summary, not an
official benchmark artifact. Generate the official viewer without
`--benchmark`.

Reproduction command:

```bash
python "$SKILL_CREATOR_PATH/eval-viewer/generate_review.py" \
  evals/results/iteration-9 --skill-name using-apex --static review.html
```
