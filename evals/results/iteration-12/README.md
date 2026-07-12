# Iteration 12: current bootstrap metadata routing

Fresh evaluators receive only `queries-only.json` and
`descriptions-only.json`. They do not receive expected labels and do not grade
their own selections. A separate deterministic comparison uses
`evals/routing-evals.json` after all runs finish.

This iteration evaluates the current seven descriptions, including both an
unloaded bootstrap case and already-active cases with no leaf and with a
positive leaf trigger. It is metadata-routing evidence, not task execution or
cross-model variance evidence.

All three same-runtime evaluators selected the expected exact skill set for all
23 queries (69/69 decisions). In particular, they selected `using-apex` only
for the possibly unloaded bootstrap, selected no skill for ordinary work after
bootstrap, and selected `debugging-systematically` directly for the already
active unexplained-failure case. Raw selections are retained without labels or
self-grades; `trigger-grading.json` records the later exact-set comparison.
