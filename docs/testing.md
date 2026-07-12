# Testing APEX

Use the narrowest suite that covers the changed contract.

## Structural contracts

```bash
bash tests/apex/test-series-contract.sh
bash tests/apex/test-documentation-contract.sh
bash tests/claude-code/run-skill-tests.sh
```

## Adapter checks

```bash
node --check .opencode/plugins/apex.js
node --test tests/pi/test-pi-extension.mjs
bash tests/kimi/run-tests.sh
bash tests/antigravity/run-tests.sh
```

## Behavior evaluation

Keep realistic prompts in `evals/evals.json`. Cover routing, adjacent-skill
boundaries, authorization pressure, dirty or unborn Git states, documentation
proportionality, and cases where no leaf should trigger. Compare material
revisions with the prior committed series or a no-skill baseline.
