# Codex adapter contract

Use this reference only when the `using-apex` bootstrap does not already include
an authoritative Codex mapping. Codex tool names and availability vary by host,
version, mode, and installed connectors, so inspect the tools exposed in the
current session before acting.

## Resolve actions from capabilities

Map leaf-skill actions to the current interface by capability:

| Skill action | Required capability |
|---|---|
| Read or search local files | read-only shell or repository search |
| Create, edit, or delete files | structured patch/edit capability |
| Run commands | shell execution using the observed operating system |
| Fetch or search external information | an exposed web/fetch connector, or an authorized shell fallback |
| Invoke a skill | Codex's native skill-loading mechanism |
| Dispatch independent work | the exposed multi-agent interface, when enabled and authorized |
| Wait for agent results | the matching agent-lifecycle operation, not a shell-process wait |
| Track tasks | the exposed plan/task update mechanism |

Do not copy tool names, parameters, or model selectors from examples when they
are absent from the live interface. If the required capability is missing,
follow the leaf's documented inline fallback or report the boundary.

## Repository instructions

Codex uses `AGENTS.md`-family repository instructions. Read the instructions that
apply to the current path before editing. Repository and user rules override
this adapter and every leaf skill.

## Skill locations

Codex installations may expose user, repository, plugin, or cross-runtime skill
catalogs. Use the catalog already surfaced by the host. Do not infer precedence
between duplicate skill names; report the collision or follow an explicit host
rule.

## Multi-agent boundary

Agent availability is not delegation authority. When APEX selects delegation:

- use only agent operations present in the live interface
- pass a bounded role, mutation boundary, required evidence, and expected report
- keep read-only investigations read-only
- do not invent a close, wait, model, or workspace parameter
- if isolation required for correctness is unavailable, stop rather than
  emulating it with shared-state parallel edits

## Git and workspace handling

Inspect the real repository and workspace state with read-only Git commands.
Treat a host-managed workspace as externally owned unless the host says
otherwise. A detached `HEAD` or linked worktree is a state to reason about, not
automatic permission to commit, create branches, push, or remove the workspace.

The current Codex interface and higher-priority instructions are the source of
truth; this file supplies translation principles, not a frozen API inventory.
