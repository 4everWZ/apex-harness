# APEX

APEX is a Codex-only collection of two personal project-work mechanisms. It
does not teach Codex general software engineering or wrap its built-in coding,
Git, testing, debugging, planning, or subagent behavior.

```text
skills/
├── governing-project-work/
└── managing-project-docs/
```

- [`governing-project-work`](skills/governing-project-work/SKILL.md) records the
  risk, authority, evidence strength and freshness, and completion boundary
  when that boundary matters.
- [`managing-project-docs`](skills/managing-project-docs/SKILL.md) applies the
  preferred document topology, templates, ownership, supersession, and legacy
  lifecycle. Its artifact-specific references load only when relevant.

Documentation falls back to four shapes: a durable specification, a durable
decision record, a working plan, and a transient handoff. Durable artifacts
hold current contracts or decisions. Git owns document change chronology, and
operational logging owns runtime events.

Specifications follow a contract loop: draft the intended contract when it can
be known in advance, implement and verify it, classify discoveries, and write
back only accepted behavior and semantics. Material reasons for an accepted
change belong in a decision record only when the choice needs an independent
owner, lifecycle, or audience; otherwise they stay with the owning
specification. Bugs and temporary workarounds remain unfinished work rather than
silently redefining the contract. Before completion, the implementation,
verification, active decisions, and specification must be synchronized.

When a repository has no established documentation convention, the fallback
paths are `docs/specs/`, `docs/design/`, `docs/plans/`, and `docs/handoffs/`.
The fallback for retained superseded specifications is
`docs/specs/legacy/<topic>-NN.md`;
the fallback for working project boundaries is
`docs/plans/<topic>-boundary.md`. Handoffs are rewritten in place for the same
transfer, and deleted after takeover or abandonment once still-current facts
have moved to their owner. They have no legacy lifecycle.

For repositories with enough project documents to need a human entry point,
`docs/README.md` may index canonical artifacts. It owns navigation only and
does not duplicate their contracts, decisions, status, rationale, or work state.

Each skill has its own frontmatter trigger and can be selected without a router
or the other skill. Static validation does not claim behavioral trigger rates.

## Validation

From the repository root, create the validation environment, install its pinned
dependency, point `SKILL_CREATOR_PATH` at the official `skill-creator` package,
and run:

```powershell
python -m venv .venv
.\.venv\Scripts\python.exe -m pip install -r requirements-skill-validation.txt
$env:SKILL_CREATOR_PATH = 'C:\path\to\official\skill-creator'
.\scripts\validate-skills.ps1
```

Pass `-Python C:\path\to\python.exe` to use another isolated environment.
Validation follows the installed official `skill-creator`; it checks static
structure and frontmatter rather than serving as a behavior benchmark.
