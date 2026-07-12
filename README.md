# APEX

APEX is a governed software-engineering skill series for coding agents. It
separates command decisions from execution mechanisms:

- `using-apex` is the session entry and skill router.
- `apex-governance` owns risk, user decision boundaries, mutation authority,
  verification intensity, evidence freshness, and documentation obligations.
- the remaining skills are stable, action-named leaves such as
  `brainstorming`, `systematic-debugging`, `writing-plans`, and
  `verification-before-completion`.

## Structure

```text
skills/
├── using-apex/
├── apex-governance/
├── brainstorming/
├── systematic-debugging/
├── test-driven-development/
├── writing-plans/
├── executing-plans/
├── subagent-driven-development/
├── dispatching-parallel-agents/
├── requesting-code-review/
├── receiving-code-review/
├── verification-before-completion/
├── using-git-worktrees/
└── finishing-a-development-branch/
```

Leaf names remain stable for trigger compatibility. Leaves consume APEX
decisions and cannot broaden scope, authority, delegation, verification, or
documentation requirements.

## Verification

Run the focused contracts relevant to a change:

```bash
bash tests/apex-governance/test-governance-contract.sh
bash tests/apex-governance/test-spec-templates.sh
bash tests/claude-code/test-governance-composition.sh
node --test tests/pi/test-pi-extension.mjs
```

Behavior-changing skill revisions require realistic trigger and pressure
evaluations against a previous-version baseline. Static string tests protect
interfaces but do not prove agent behavior.

## Provenance

The leaf workflows and cross-harness adapter foundation were derived from the
Superpowers project. The governance layer originated in the standalone
`apex-harness` skill. This repository consolidates and refactors both into one
APEX-governed series while preserving their applicable license and attribution.
