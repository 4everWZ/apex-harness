# Iteration 10: blind metadata routing

Three fresh evaluators independently received only:

- the 22 unlabeled queries in `queries-only.json`
- the seven exact skill name/description frontmatter snapshots

They did not receive expected labels and did not grade themselves. A separate
grader compared exact unordered selections with `evals/routing-evals.json`.

- Original result: 63/66 (`21/22` in each run)
- Sole disagreement: query 13 expected `testing-changes`; all three selected no
  leaf for an obvious bounded fix already identified by a failing assertion
- Ground-truth review: revised query 13 to no leaf because the current
  `testing-changes` contract skips ordinary implementation with an accepted
  focused verification path
- Revised result: 66/66, with raw selections unchanged

The original and revised grading are both retained. This is metadata-routing
evidence across three same-runtime runs, not task execution or cross-model
variance evidence.
