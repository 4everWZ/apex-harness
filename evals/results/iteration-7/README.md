# Iteration 7: migration wording and trigger routing

- Candidate: `7bc01e7727778c4de659cf62a03dff9a7601196c`
- Baseline: `f5769bd`
- Eval 11 result: candidate 3/3; baseline 0/3
- Historical metadata-only routing set: 20/20 queries matched expected routes

Both are single-run results. That routing set covered six leaves plus no-leaf
cases but omitted the `using-apex` entry and lacked full provenance. Iteration 8
supersedes it with 22 entry/leaf/near-miss cases and a description snapshot.
Timing and token metrics were not exposed. Raw run artifacts are under `runs/`.
