#!/usr/bin/env bash
# Static checks for the APEX governance contract.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
APEX_SKILL="$REPO_ROOT/skills/apex-governance"
CONTRACT="$APEX_SKILL/references/governance_contract.md"
WORKFLOW="$APEX_SKILL/references/workflow.md"
SKILL="$APEX_SKILL/SKILL.md"
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
check "$CONTRACT" '`spec review` is listed in `selected_mechanisms`' "spec review has an explicit selection predicate"
check "$CONTRACT" '`spec-document-reviewer` in `delegated_roles`' "delegated spec review requires its role"
check "$WORKFLOW" "contract density or risk makes planning errors materially costly" "workflow selects spec review proportionately"
check "$CONTRACT" "Only a delegated subagent reviewer additionally requires" "non-subagent review remains independent of delegation"
check "$CONTRACT" "Availability alone is not a predicate" "tool availability cannot select a mechanism"
check "$CONTRACT" "message boundary alone does not make" "evidence freshness is state-based"
check "$CONTRACT" "git status --short --branch" "working-tree evidence records status"
check "$CONTRACT" 'git diff --stat' "working-tree evidence records unstaged diff summary"
check "$CONTRACT" 'git diff --cached --stat' "working-tree evidence separates staged changes"
check "$CONTRACT" "Git-invisible input" "ignored and external inputs are explicit"
check "$CONTRACT" "prove byte-for-byte identity" "working-tree summary does not overclaim identity"
check "$CONTRACT" "narrow the freshness claim to the observed run" "unidentified external inputs narrow freshness"
obsolete_found=0
for obsolete in \
    'governance-working-tree-v2' \
    'identifierSha256' \
    'scopeSha256' \
    'trackedWorktreeSha256' \
    'NUL-separated fields' \
    'ls-files --stage -z'; do
    if grep -Fq "$obsolete" "$CONTRACT"; then
        echo "  [FAIL] obsolete serialization detail remains: $obsolete"
        failures=$((failures + 1))
        obsolete_found=1
    fi
done
if [ "$obsolete_found" -eq 0 ]; then
    echo "  [PASS] obsolete custom serialization contract removed"
fi
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
