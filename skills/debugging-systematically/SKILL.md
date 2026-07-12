---
name: debugging-systematically
description: Investigates bugs, unexplained test or build failures, regressions, and unexpected behavior when the cause is not established. Use before proposing fixes; skip when direct evidence already identifies the defect and the work is ordinary implementation.
---

# Debugging Systematically

Find the causal mechanism before changing production behavior. Fast guesses
often move the symptom and destroy useful evidence.

## Investigate

1. Reproduce the smallest reliable symptom and record the exact environment,
   input, and output. If reproduction is unsafe or unavailable, state that
   boundary.
2. Read the complete failure, surrounding code, configuration, and recent
   relevant changes.
3. Trace the bad value or state backward across component boundaries. At each
   boundary compare what entered, what left, and which assumption changed.
4. Form one falsifiable hypothesis that explains the observations.
5. Run the smallest experiment that distinguishes that hypothesis from its
   alternatives. Change one variable at a time.
6. Repeat until evidence identifies the root cause or the remaining uncertainty
   is explicit.

For intermittent or asynchronous failures, replace arbitrary sleeps with
observable conditions and bounded timeouts. For layered systems, add temporary
diagnostics at boundaries, then remove or intentionally retain them before
completion.

## Fix and verify

Once cause is established:

- choose the narrowest fix at the owning boundary
- use `testing-changes` to decide whether a regression test should precede it
- verify the original symptom and relevant surrounding behavior
- inspect for the same faulty assumption at adjacent call sites when evidence
  suggests a pattern
- document the cause only where future maintainers need the invariant

If several well-founded hypotheses fail, revisit architecture, environment, or
test validity instead of stacking speculative changes.

## Report

State the observed symptom, root cause and supporting evidence, fix if one was
requested, verification, and unresolved uncertainty. Investigation does not by
itself authorize implementation.
