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
check "$CONTRACT" '`stage` permits adding or removing' "index mutation has explicit authority"
check "$CONTRACT" '`worktree` permits creating a worktree' "worktree mutation has explicit authority"
check "$CONTRACT" '`external_mutations`' "external mutation authority is separate"
check "$CONTRACT" '`selected_mechanisms`' "selected mechanisms are represented"
check "$CONTRACT" "every required phase role is in" "delegated roles gate delegated execution"
check "$CONTRACT" "each delegated investigator role is in" "delegated roles gate parallel investigation"
check "$CONTRACT" "Only a delegated subagent reviewer additionally requires" "non-subagent review remains independent of delegation"
check "$CONTRACT" "Availability alone is not a predicate" "tool availability cannot select a mechanism"
check "$CONTRACT" "does not make evidence stale" "evidence freshness is state-based"
check "$CONTRACT" "ls-files --stage -z" "working-tree evidence covers staged changes"
check "$CONTRACT" "non-ignored untracked path" "working-tree evidence covers Git-visible untracked files"
check "$CONTRACT" "explicitly named repository-relative extra inputs" "ignored claim inputs require explicit scope"
check "$CONTRACT" "Explicit extra inputs reuse the same record types" "extra inputs share canonical serialization"
check "$CONTRACT" 'exact `gitVisible` value `tracked+nonignored-untracked`' "scope descriptor uses one canonical literal"
check "$CONTRACT" "reject any symbolic-link/junction ancestor" "extra paths cannot traverse linked ancestors"
check "$CONTRACT" "Reject non-UTF-8 Git paths and unmerged index entries" "ambiguous Git states fail closed"
check "$CONTRACT" "index was empty before" "commit excludes pre-staged user changes"
check "$CONTRACT" "normal fast-forward update of an explicitly named branch" "push authority is narrow"
check "$CONTRACT" '`force-push` and `delete-ref` are separate destructive authorities' "destructive ref mutations require separate authority"
check "$CONTRACT" "Delegated agents are read-only unless" "delegates default to read-only"
check "$WORKFLOW" "Leaf workflows may stop when their preconditions are" "leaf workflows cannot escalate policy"
check "$SKILL" "Workflow skills consume the decision record" "skill routes composition through the contract"

if [ "$failures" -gt 0 ]; then
    echo "STATUS: FAILED ($failures failures)"
    exit 1
fi

echo "STATUS: PASSED"
