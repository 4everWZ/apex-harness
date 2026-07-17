# Repository rules

- This repository targets Codex only.
- `skills/` contains exactly `governing-project-work` and
  `managing-project-docs`; each has its own frontmatter trigger and neither
  depends on a router or the other skill.
- Skills encode the user's project mechanisms, not general software-engineering
  advice or replacement policy for Codex.
- Governance owns only risk, mutation authority, evidence strength and
  freshness, the completion boundary, and its working record lifecycle.
- Documentation owns topology, templates, artifact ownership, lifecycle for its
  four project-document types, and legacy management.
- Durable documentation holds current contracts or decisions, never changelogs,
  activity histories, execution journals, or system logs. Git owns document
  change chronology; operational logging owns runtime events.
- Default to one canonical artifact and split only for a distinct owner,
  lifecycle, or audience.
- Keep fallback templates under `skills/managing-project-docs/assets/templates/`.
- Do not add routers, aliases, hooks, runtime adapters, or duplicate workflows.
