# APEX repository rules

- `using-apex` is the only bootstrap entry.
- APEX is Codex-first. Claude Code, Gemini CLI, and Antigravity adapters expose
  the same semantics without defining parallel workflows.
- `governing-project-work` owns substantial-work risk, authority, evidence
  strength, and completion boundaries.
- `managing-project-docs` owns document topology, templates, artifact lifecycle,
  handoffs, and legacy management and may be selected without `using-apex`.
- The series contains at most eight skills; a new skill needs a cohesive,
  non-overlapping responsibility that cannot fit an existing leaf.
- Runtime support is limited to native Codex plus compatibility adapters for
  Claude Code, Gemini CLI, and Antigravity unless the user expands support.
- Leaves define only their trigger, focused decisions, process, exit conditions,
  and necessary resources. Do not repeat general model or repository rules.
- Keep governance templates centralized under
  `skills/managing-project-docs/assets/templates/`; repository-native formats
  still take precedence.
- Treat subagent coordination as user-enabled per task or phase, never as a
  default route. Do not override Codex model, scheduling, or reasoning defaults.
- Keep code, tests, manifests, and documentation aligned with skill behavior.
- Material behavior changes require realistic previous-version or no-skill
  baselines. Static string tests prove structure only.
