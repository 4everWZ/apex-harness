Yes—work test-first. A deterministic parser rule exposed through a stable public input/output boundary is an especially strong fit for a red-green-refactor cycle: a focused unit test can state the observable contract precisely, fail credibly while the rule is absent, and guard against later regressions without coupling to parser internals.

Verification sequence:

1. Define the public contract in focused tests: representative accepted input and exact output, non-matching input, boundary cases relevant to the rule, and the established error result for invalid input. Derive those expectations from the requested contract and existing parser conventions rather than inventing new error semantics.
2. Run the new focused test(s) before implementation. Confirm they fail because the rule is missing or incorrect—not because of a syntax error, fixture problem, or test-harness failure. Also ensure the assertions do not already pass through an overly broad existing rule.
3. Implement the smallest cohesive parser change that satisfies the public contract, preserving rule precedence and existing behavior outside the new case.
4. Re-run the focused tests and inspect both the exit status and actual results.
5. Run neighboring parser tests, especially cases whose inputs could overlap the new rule, to detect precedence, ambiguity, and regression issues.
6. Run the repository’s complete relevant unit-test suite and any standard static checks or build required for the touched code.
7. Refactor only after the behavior is green, then repeat the focused and relevant broader checks.

Completion should report exactly which checks ran and their outcomes. Passing focused tests establishes the new examples; the broader parser suite supplies evidence that the stable public contract and existing rules were not unintentionally changed. Any inputs or integration paths not exercised should be called out rather than implied to be verified.
