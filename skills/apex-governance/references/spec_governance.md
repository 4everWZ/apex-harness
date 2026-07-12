# Spec Governance

Use this contract for new neutral `algo_*` and `dev_*` specs when the repository
has no stronger convention. Use the applicable template for content shape.

## Common Metadata

Require:

- `Spec Type`: `algo` or `dev`, matching the file prefix
- `Decision Status`: `draft`, `approved`, `deferred`, `rejected`, or `superseded`
- `Implementation Status`: `not-started`, `in-progress`, `partial`,
  `implemented`, or `not-applicable`
- `Established`: `YYYY-MM-DD`
- `Decision Authority`: who may change decision status

Require `Decision Reference` for every non-draft status. Add relationship and
artifact links only when they exist.

## Lifecycle

- `draft`: unresolved; does not authorize implementation
- `approved`: authorized within recorded scope by the decision authority
- `deferred`: preserves history/evidence; authorizes no new work
- `rejected`: preserves history/evidence; authorizes no new work
- `superseded`: preserves the last evidence state and links its replacement;
  authorizes no new work

Before moving to an inactive decision state, stop active work and replace
`in-progress` with the evidence-derived status. A rejected proposal with no
applicable implementation uses `not-applicable`; one with existing work keeps
`partial` or `implemented`. A draft may be `in-progress` only when separate
higher-priority implementation authority is recorded.

Interpret implementation status as evidence, never authority:

- `not-started`: no implementation work/evidence exists
- `in-progress`: authorized work is active and acceptance is incomplete
- `partial`: work stopped or is reported with incomplete acceptance
- `implemented`: every in-scope acceptance item has fresh evidence
- `not-applicable`: no implementation applies

Document-review readiness cannot change decision status. Only the decision
authority may approve, defer, reject, or supersede. An approved spec must have
observable acceptance and no blocking placeholder, open question, or unresolved
contract semantic.

For a material amendment, record the prior approved revision and decision
reference, then mark only the amendment draft as `draft`. The prior revision
continues to govern until its approval is explicitly withdrawn or an approved
amendment/replacement supersedes it; rejecting or withdrawing the draft does
not change prior authority. Draft changes grant no additional authority. If
the repository cannot preserve both revisions durably, keep the approved spec
unchanged and create a linked superseding draft.

## Traceability and Evidence

Use stable requirement/acceptance IDs only when traceability risk or an active
matrix justifies them. When a matrix exists, it owns requirement-level coverage;
derive and reconcile the leaf implementation status using
`matrix_template.md`. Use `tradeoff_template.md` for local/global ownership and
promotion rules.

## Legacy Compatibility

Apply this contract to new neutral specs and explicit migrations. Update older
specs surgically under their existing convention; never guess historical dates,
approval, or implementation status. Missing legacy metadata cannot authorize
new work—resolve a needed lifecycle fact from durable evidence or the decision
authority.

Delete untriggered optional sections instead of writing `N/A`. If an approved,
in-scope product or algorithm module is omitted from implementation, state:

**Not implemented in the current version.**

## Review Proportionality

Require progressive disclosure: keep routing and common rules in the primary
skill, load only the triggered profile/reference, delete untriggered optional
sections, and link plans, matrices, tradeoffs, and evidence instead of copying
them. Treat duplicated rules, unconditional profile expansion, or documentation
volume disproportionate to the decision risk as review issues.

A selected spec review reports `Ready for planning` or `Issues Found`. Any
unresolved governing-contract, acceptance, lifecycle, or internal-consistency
issue means `Issues Found`; readiness never changes decision status.
