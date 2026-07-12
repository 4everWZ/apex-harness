# Iteration 12: current bootstrap metadata routing

Fresh evaluators receive only `queries-only.json` and
`descriptions-only.json`. They do not receive expected labels and do not grade
their own selections. A separate deterministic comparison uses
`evals/routing-evals.json` after all runs finish.

This iteration evaluates the current seven descriptions, including both an
unloaded bootstrap case and already-active cases with no leaf and with a
positive leaf trigger. It is metadata-routing evidence, not task execution or
cross-model variance evidence.
