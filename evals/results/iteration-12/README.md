# Iteration 12: current bootstrap metadata routing

Fresh evaluators were instructed to read only `queries-only.json` and
`descriptions-only.json`, without expected labels, and not to grade themselves.
`evaluator-protocol.md` records that constraint and its audit limitation. A
separate deterministic comparison used `evals/routing-evals.json` after all
runs finished.

This iteration evaluates the current seven descriptions, including both an
unloaded bootstrap case and already-active cases with no leaf and with a
positive leaf trigger. It is metadata-routing evidence, not task execution or
cross-model variance evidence.

All three same-runtime evaluators recorded the expected exact skill set for all
23 queries (69/69 decisions). In particular, they selected `using-apex` only
for the possibly unloaded bootstrap, selected no skill for ordinary work after
bootstrap, and selected `debugging-systematically` directly for the already
active unexplained-failure case. Raw selections are retained without labels or
self-grades; `trigger-grading.json` records the later exact-set comparison. The
69/69 result supports current-description routing under the recorded protocol;
it does not independently prove evaluator input isolation.
