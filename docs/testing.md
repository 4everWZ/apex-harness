# Testing APEX

Use the narrowest suite that covers the changed contract.

## Structural contracts

```bash
bash tests/apex/test-series-contract.sh
bash tests/apex/test-documentation-contract.sh
bash tests/claude-code/run-skill-tests.sh
```

Validate frontmatter and skill structure with the official `skill-creator`
validator in a repository-local environment:

```powershell
python -m venv .venv
.\.venv\Scripts\python.exe -m pip install -r requirements-skill-validation.txt
$env:SKILL_CREATOR_PATH = '<installed skill-creator directory>'
.\scripts\validate-skills.ps1
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

The source file records candidate checks as `assertions`. Per-run
`eval_metadata.json` preserves that field; grader output records the same text
as `expectations` with pass/fail evidence. Retained results include metadata,
raw outputs, grading, and benchmark fields needed to audit that conversion.
