# Codex APEX Harness Skill

## Install

Copy the `apex-harness` folder into one of these locations:

- Global: `~/.agents/skills/apex-harness`
- Repo-local: `<repo>/.agents/skills/apex-harness`

Codex discovers skills from those locations and uses the skill metadata for routing.

## Recommended companion global AGENTS.md

Keep your global `~/.codex/AGENTS.md` short. Example:

```md
# Global Working Rules

- Do not fake completeness.
- Do not guess APIs, tensor shapes, schemas, config semantics, or contracts.
- Do not silently simplify, omit, downgrade, or narrow requested scope.
- Ask before making material tradeoffs that change scope, behavior, evaluation semantics, data semantics, or research interpretation.
- Match verification intensity to task risk.
- Use repository-native tooling and workflow first.
- Before using Python or dependency-changing commands, identify the intended target environment; do not install project dependencies into Conda `base`, system Python, global Python, or shared environments unless explicitly requested.
- Keep existing source-of-truth docs consistent with changed behavior; do not create heavy docs for trivial edits.
- Add brief high-value comments only where intent, invariants, assumptions, or edge-case rationale would not be obvious from the code and nearby docs. Do not add comments that merely restate what the code literally does.
- Preserve or improve module boundaries when modifying code. Do not introduce avoidable coupling across files, modules, or layers.
- Prefer cohesive extensions or small focused refactors over dumping unrelated responsibilities into one file, class, or function, or over growing ad hoc branching, duplication, or flag-driven sprawl.
- When touching legacy code, leave the touched area no worse than before. If structural debt cannot be removed now, isolate it and document the constraint.
- For any substantial coding, research, or ML task that is not a trivial low-risk local edit, load and follow the `apex-harness` skill before implementation.
```

## Notes

- Keep long procedures in the skill, not in `AGENTS.md`.
- Keep repo-specific structural rules in the repository's own `AGENTS.md`.
- Use `docs/design/` for architecture and design records, including dated `YYYY-MM-DD-<topic>-design.md` documents.
- Use `docs/specs/` for active specs and leaf docs.
- Use `docs/plans/` for neutral implementation plans created from approved specs.
- Use `docs/matrix_*.md` for spec-to-implementation matrices.
- Use `docs/tradeoffs.md` for material cross-spec decisions, approved
  compromises, and unavoidable deviations.
- Use `docs/specs/status_*.md` for short handoff summaries when the user explicitly requests handoff.
- Do not default to branded or tool-specific doc folders such as `docs/superpowers/` unless the repository has a stronger convention.

- Use `references/algo_spec_template.md` and `references/dev_spec_template.md`
  for neutral algorithm and development leaf specs when the repository has no
  stronger convention.
- Follow `references/tradeoff_template.md`; other docs link stable `TRD-*` IDs
  instead of copying global entries.
- Treat `status_*.md` as a current-state handoff surface, not as an append-only diary or requirement coverage matrix. Create or refresh it only when the user asks for handoff. Link to `docs/matrix_*.md` instead of duplicating requirement rows.
