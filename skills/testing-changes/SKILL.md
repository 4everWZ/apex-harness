---
name: testing-changes
description: Selects a test or verification strategy when the user asks for TDD/evidence planning, a defect needs a regression test, or changed behavior requires new automated evidence. Use test-first only when a credible failing test can define the contract; skip when an accepted verification path already covers ordinary implementation.
---

# Testing Changes

Tests are evidence about a contract, not a required ceremony. Match the method
to the changed claim and failure risk.

## Decide whether to use TDD

Use a red-green-refactor cycle when:

- behavior is testable through a stable boundary
- the test can fail for the intended missing or defective behavior
- writing it first improves the contract or protects against regression
- the test cost is proportionate to the change

Do not force TDD for exploratory spikes, generated artifacts, subjective visual
judgment, documentation-only changes, or infrastructure where a credible local
failure cannot be produced. Still verify those changes through the appropriate
inspection, build, integration, or visual path.

## Test-first loop

1. Write one focused test describing observable behavior.
2. Run it and confirm it fails for the expected reason. A syntax error or broken
   fixture is not the red state.
3. Implement the smallest coherent behavior that satisfies the contract.
4. Run the focused test, then relevant neighboring checks.
5. Refactor while keeping the evidence green.

Avoid tests that only restate mocks, assert implementation trivia, introduce
production-only test hooks, or pass before the behavior exists. Use real
boundaries where practical and mocks only at genuine external seams.

## Verify the final claim

Identify what would prove each claimed outcome: focused regression, integration
test, build, static check, inspection, visual review, or requirements checklist.
Use current evidence only when it still covers the relevant code and explicit
inputs; otherwise rerun the smallest affected check. Read exit status and actual
failures rather than inferring success from partial output.

Passing tests do not prove an untested requirement, and a build does not prove a
runtime fix. Report the commands or inspections performed, their outcomes, and
what remains outside the evidence boundary.
