# Iteration 4: commit-bound SDD evaluation

This reruns eval 5 after the initial APEX commit. `benchmark.json` records the
tested commit, Git blob IDs, and SHA-256 hashes for both loaded skills. Raw
responses and grading are stored beside it.

The with-skill condition passed 4/4. The baseline passed 3/4 because it continued
the delegated resume path when HEAD was unborn. This is one response-only paired
run without transcript, timing, token, or variance data, so it is directional
evidence only.
