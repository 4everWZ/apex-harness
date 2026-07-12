# Iteration 6: responsibility coverage

- Candidate: `b9f2a16`
- Baseline: `f5769bd`
- Scope: documentation ownership, worktree isolation, planning-only inline
  execution, independent investigation/review, and old-name migration
- Runs: one response-only routing run per eval and configuration
- Historical routing/name-conformance result: candidate 16/17; baseline 10/17

The candidate's only failure was failure to call deleted-name lookup a breaking
migration explicitly. That wording was fixed and rerun in iteration 7. No
timing, token, execution, mutation, or variance claim is made.

Several baseline failures are exact renamed-skill assertions even where the old
workflow preserved equivalent semantics. Use this iteration for migration and
responsibility-routing evidence, not as a semantic quality delta. Raw metadata,
responses, and grading are retained under `runs/`.
