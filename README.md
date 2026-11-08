# APEX

APEX bundles two Codex skills:

- [`apex-harness`](skills/apex-harness/SKILL.md) provides semantic-risk execution discipline, claim-focused verification, user decision boundaries, research/ML evidence rules, and explicit stopping conditions.
- [`managing-project-docs`](skills/managing-project-docs/SKILL.md) manages specifications, ongoing acceptance and feedback, decisions, work plans, handoffs, and their lifecycle.

## When to use

- Use the harness for substantial coding, cross-module refactors, architecture, research, ML, or any change whose semantic consequences need explicit risk, evidence, or completion discipline. Do not use it for trivial low-risk local edits.
- Use document management when defining or changing a maintained project contract, resolving a missing contract owner, or creating, changing, synchronizing, reorganizing, consolidating, or retiring one of its project artifacts. Determine information ownership and lifecycle first, then reuse a suitable canonical owner or create one where needed. Minimize duplicate maintenance rather than file count.

Both skills are installed together. Each has its own frontmatter trigger and responsibility; no router is required.

## Documentation model

| Artifact | Lifecycle | Authoritative for |
|---|---|---|
| specification | durable | accepted current normative contract and acceptance criteria |
| acceptance record | maintained | current acceptance conclusion, checked scope, evidence references, and valid feedback |
| decision record | durable | an independently owned choice and rationale |
| work plan | optional, working | unfinished transition, execution, and blockers |
| handoff | transient | one explicit transfer of work |

These are common forms, not a closed list. Other project documents may be created for a distinct useful responsibility. Repository conventions take precedence over fallback shapes and paths; avoid duplicate maintenance, diaries and content that has lost its use rather than limiting document types or counts.

The specification states the accepted current contract. Implementation is the actual system state; evidence supports whether it conforms. Inputs supply requested targets or constraints, and an optional plan coordinates the transition. Contract acceptance does not by itself establish implementation conformance, and implementation drift does not redefine the contract.

Alongside the contract, a specification retains a brief current implementation and verification conclusion, including explicit completion or remaining gaps. It links to existing work or acceptance evidence while detailed tracking stays with its owner. The agent implementing or verifying a change updates the affected conclusion and references before finishing; replace outdated state rather than accumulating history. Existing valid evidence and verification of affected changes can support the updated conclusion.

For continuing acceptance and feedback, reuse a suitable existing owner or establish a stable acceptance record. It owns current results, their checked scope and evidence references, and still-valid feedback; the specification displays a brief summary and link. Existing issues and CI retain their detailed tracking and raw results. Feedback is handled as a defect against accepted requirements, a proposed contract change requiring acceptance, or an opinion needing clarification. The responsible agent synchronizes these owners and the specification summary as the work changes. Read the [acceptance lifecycle](skills/managing-project-docs/references/acceptance.md) for maintenance and retirement.

A contract may use an overall specification and subordinate technical specifications without separate releases or lifecycles. Each layer owns distinct content; necessary technical semantics remain explicit.

An existing README or API document may already serve as the maintained specification. If the task involves a durable contract with no suitable owner, establish one and move accepted contract content out of the work plan; unaccepted targets remain clearly proposed. Taking over an existing project does not by itself require reconstructing unrelated specifications. Distinguish observed behavior, the authorized target, and unresolved questions when drafting a missing contract.

Task inputs, including traditional requirements specifications, define or constrain requested work. Using a document as input neither creates nor removes its maintenance responsibilities. Inputs without maintenance responsibilities remain unchanged unless maintaining them is part of the authorized task. Coordinate the transition from the current contract to the authorized target in working context or a work plan when needed, then synchronize accepted changes into the canonical specification.

## Example

For a feature with a material design choice, draft the proposed contract before implementation when it can be defined, and synchronize it into the current specification when accepted. Add a decision record only when its rationale remains independently useful, a work plan only when execution must remain coordinated or resumable, and a handoff only for an actual transfer. Keep plans focused on remaining work rather than task history; retain a plan with unverified delivery work. Before retiring a plan, synchronize its continuing acceptance owner and specification conclusion, replacing delivered work links with that owner or acceptance evidence. Feedback outside the plan's Goal does not keep it open, and a useful acceptance record continues after it closes. Cancellation preserves actual gaps without withdrawing the accepted contract. Move other still-current facts to their owners and retire working or transient records under their lifecycle rules. Confirm still-needed content is recoverable before replacing it or relying on Git history.

## Default paths

- specifications: `docs/specs/<logical-path>.md`
- continuing acceptance: `docs/acceptance/<topic>.md` when no suitable owner exists
- decision records: `docs/design/YYYY-MM-DD-<topic>-design.md`
- work plans: `docs/plans/<topic>.md`
- handoffs: `docs/handoffs/<topic>.md`

Specification paths may be flat or grouped into business, subsystem, or technical subdirectories. Grouping supports navigation without requiring a document for each directory or mirroring every specification layer; keep existing canonical paths unless reorganizing them is part of the task. Update accepted contracts in place; Git owns historical versions, while specifications carry the current contract and current conformance conclusion.

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
