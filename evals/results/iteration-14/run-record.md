# Iteration 14 routing sample record

This directory is a single self-reported routing sample, not an official
skill-creator benchmark. Codex collaboration subagents were started with no
inherited conversation turns. The tool returned final responses but did not
expose full transcripts, token counts, or durations.

## Shared restrictions

Each evaluator was instructed to work read-only, read the official
`skill-creator/SKILL.md`, avoid labeled routing files and other evaluator
outputs, include IDs 1–5 exactly once, and return strict JSON without
self-grading.

## Previous-version assignment

Read only `queries-only.json`, then use `git show` at
`8acea00aa14c72e62a5771c20d33011875a0adfe` to inspect the seven historical
skills. Select the exact unordered applicable historical skill set for each
query and record a rationale. The final response is retained in
`previous-selections.json`.

## Current assignments

Read only `queries-only.json` and the eight current `skills/*/SKILL.md` files.
Select exact unordered applicable skill sets. For query 3, explain the Codex
context and runtime-default boundary. The first response is retained in
`pre-clarification-current-selections.json`; after narrowing the bootstrap, a
fresh response is retained in `pre-contract-current-selections.json`; after
clarifying controller ownership and assignment inputs, a third fresh response
is retained in `pre-router-boundary-current-selections.json`. After the final
`using-apex` ownership clarification, a fourth fresh response is retained in
`current-selections.json`; its initial field-name mismatch was corrected by a
same-agent formatting-only follow-up with values unchanged.

## Scoring assignments

Fresh graders read the official `skill-creator` grader guidance, label-hidden
queries, stored selections, and separately written ground truth. They compared
unordered sets and checked the query 3 contract. The first score is retained in
`routing-score-pre-contract-clarification.json`; the final score is retained in
`routing-score.json`. These files are local routing-score records and do not
claim the official viewer grading schema.
