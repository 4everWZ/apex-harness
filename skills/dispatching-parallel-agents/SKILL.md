---
name: dispatching-parallel-agents
description: Parallelizes independent read-only investigations through focused subagents. Use when 2+ questions have no shared mutable state or sequential dependency and read-only delegation is authorized.
---

# Dispatching Parallel Investigations

## APEX boundary

This leaf owns read-only investigation partitioning. It consumes APEX execution mode, delegated roles, and authority; it cannot authorize delegation or turn an investigation into implementation. Without a full decision record, the `using-apex` lightweight boundary applies and delegation remains opt-in.

## Overview

Use separate fresh-context agents to investigate independent problem domains at
the same time. This skill is read-only by default: agents gather evidence and
return findings; they do not edit, fix, commit, or integrate code.

Parallel availability does not authorize delegation. Active governance must
select `parallel-investigation`, and the phase record must grant read-only
delegation for the named scopes.

## Preconditions

Use this mechanism only when all are true:

- two or more investigation questions are genuinely independent
- no result is required before another investigation can start
- agents can inspect without mutating shared state
- delegation is authorized and supported by the runtime
- each scope and expected evidence can be stated precisely

Do not use it when failures may share a root cause, understanding requires the
full system state, or agents would contend for mutable resources.

## Authority Boundary

The default contract is read-only:

- allowed: read files, inspect logs, run non-mutating diagnostics, compare
  existing artifacts, and report evidence
- forbidden: edit files, install dependencies, stage or commit changes, create
  worktrees, push, merge, deploy, message external parties, or alter services

If parallel implementation is desired, create a separate implementation phase
with explicit delegated `edit` authority and isolation for every worker. Use an
implementation workflow designed for those mutations; do not reinterpret this
investigation skill as authorization to fix findings.

## Process

### 1. Partition by evidence domain

Group questions so each agent can reach a conclusion without depending on
another agent's result. Good boundaries include separate logs, independent test
failures, unrelated modules, or distinct documentation contracts.

If one hypothesis could explain several failures, keep them in one investigation
until evidence proves they are independent.

### 2. Construct focused tasks

Each task states:

- exact question and scope
- files, logs, commits, or artifacts it may inspect
- non-mutation boundary
- evidence required for a conclusion
- expected report format
- what uncertainty should be escalated rather than guessed

Do not pass the entire session history. Provide the minimum context needed to
interpret the evidence.

### 3. Dispatch concurrently

Issue independent tasks together when the platform supports concurrent
dispatch. If the platform does not, run them sequentially without pretending
they were parallel.

Example:

```text
Investigator A: Determine the root cause of authentication test failures.
Read only tests/auth and relevant logs. Do not edit files. Report evidence.

Investigator B: Determine why the packaging job cannot find generated assets.
Read only packaging config and job logs. Do not edit files. Report evidence.
```

### 4. Validate reports

For each result:

- inspect cited evidence rather than trusting the conclusion
- distinguish confirmed cause, hypothesis, and unknown
- check that the agent respected scope and authority
- identify whether supposedly independent findings actually converge

### 5. Synthesize before mutation

Combine the reports into a causal picture and decide the next phase. If fixes
are requested and authorized, select inline or delegated implementation under a
new phase record. Authority from the investigation phase does not carry forward.

## Report Contract

Each investigator returns:

```markdown
## Conclusion
[Confirmed cause, supported hypothesis, or unresolved]

## Evidence
- `file:line`, command output, log event, or artifact

## Scope checked
[What was and was not inspected]

## Risks / unknowns
[Remaining uncertainty]

## Suggested next investigation
[Only if evidence is insufficient]
```

Recommendations may describe a possible fix, but must not claim that it was
implemented or authorized.

## Red Flags

Stop and repartition when:

- agents need to modify the same files or environment
- an agent says it “fixed” or “integrated” something during a read-only phase
- findings depend on uncited session context
- multiple reports point to one shared cause
- the task requires a credential, product choice, or external mutation
- a supposedly independent question needs another agent's unfinished result

## Completion

Parallel investigation is complete when reports are received, evidence is
checked, and the controller has synthesized what is known and unknown. It does
not complete an implementation task and does not authorize a later mutation.
