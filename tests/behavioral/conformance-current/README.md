# Retained current conformance conclusions

These cases test conclusions that survive delivery and change with the accepted scope. Give fresh executors only skill-creator, a copy of the candidate documentation skill/resources, their current task and isolated project. Do not provide this index, review criteria, previous conclusions, another project or future tasks. Candidate rules are material, not additional activated host skills. Limit writes to each project; no network, installations, commits, backups or parent-repository discovery.

| Case | Tasks and initial materials |
|---|---|
| delivery | Copy `cases/delivery/initial/`. Execute [v1 delivery](cases/delivery/task.md), [accepted extension](cases/delivery/02-task.md), [functional implementation](cases/delivery/03-task.md), [performance acceptance](cases/delivery/04-task.md), then [unaccepted SRS discussion](cases/delivery/05-task.md). Capture each phase before supplying its next task. Supply `cases/delivery/04-material/check_performance.py` only before the performance task. |
| layered | Copy `cases/layered/initial/`; execute [the supplied acceptance report maintenance task](cases/layered/task.md). The initial specifications/plan are preserved from the earlier internal-algorithm run and retain all Mosaic input, feature, query, persistence and performance semantics. The new report is a supplied project fact, not an algorithm execution by this suite. |
| closure | Reuse [the cancellation task](../spec-current/cases/closure/task.md) and its `initial/` fixture. |
| recorded | Reuse [the maintenance task](../spec-current/cases/recorded/task.md) and its `initial/` fixture; initialize disposable Git and commit README, `.gitignore` and specification. Leave the valueless probe uncommitted. |
| behind | Reuse [the maintenance task](../spec-current/cases/behind/task.md) and its `initial/` fixture; initialize Git as recorded, then append [the already accepted amendment](../spec-current/cases/behind/accepted-amendment.md) without committing it. |

The delivery actor may execute existing local checks using the repository's Python environment. Only its third task permits implementation changes in `parser.py` and additional persistent functional tests; the original acceptance tests remain intact. The performance probe measures 1000 samples of four calls in the task's designated current environment, using nearest rank and a 10ms gate. This is a small behavioral fixture, not a claim about production performance. Other actors only maintain documents and may inspect their own fixture Git where applicable.

Preserve selected raw project outputs with `.txt` suffixes and their relative paths, including evidence actually produced by the allowed checks; omit fixture `.git/`, caches and tool transcripts. Retain the candidate resources alongside them. Use a fresh reviewer with [semantic criteria](review.md), which executors must not read. Review actual contracts, conclusions, scope, references and operations rather than preferred headings, words, counts or static validation. Preserve earlier tests/reports as historical evidence; their gap-only design is not the expected conclusion lifecycle here.

Disposable projects and helpers belong under repository `tmp/`. Clean only this run after capture/review; if execution policy blocks cleanup, report the remaining path rather than bypassing the policy.

The [2026-11-08 report](results/2026-11-08.md) records the continuous delivery results, supplementary cases, independent review and corrected overstrict handoff check.
