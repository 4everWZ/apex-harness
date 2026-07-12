# Tradeoff Log Template

Use this structure for each material project-level decision or deviation in
`docs/tradeoffs.md`. Do not use the global log for choices contained by one
`algo_*` or `dev_*` spec.

## Entry

### [TRD-001] Short Title

- **Status:** proposed | approved | rejected | superseded
- **Decision Authority:** [Person or authority allowed to decide this scope]
- **Decision Reference:** [Required for approved, rejected, or superseded status]
- **Scope:** [Affected specs, components, contracts, or policies]
- **Context / Original Constraint:** [Problem, approved intent, or prior rule]
- **Decision / Actual Direction:** [Selected outcome or implementation deviation]
- **Alternatives:** [Material alternatives actually considered]
- **Reasoning:** [Decision drivers and why the selected outcome governs]
- **Consequences:** [Positive, negative, compatibility, migration, and risk effects]
- **Verification / Revisit Trigger:** [How to confirm fitness and when to reconsider]
- **Relations:** [requires, updates, updated-by, supersedes, or superseded-by IDs when applicable]

Delete relation or impact fields that do not apply. A proposed entry records an
unresolved decision; it does not authorize implementation, scope reduction, or
departure from an approved spec.

## Promotion Boundary

Promote a leaf-spec tradeoff when it creates a shared policy or contract,
affects multiple specs or components, requires authority beyond the leaf owner,
or changes an existing global tradeoff. Cost or material risk alone increases
consultation and verification; promote it only when the required authority or
lasting constraint also crosses the leaf boundary.

Handle a contained deviation by amending and reapproving its leaf spec and
recording the local tradeoff there. Do not create a global entry merely because
the implementation differs from approved leaf intent.

After approval:

1. Keep the full context, alternatives, decision, and consequences here.
2. Replace duplicate leaf-spec rationale with the stable `TRD-*` reference and
   spec-specific application details.
3. Reference the same ID from matrices and plans instead of copying the entry.

## ID and Lifecycle Rules

- Assign a short stable ID such as `TRD-001` and never reuse it.
- Keep decision status separate from implementation or verification status.
- Record only material project-level decisions, approved/unavoidable
  deviations, or major rejected alternatives.
- Do not use this log as a substitute for specs, design docs, matrices, plans,
  or handoff documents.
- Do not rewrite an approved outcome in place. An approved `updates` entry is a
  scoped amendment whose outcome governs only the declared overlap; keep both
  entries approved and link them with `updates`/`updated-by`. An approved
  `supersedes` entry fully replaces the old outcome; set the old status to
  `superseded` and link both with `supersedes`/`superseded-by`. Proposed entries
  do not change existing authority.
- Keep rejected and superseded entries as decision history.
- Tradeoff records never authorize silent simplification or scope narrowing.
