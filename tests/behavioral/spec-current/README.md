# Current specifications and material conformance gaps

These cases exercise in-place specification maintenance, concise gap visibility, source/evidence ownership and recovery protection. Only skill-creator is activated; copied project-documentation rules are candidate material. Give each fresh executor its task, candidate and isolated project, not this index, reviewer criteria, prior outcomes or another case. Allow writes only within that project. Do not install dependencies, use network, commit or create backups. Only existing-gap may execute its existing local unittest suite, using the repository's existing Python environment.

| Case | Tasks | Setup |
|---|---|---|
| new-algorithm | [Initial](cases/new-algorithm/task.md) | Copy `initial/` to the project root; place the existing [Mosaic accepted input](../spec-boundaries/cases/internal-algorithm/initial/requirements.md) at `tmp/srs.md`. No implementation is scheduled. |
| layered-development | [Existing internal-algorithm task](../spec-boundaries/cases/internal-algorithm/task.md) | Reuse the same [accepted input](../spec-boundaries/cases/internal-algorithm/initial/requirements.md) at `tmp/requirements.md`, with no other initial project docs. Unlike new-algorithm, this original case prepares coordinated development across sessions. |
| existing-gap | [Initial](cases/existing-gap/task.md), [status owner](cases/existing-gap/later-task.md), [repair verification](cases/existing-gap/final-task.md) | Start with `initial/`. After capturing the first stage, copy `later/` into the project; after capturing the second, copy `final/` into it. These later materials are supplied only when their task begins. |
| closure | [Cancellation and transfer review](cases/closure/task.md) | Copy `initial/`. The export initiative is cancelled; the independent operator transfer still has an owner, blocker and next action. |
| recorded | [Maintenance](cases/recorded/task.md) | Copy `initial/`; initialize fixture Git and commit README, `.gitignore` and the complete current specification. Leave the disposable probe uncommitted. |
| unrecorded | [Maintenance](cases/unrecorded/task.md) | Same, but commit only README and `.gitignore`; the actual accepted specification is not in Git. |
| behind | [Maintenance](cases/behind/task.md) | Commit the initial README, `.gitignore` and specification, then append [the accepted amendment](cases/behind/accepted-amendment.md) to the current specification without committing. |

All isolated projects ignore `tmp/` and `__pycache__/`. Setup commits exist only inside disposable fixture repositories, not in this repository's history. Non-Git projects must not discover the parent Git repository. The two recovery variants use the same maintenance request as recorded, changing only the available recovery state and flat/nested path. No local archive convention is supplied.

Capture each completed stage before providing its later material and task to the same actor. Retain useful project files and candidate resources with `.txt` suffixes and original relative paths; omit fixture `.git/`, caches and tool transcripts. The existing-gap evidence file is deliberately overwritten by the current local test result rather than accumulated as a run diary. Generated Python implementation/tests are raw fixtures, not changes to the skill's validator.

Use a fresh reviewer with [semantic criteria](review.md). Judge actual contracts, gap notices, state links, source integrity, recovery decisions and lifecycle results; do not match fixed wording, headings, counts, or metadata. Keep static validation separate from behavioral conclusions. Preserve previous suites and their reports as historical evidence rather than rewriting their results to fit these rules.

The [2026-11-08 report](results/2026-11-08.md) records the seven cases, nine stages, actual validation results, low-risk redundancy and a correction to an initially overstrict evidence-retention criterion.
