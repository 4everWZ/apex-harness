# APEX

APEX bundles two Codex skills:

- [`apex-harness`](skills/apex-harness/SKILL.md) provides semantic-risk execution discipline, claim-focused verification, user decision boundaries, research/ML evidence rules, and explicit stopping conditions.
- [`managing-project-docs`](skills/managing-project-docs/SKILL.md) manages specifications, decisions, work plans, handoffs, and their lifecycle.

## When to use

- Use the harness for substantial coding, cross-module refactors, architecture, research, ML, or any change whose semantic consequences need explicit risk, evidence, or completion discipline. Do not use it for trivial low-risk local edits.
- Use document management when defining or changing a maintained project contract, resolving a missing contract owner, or creating, changing, synchronizing, reorganizing, consolidating, or retiring one of its project artifacts. Determine information ownership and lifecycle first, then reuse a suitable canonical owner or create one where needed. Minimize duplicate maintenance rather than file count.

Both skills are installed together. Each has its own frontmatter trigger and responsibility; no router is required.

## Documentation model

| Artifact | Lifecycle | Authoritative for |
|---|---|---|
| specification | durable | accepted current normative contract and acceptance criteria |
| decision record | durable | an independently owned choice and rationale |
| work plan | optional, working | unfinished transition, execution, and blockers |
| handoff | transient | one explicit transfer of work |

Repository conventions take precedence over these fallback shapes and paths.

The specification states the accepted current contract. Implementation is the actual system state; evidence supports whether it conforms. Inputs supply requested targets or constraints, and an optional plan coordinates the transition. Contract acceptance does not by itself establish implementation conformance, and implementation drift does not redefine the contract.

The absence of a plan does not establish complete implementation. For an important unimplemented or unverified gap, a specification references its existing status owner or acceptance evidence; when none exists, it may carry a brief gap notice distinct from the contract. Update or remove that notice as the state changes rather than accumulating progress history.

A contract may use an overall specification and subordinate technical specifications without separate releases or lifecycles. Each layer owns distinct content; necessary technical semantics remain explicit.

An existing README or API document may already serve as the maintained specification. If the task involves a durable contract with no suitable owner, establish one and move accepted contract content out of the work plan; unaccepted targets remain clearly proposed. Taking over an existing project does not by itself require reconstructing unrelated specifications. Distinguish observed behavior, the authorized target, and unresolved questions when drafting a missing contract.

Task inputs, including traditional requirements specifications, define or constrain requested work. Using a document as input neither creates nor removes its maintenance responsibilities. Inputs without maintenance responsibilities remain unchanged unless maintaining them is part of the authorized task. Coordinate the transition from the current contract to the authorized target in working context or a work plan when needed, then synchronize accepted changes into the canonical specification.

## Example

For a feature with a material design choice, draft the proposed contract before implementation when it can be defined, and synchronize it into the current specification when accepted. Add a decision record only when its rationale remains independently useful, a work plan only when execution must remain coordinated or resumable, and a handoff only for an actual transfer. Keep plans focused on remaining work rather than task history; retain a plan with unverified delivery work. At closure, move still-current facts to their owners and retire working or transient records under their lifecycle rules. Confirm still-needed content is recoverable before replacing it or relying on Git history.

## Default paths

- specifications: `docs/specs/<logical-path>.md`
- decision records: `docs/design/YYYY-MM-DD-<topic>-design.md`
- work plans: `docs/plans/<topic>.md`
- handoffs: `docs/handoffs/<topic>.md`

Specification paths may be flat or grouped into business, subsystem, or technical subdirectories. Grouping supports navigation without requiring a document for each directory or mirroring every specification layer; keep existing canonical paths unless reorganizing them is part of the task. Update accepted contracts in place; Git owns historical versions, while specifications carry the current contract and any necessary gap notice.

## Validation

From the repository root, create the validation environment, install its pinned dependency, point `SKILL_CREATOR_PATH` at the official `skill-creator` package, and run:

```powershell
python -m venv .venv
.\.venv\Scripts\python.exe -m pip install -r requirements-skill-validation.txt
$env:SKILL_CREATOR_PATH = 'C:\path\to\official\skill-creator'
.\scripts\validate-skills.ps1
```

Pass `-Python C:\path\to\python.exe` to use another isolated environment. Static validation checks official skill validity, matching skill names, local Markdown links, non-empty templates, the plugin manifest, and unsupported package paths. It does not enforce skill design, document headings, metadata, or behavioral routing; static validation is not behavioral evaluation.

Behavioral cases for new-project specification boundaries and completeness are in [tests/behavioral/spec-boundaries](tests/behavioral/spec-boundaries/README.md). They use independent executions and semantic review of actual artifacts; recorded results state their scope and limitations.
