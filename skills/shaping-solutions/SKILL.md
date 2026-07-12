---
name: shaping-solutions
description: Clarifies unresolved product, behavior, interface, or architecture intent and creates a durable implementation plan when later execution benefits. Use before coding only when a material design choice remains or a multi-step plan needs to persist.
---

# Shaping Solutions

Resolve intent before implementation, then persist only the artifact that later
work needs. An approved spec or explicit prior design decision satisfies the
design gate.

## Choose the mode

- **Clarify and design** when materially different outcomes remain possible.
- **Plan** when intent is settled but execution spans dependent, reviewable
  tasks and a durable plan adds value.
- Use both in that order only when both triggers are present.
- Skip this skill for mechanical implementation with an established contract.

## Clarify and design

1. Inspect repository truth, recent changes, and existing decisions.
2. Separate questions answerable from evidence from choices only the user can
   make.
3. Ask focused questions at material decision boundaries. Do not ask the user
   to rediscover repository facts.
4. Compare credible alternatives by their relevant tradeoffs; recommend one.
5. Present a proportionate design and obtain approval before implementing the
   unresolved material direction.
6. Persist it only when repository governance, coordination, or future reuse
   requires a durable record.

For substantial work, consume the artifact obligation and ownership selected by
`governing-project-work`; do not independently create a competing spec, design,
or plan. This skill owns the content and quality of the selected artifact, not
the repository-wide documentation policy. Use the repository's canonical
template; when none exists, use the selected template under
`governing-project-work/assets/templates/` and delete sections that do not
carry information.

Routine details consistent with the approved direction do not need repeated
approval.

## Create an implementation plan

Use the repository's canonical plan format. If none exists, include:

- goal, source requirements, and material constraints
- affected files or component responsibilities
- ordered tasks with explicit dependencies and interfaces
- observable acceptance and exact verification commands where known
- documentation impact and unresolved blockers
- commit boundaries only when commits are authorized

Each task should produce a coherent, independently testable result. Fold setup,
configuration, and documentation into the task whose deliverable needs them.
Use explicit red-green-refactor steps only where `testing-changes` selects TDD.

Do not duplicate the specification, write placeholder instructions, or embed a
full future implementation merely to make the plan look detailed.

## Exit

Return the approved direction, durable artifact path if one was needed, open
decisions, and the appropriate execution mode: inline by default, or
`coordinating-subagents` only when the user explicitly enabled subagents for the
current task and bounded tasks genuinely benefit from delegation.
