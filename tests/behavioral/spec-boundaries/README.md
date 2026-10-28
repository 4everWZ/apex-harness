# Specification boundaries and completeness

Forward-test new projects before changing the documentation skills. Give each executor only skill-creator, a copy of the candidate skills, its case task, and the inputs currently supplied to its isolated project. Do not provide the review criteria, other cases, results, or suspected failure. The repository skills are evaluation subjects, not additional activated skills.

Use `prepare.py start RUN CASE` from the repository environment. `RUN` is a new directory name under repository `tmp/`; `CASE` is `software`, `algorithm`, `small`, `algorithm-build`, or `internal-algorithm`. Candidate copies are under `tmp/RUN/rules/` and the project is under `tmp/RUN/CASE/`. Input fixtures are copied into the project's `tmp/`. The build case reuses the algorithm's initial input. After reviewing the initial artifacts, `prepare.py advance RUN CASE` supplies that case's next input without overwriting its earlier materials. Only software and algorithm have a second input.

Ask a fresh independent executor to carry out the case task and actually write project documents. Continue that executor with the second task only after supplying its next input. Cases prepare documentation only except algorithm-build, which implements and locally tests the detector while the evaluator remains future work. No external service, dependency installation, or real experiment is needed. Preserve supplied inputs. Judge semantic content and maintenance ownership by reading actual artifacts; file count, word count, headings, and static validation are not behavioral pass criteria.

Keep selected outputs and the review needed to compare future candidates in `results/`. Preserve document snapshots verbatim with `.md.txt` suffixes: they are evaluation evidence with original workspace links, not maintained specifications in this repository. Do not retain tool transcripts or every temporary file. Keep generated workspaces isolated under `tmp/` and remove only this run's disposable material after reviewing it.

`prepare.py snapshot RUN CASE initial|updated` preserves document outputs under `results/RUN/CASE/STAGE/`, reports whether supplied inputs are unchanged, and refuses to replace an existing snapshot. It does not judge document semantics; review those outputs separately.

The 2026-10-28 comparison records the [baseline](results/2026-10-28.md) and [layered candidate](results/2026-10-28-layered.md).
