# Ongoing acceptance and feedback

Compare one continuous baseline with the same revised case in a fresh context, then exercise an existing owner and focused lifecycle regressions. Activate only skill-creator; candidate documentation rules are task material, not additional host skills. Each actor receives only its current task and raw project. Do not give it this index, review criteria, expected outcomes, another case, prior conclusions or future stages.

| Case | Setup and tasks |
|---|---|
| loop | Copy `cases/loop/initial/`. Execute `cases/loop/01-task.md` through `06-task.md` sequentially. After stage 01 is captured, supply `02-material/`; before stage 06 supply `check_performance.py`. Stage 03 permits repairing `parser.py`; stage 05 permits implementing the accepted extension and adding regression tests. Preserve existing tests. Other stages maintain docs or run the explicitly allowed checks. |
| existing | Start from the loop fixture, then overlay `cases/existing/`. Use the same six tasks and later materials. README establishes the maintained `quality/current.md` owner, local issue/CI mirrors and separate operator guide. Write actual functional/performance results to the paths established there. |
| lifecycle | Copy `cases/lifecycle/initial/`; execute [merge and cancellation](cases/lifecycle/task.md), then after capture [scope retirement](cases/lifecycle/later-task.md). Supplied evidence is read-only. |
| manual | Copy `cases/manual/initial/`; execute [the operator-guide task](cases/manual/task.md). Only write the requested documentation. |
| algorithm | Reuse [the internal-algorithm task](../spec-boundaries/cases/internal-algorithm/task.md) and put its [accepted input](../spec-boundaries/cases/internal-algorithm/initial/requirements.md) at `tmp/requirements.md`. |
| recovery | Reuse [the behind task](../spec-current/cases/behind/task.md) and `initial/` fixture. Initialize disposable Git with README and the initial specification, then append [the accepted amendment](../spec-current/cases/behind/accepted-amendment.md) without committing. |

Projects and disposable preparation helpers live beneath repository `tmp/acceptance-feedback-20261108/`, ignoring `tmp/` and Python caches. No actor may call parent Git, install dependencies, access network, commit, make backups or delegate. Only loop/existing can run their allowed local checks using the repository's existing Python environment. Issue/CI files are explicitly local service-data mirrors; no external service is contacted.

Capture each phase before supplying its next materials and task to the same actor. Retain selected project files with `.txt` suffixes and original relative paths, excluding fixture `.git/`, caches and transcripts. Keep candidate rules for each cohort. Paths containing `tmp/` inside these retained test fixtures/captures are reusable evidence, not disposable workspaces: explicitly include those selected files in Git despite the repository's broad ignore pattern.

Give a fresh reviewer the raw materials, retained outputs, candidates and [semantic criteria](review.md). Review actual information ownership, accepted behavior, evidence, valid feedback, stable paths and lifecycle outcomes; do not equate document counts, headings, wording or static validation with behavioral correctness. Preserve earlier suites/results as historical evidence.

The [2026-11-08 comparison](results/2026-11-08.md) records the successful baseline, revised new/existing loops, lifecycle regressions, independent review and lower-risk execution observations.
