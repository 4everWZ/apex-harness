# Testing APEX

Use the narrowest suite that covers the changed contract.

## Structural contracts

```bash
bash tests/apex-governance/test-governance-contract.sh
bash tests/apex-governance/test-spec-templates.sh
bash tests/claude-code/test-governance-composition.sh
bash tests/claude-code/test-worktree-path-policy.sh
```

## Adapter checks

```bash
node --check .opencode/plugins/apex.js
node --test tests/pi/test-pi-extension.mjs
bash tests/kimi/run-tests.sh
bash tests/antigravity/run-tests.sh
```

## Behavior evaluation

Material skill changes require realistic with-skill and previous-version or
no-skill baselines. Keep prompts in `evals/evals.json`; include direct triggers,
natural triggers, adjacent skills, and should-not-trigger cases. Pressure-test
discipline and destructive-action boundaries. Static string checks do not prove
agent behavior.
