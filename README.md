# APEX

APEX is a compact software-engineering skill series for coding agents. It adds
explicit governance only where ordinary model judgment is insufficient and
keeps execution workflows focused.

## Skills

```text
skills/
├── using-apex/
├── governing-project-work/
├── shaping-solutions/
├── managing-git/
├── coordinating-subagents/
├── debugging-systematically/
└── testing-changes/
```

`using-apex` is the sole entry. `governing-project-work` owns substantial-work
risk, authority, evidence, and documentation decisions. Leaves consume that
boundary and do not duplicate it.

## Verification

```bash
bash tests/apex/test-series-contract.sh
bash tests/apex/test-documentation-contract.sh
bash tests/claude-code/run-skill-tests.sh
node --test tests/pi/test-pi-extension.mjs
```

Material skill changes also require realistic evaluations against the prior
version or a no-skill baseline. Static checks protect structure, not behavior.

## Provenance

APEX consolidates the useful governance ideas from `apex-harness` and focused
workflow ideas from Superpowers. The series is deliberately smaller: platform
tool tutorials, duplicate engineering common sense, and overlapping workflow
skills are not retained.
