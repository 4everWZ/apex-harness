#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
DOC="$ROOT/skills/governing-project-work/references/documentation.md"
FLOW="$ROOT/skills/governing-project-work/references/workflow.md"
failures=0

check() {
  if grep -Fq "$2" "$1"; then
    echo "  [PASS] $3"
  else
    echo "  [FAIL] $3"
    failures=$((failures + 1))
  fi
}

check "$DOC" '`docs/specs/`' "spec location is defined"
check "$DOC" '`docs/design/`' "design location is defined"
check "$DOC" '`docs/plans/`' "plan location is defined"
check "$DOC" "One artifact owns each fact" "documentation has one source of truth"
check "$DOC" "user asks for a durable handoff" "status docs are demand-driven"
check "$FLOW" '`git status --short --branch`' "freshness records Git status"
check "$FLOW" "staged and unstaged diff summaries" "freshness separates diff summaries"
check "$FLOW" "explicit ignored, generated, external" "freshness names extra inputs"
check "$FLOW" "not content identities" "summaries do not overclaim identity"
check "$ROOT/skills/governing-project-work/SKILL.md" \
  "Governance decides whether substantial work requires a durable artifact" \
  "governance owns substantial artifact obligation"
check "$ROOT/skills/shaping-solutions/SKILL.md" \
  "owns the content and quality of the selected artifact" \
  "shaping owns selected artifact content"

if [ "$failures" -gt 0 ]; then
  echo "STATUS: FAILED ($failures failures)"
  exit 1
fi
echo "STATUS: PASSED"
