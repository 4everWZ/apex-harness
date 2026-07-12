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

`using-apex` is the sole bootstrap and routing entry. Runtimes may still expose
the leaves so the router can select them directly after bootstrap.
`governing-project-work` owns substantial-work risk, authority, evidence, and
documentation decisions. Leaves consume that boundary and do not duplicate it.

Governance fallback templates live under
`skills/governing-project-work/assets/templates/`. They cover development and
algorithm specs, design records, implementation plans, traceability matrices,
tradeoff entries, and user-requested status handoffs. Repository-native formats
take precedence; the fallbacks preserve a consistent docs and legacy lifecycle
without making every task create every artifact.

Subagent coordination is opt-in per task or phase. APEX does not select it from
available concurrency or potential speedup alone, and each enabled role gets
its own minimum-sufficient effort instead of a uniform setting.

## Supported runtime adapters

- Claude Code
- Codex
- Antigravity
- Gemini CLI

Other agent runtimes are intentionally unsupported; their manifests, adapters,
and tests are not bundled.

Claude Code and Gemini CLI provide local manifest validators. Codex and
Antigravity currently have no repository-local host-install smoke test, so their
checks validate referenced files and execute the hook payload but do not claim
that a host discovered or installed the adapter.

## Verification

```bash
bash tests/apex/test-series-contract.sh
bash tests/apex/test-documentation-contract.sh
bash tests/apex/test-adapter-scope.sh
bash tests/claude-code/run-skill-tests.sh
bash tests/hooks/test-session-start.sh
bash tests/antigravity/run-tests.sh
bash tests/gemini/test-extension.sh
claude plugin validate --strict .
gemini extensions validate .
```

Material skill changes also require realistic evaluations against the prior
version or a no-skill baseline. Static checks protect structure, not behavior.
Contributor architecture guidance lives in
[`docs/contributing.md`](docs/contributing.md).

## Migration from the consolidated skills

The seven-skill series intentionally changes direct skill names. The canonical
old-to-new routing table is embedded in [`using-apex`](skills/using-apex/SKILL.md)
so every injected bootstrap can resolve it without an external path.

Prompts should use the current names. `using-apex` can translate a user's old
workflow wording, but direct runtime lookup of a deleted name is a breaking
change required to keep the series below eight skills.

The brainstorming browser server and visual companion were deliberately
removed. Visual comparisons should use the current runtime's image, browser, or
rendering tools when the task actually needs them; APEX no longer bundles a
long-lived local visual server.

## Provenance

APEX consolidates the useful governance ideas from `apex-harness` and focused
workflow ideas from Superpowers. The series is deliberately smaller: platform
tool tutorials, duplicate engineering common sense, and overlapping workflow
skills are not retained.
