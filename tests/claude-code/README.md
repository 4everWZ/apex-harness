# Claude Code-facing contract tests

These tests validate APEX governance composition, delegated-authority
separation, SDD Git-state boundaries, and worktree path policy. They are static
or local Git tests and do not require the Claude Code CLI.

Run all tests:

```bash
./run-skill-tests.sh
```

Run one test:

```bash
./run-skill-tests.sh --test test-governance-composition.sh
```

Behavioral skill comparisons live under `evals/`; they replace old
harness-specific tests that asserted one vendor's prompt transport details.
