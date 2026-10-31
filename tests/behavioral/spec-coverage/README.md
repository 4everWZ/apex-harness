# Specification coverage cases

These cases evaluate coverage guidance for ordinary development without requiring a fixed specification format. They compare generated meaning against accepted inputs and existing contract owners, not headings, word counts, file counts or identifier coverage.

Give a fresh independent executor its task, isolated project, candidate skill/references and applicable fallback template. Activate only skill-creator, with the repository skills as candidate execution guidance. Do not supply suspected weaknesses, expected answers, reviewer criteria, previous runs or other cases. Limit writes to its repository-local `tmp/` project and prohibit implementation execution, network, dependency changes and commits.

`ordinary-new` and `existing-config` have complete initial project fixtures. `small` reuses `tests/behavioral/spec-boundaries/cases/small/initial/requirements.md` at project `tmp/requirements.md`. `algorithm` reuses `tests/behavioral/input-absorption/cases/new-srs/initial/tmp/srs.md` at project `tmp/srs.md`. Both reuse cases have their own task files here. Their temporary `.gitignore` contains `tmp/`.

Review actual artifacts using [the semantic criteria](review.md), which executors must not read. Preserve useful fixtures, candidate versions and comparison evidence here; captures ending in `.txt` are evaluation evidence rather than maintained project specifications. Keep disposable execution files under repository-local `tmp/` and remove only the current run's unneeded material.

[2026-11-01 comparison](results/2026-11-01.md) records the baseline, revision, observed results and limits. Structural checks are reported separately from behavioral evidence.
