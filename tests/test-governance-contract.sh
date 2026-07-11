#!/usr/bin/env bash
# Static checks for the APEX governance contract.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
CONTRACT="$REPO_ROOT/references/governance_contract.md"
WORKFLOW="$REPO_ROOT/references/workflow.md"
SKILL="$REPO_ROOT/SKILL.md"
failures=0

check() {
    local file="$1"
    local pattern="$2"
    local label="$3"
    if grep -Fq "$pattern" "$file"; then
        echo "  [PASS] $label"
    else
        echo "  [FAIL] $label"
        echo "    Expected: $pattern"
        echo "    File: $file"
        failures=$((failures + 1))
    fi
}

echo "=== APEX Governance Contract ==="

check "$CONTRACT" '`git_authority`' "Git authority is explicit"
check "$CONTRACT" '`worktree` permits creating a worktree' "worktree mutation has explicit authority"
check "$CONTRACT" '`external_mutations`' "external mutation authority is separate"
check "$CONTRACT" '`selected_mechanisms`' "selected mechanisms are represented"
check "$CONTRACT" "Availability alone is not a predicate" "tool availability cannot select a mechanism"
check "$CONTRACT" "does not make evidence stale" "evidence freshness is state-based"
check "$CONTRACT" "binary staged diff" "working-tree evidence covers staged changes"
check "$CONTRACT" "manifest of untracked files" "working-tree evidence covers untracked files"
check "$CONTRACT" "Delegated agents are read-only unless" "delegates default to read-only"
check "$WORKFLOW" "Leaf workflows may stop when their preconditions are" "leaf workflows cannot escalate policy"
check "$SKILL" "Workflow skills consume the decision record" "skill routes composition through the contract"

if [ "$failures" -gt 0 ]; then
    echo "STATUS: FAILED ($failures failures)"
    exit 1
fi

echo "STATUS: PASSED"
