# APEX

APEX provides two independent Codex skills:

- [`governing-project-work`](skills/governing-project-work/SKILL.md) defines
  material risk, authority, evidence, and completion boundaries.
- [`managing-project-docs`](skills/managing-project-docs/SKILL.md) manages
  specifications, decisions, work plans, handoffs, and their lifecycle.

## When to use

- Use governance when the user requests a project boundary or omitting one could
  materially change authorization, verification, or the completion claim.
- Use document management when creating, changing, synchronizing, reorganizing,
  or retiring one of its project artifacts.

Each skill has its own frontmatter trigger and neither requires a router or the
other skill.

## Documentation model

| Artifact | Lifecycle | Authoritative for |
|---|---|---|
| specification | durable | current contract and acceptance |
| decision record | durable | an independently owned choice and rationale |
| work plan | working | unfinished execution and blockers |
| handoff | transient | one explicit transfer of work |

Repository conventions take precedence over these fallback shapes and paths.

## Example

For a feature with a material design choice, the specification owns the accepted
contract, a decision record owns the independent choice, and a work plan drives
unfinished implementation. Create a handoff only for an actual transfer. At
closure, move still-current facts to their authoritative durable artifact and
retire working or transient records under their lifecycle rules.

## Default paths

- specifications: `docs/specs/<topic>.md`
- decision records: `docs/design/YYYY-MM-DD-<topic>-design.md`
- work plans: `docs/plans/<topic>.md`
- handoffs: `docs/handoffs/<topic>.md`
- retained superseded specifications: `docs/specs/legacy/<topic>-NN.md`
- persisted project boundaries: `docs/plans/<topic>-boundary.md`

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
Static validation checks frontmatter, links, topology mappings, references,
templates, and the manifest; it does not measure behavioral trigger rates.
