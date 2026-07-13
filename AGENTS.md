# Repository rules

- This repository targets Codex only.
- `skills/` contains exactly `governing-project-work` and
  `managing-project-docs`; each has its own frontmatter trigger and neither
  depends on a router or the other skill.
- Skills encode the user's project mechanisms, not general software-engineering
  advice or replacement policy for Codex.
- Governance owns only risk, mutation authority, evidence strength and
  freshness, and the completion boundary.
- Documentation owns topology, templates, artifact ownership, lifecycle, and
  legacy management.
- Keep fallback templates under `skills/managing-project-docs/assets/templates/`.
- Do not add routers, aliases, hooks, runtime adapters, or duplicate workflows.
