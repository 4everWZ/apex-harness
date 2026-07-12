# Spec-to-Implementation Matrix Template

Use this for `docs/matrix_<topic>.md`.

| Requirement ID | Original Intent | Applicability | Current Status | Implementation Pointer | Verification Pointer | Notes |
|---|---|---|---|---|---|---|
| R1 |  | In Scope / Out of Scope | Implemented / Partially Implemented / Deferred / Not Implemented |  |  |  |
| R2 |  | In Scope / Out of Scope | Implemented / Partially Implemented / Deferred / Not Implemented |  |  |  |

## Guidance

- **Requirement ID**: short stable identifier such as `R1`, `R2`, `Ablation-1`, `API-3`
- **Original Intent**: what the original spec actually asked for
- **Applicability**:
  - `In Scope`
  - `Out of Scope` only with a currently governing approved spec change,
    approved `TRD-*`, or leaf rejection reference in **Notes**; proposed,
    rejected, and superseded global records do not grant exclusion authority
- **Current Status**:
  - `Implemented`
  - `Partially Implemented`
  - `Deferred`
  - `Not Implemented`
- **Implementation Pointer**: file, module, API, config key, or doc reference
- **Verification Pointer**: evidence-ledger record or equivalent durable record
  satisfying the evidence contract; a bare command or test path is not evidence
- **Notes**: constraints, caveats, partial-scope clarification, or a short pointer to a relevant project-level tradeoff ID such as `TRD-001`

## Rules

- This matrix is a coverage document, not a tradeoff log.
- This matrix is the requirement-level status source of truth. Handoff docs should link to it instead of duplicating rows.
- An `Implemented` row is valid only when both implementation and verification
  pointers are present and the verification evidence is fresh for that state.
- Before roll-up, treat an `Implemented` row with stale/missing evidence as
  `Partially Implemented` when an implementation pointer exists, otherwise as
  `Not Implemented`.
- Each verification pointer must resolve to a record containing the verified
  claim, committed `HEAD`, any required uncommitted working-tree summary,
  relevant input/version identifiers, outcome, producer, and uncovered
  boundaries as required by
  `governance_contract.md`.
- A `Deferred` row must cite its decision authority and deferral reference in
  **Notes**.

## Leaf Status Roll-up

Normalize stale/missing-evidence `Implemented` rows as described above, then use
the first matching result:

1. rejected leaf with no implementation evidence → `not-applicable`
2. one or more recorded rows, all validly `Out of Scope` → `not-applicable`
3. no implementation evidence and no active authorized execution → `not-started`
4. active authorized execution with incomplete rows → `in-progress`
5. all in-scope rows implemented with current evidence → `implemented`
6. any other stopped or reported incomplete state → `partial`

Reconcile the matrix and leaf status in the same completion review.
An empty matrix or missing acceptance coverage is `Issues Found` and produces
no leaf roll-up.
- If implementation status differs from the original spec because of a project-level deviation, reference the relevant entry in `docs/tradeoffs.md` by stable tradeoff ID in **Notes**.
- Do not duplicate full tradeoff narratives here.
