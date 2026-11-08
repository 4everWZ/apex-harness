# Logical specification directories

Compare the unchanged and revised documentation rules with the same five cases. Give each fresh executor only skill-creator, its candidate rules, task and isolated project. Repository skills are candidate material, not additional activated skills. Do not give executors reviewer criteria, previous outcomes, other projects or the proposed change.

Reuse these existing inputs without duplicating them:

| Case | Task | Initial project |
|---|---|---|
| new-business | [Relay task](../spec-boundaries/cases/software/task.md) | [Product SRS](../spec-boundaries/cases/software/initial/product-srs.md) at `tmp/product-srs.md` |
| new-algorithm | [Mosaic task](../spec-boundaries/cases/internal-algorithm/task.md) | [Accepted requirements](../spec-boundaries/cases/internal-algorithm/initial/requirements.md) at `tmp/requirements.md` |
| small | [CLI task](../spec-boundaries/cases/small/task.md) | [Accepted requirements](../spec-boundaries/cases/small/initial/requirements.md) at `tmp/requirements.md` |
| existing-nested | [Initial task](cases/existing-nested/task.md), then [closure](cases/existing-nested/later-task.md) | Copy `cases/existing-nested/initial/` to the project root |
| existing-flat | [Maintenance task](cases/existing-flat/task.md), then [reorganization](cases/existing-flat/later-task.md) | Copy `cases/existing-flat/initial/` to the project root |

Projects are isolated beneath repository `tmp/`, with `tmp/` ignored by Git. For existing-nested, initialize a local fixture Git repository with the initial snapshot, then append the supplied [accepted amendment](cases/existing-nested/accepted-amendment.md) verbatim to `docs/specs/access/policy.md` without committing it. This models the actual last accepted content being newer than Git. Setup commits belong only to the disposable fixture; executors must not commit.

Capture actual project outputs after each task before supplying a later task to the same executor. Retain useful Markdown and evidence snapshots with `.txt` suffixes, preserving relative paths. Do not retain fixture `.git/` directories, tool transcripts or disposable preparation scripts. Use a fresh reviewer with [semantic criteria](review.md); executors must not read that file. Review source preservation, ownership, usable grouping, complete semantics, real predecessor content, current links and lifecycle outcomes. File counts, directory counts, exact wording and static validation are not behavioral pass criteria. Flat output can be appropriate; a directory is not mandatory merely because it is allowed.

Keep reusable fixtures and comparison evidence here. Remove only the current run's disposable workspace after review. Structural validation and link checks do not establish behavioral correctness.

The [2026-11-08 comparison](results/2026-11-08.md) records both candidates, actual outcomes, the test-isolation deviation and the limits of the comparison.
