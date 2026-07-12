#!/usr/bin/env bash
# Static contract checks for governance/leaf-skill composition.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
failures=0

assert_contains() {
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

assert_not_contains() {
    local file="$1"
    local pattern="$2"
    local label="$3"
    if grep -Fq "$pattern" "$file"; then
        echo "  [FAIL] $label"
        echo "    Forbidden: $pattern"
        echo "    File: $file"
        failures=$((failures + 1))
    else
        echo "  [PASS] $label"
    fi
}

USING="$REPO_ROOT/skills/using-apex/SKILL.md"
GOVERNANCE="$REPO_ROOT/skills/apex-governance/SKILL.md"
EXECUTING="$REPO_ROOT/skills/executing-plans/SKILL.md"
VERIFYING="$REPO_ROOT/skills/verification-before-completion/SKILL.md"
WORKTREES="$REPO_ROOT/skills/using-git-worktrees/SKILL.md"
SDD="$REPO_ROOT/skills/subagent-driven-development/SKILL.md"
WRITING_PLANS="$REPO_ROOT/skills/writing-plans/SKILL.md"
PARALLEL="$REPO_ROOT/skills/dispatching-parallel-agents/SKILL.md"
REVIEWER="$REPO_ROOT/skills/requesting-code-review/code-reviewer.md"
SPEC_REVIEWER="$REPO_ROOT/skills/brainstorming/spec-document-reviewer-prompt.md"
BRAINS="$REPO_ROOT/skills/brainstorming/SKILL.md"
RECEIVING="$REPO_ROOT/skills/receiving-code-review/SKILL.md"
FINISHING="$REPO_ROOT/skills/finishing-a-development-branch/SKILL.md"
TDD="$REPO_ROOT/skills/test-driven-development/SKILL.md"
DEBUGGING="$REPO_ROOT/skills/systematic-debugging/SKILL.md"

echo "=== Governance Composition Contract ==="

for leaf in "$REPO_ROOT"/skills/*/SKILL.md; do
    [ "$leaf" = "$USING" ] && continue
    [ "$leaf" = "$GOVERNANCE" ] && continue
    assert_contains "$leaf" "## APEX boundary" \
        "$(basename "$(dirname "$leaf")") declares its APEX leaf boundary"
    assert_not_contains "$leaf" "superpowers:" \
        "$(basename "$(dirname "$leaf")") uses runtime-neutral skill names"
done

assert_not_contains "$REPO_ROOT/skills/using-apex/SKILL.md" "using-superpowers" \
    "using-apex is the canonical entry name"

assert_contains "$USING" "cannot increase the recorded authority" \
    "leaf skills cannot escalate governance authority"
assert_contains "$USING" "separate capabilities" \
    "Git, delegated, and external mutation authority stay separate"
assert_not_contains "$EXECUTING" "If subagents are available, use" \
    "subagent availability does not force delegation"
assert_contains "$SDD" 'availability alone never selects delegation' \
    "tool availability does not select SDD"
assert_contains "$SDD" 'delegated `edit` authority is explicit' \
    "implementer edit authority must be explicit"
assert_contains "$SDD" 'stage or commit only when those capabilities are separately explicit' \
    "implementer Git authority is capability-separated"
assert_contains "$WORKTREES" 'Do not mutate `.gitignore` or commit automatically' \
    "worktree setup does not infer Git mutation authority"
assert_contains "$WORKTREES" 'Require `worktree` in the active APEX' \
    "worktree creation is gated by explicit authority"
assert_contains "$WORKTREES" 'tool that creates one implicitly' \
    "native worktree ref creation requires create-ref authority"
assert_contains "$WORKTREES" 'git worktree add "$path" "$EXISTING_BRANCH"' \
    "manual worktree fallback can attach an existing branch without create-ref"
assert_contains "$WORKTREES" 'General consent to isolation or tool availability is' \
    "isolation preference is not mutation authority"
assert_contains "$WORKTREES" "safe-in-place check" \
    "worktree fallback re-applies the governance safety predicate"
assert_contains "$VERIFYING" "message or agent boundary alone does not make evidence stale" \
    "verification freshness follows code state rather than message boundaries"
assert_contains "$RECEIVING" 'Without edit authority' \
    "review reception preserves the edit authority gate"
assert_contains "$FINISHING" '`merge` authority' \
    "branch finishing requires merge authority"
assert_contains "$TDD" 'authorized uncommitted agent-authored portion' \
    "TDD deletion is scoped to authorized agent work"
assert_contains "$DEBUGGING" 'edit/runtime-mutation authority' \
    "debugging keeps runtime mutations authority-gated"
assert_contains "$SDD" 'Do not create a parallel' \
    "SDD has no custom artifact state system"
assert_contains "$SDD" 'summaries describe the observed state; they are not content identity' \
    "SDD summaries do not overclaim identity"
assert_contains "$SDD" 'evidence is ambiguous, re-inspect' \
    "SDD refreshes ambiguous recovery evidence"
assert_contains "$SDD" '`git rev-parse --verify HEAD` resolves to a commit' \
    "commit-range SDD rejects unborn repositories"
assert_not_contains "$WRITING_PLANS" "Complete code in every step" \
    "plans do not duplicate complete implementations by default"
assert_contains "$SDD" "do not create a second commit" \
    "delegated task commits do not cause a second controller commit"
assert_contains "$REPO_ROOT/skills/requesting-code-review/SKILL.md" \
    "working-tree" "edit-only changes support independent review without commit"
assert_contains "$SCRIPT_DIR/test-governance-composition-cases.mjs" \
    "resolveGovernance(testCase.facts)" "scenario fixtures are resolved from facts"
assert_contains "$PARALLEL" "This skill is read-only by default" \
    "parallel investigation defaults to read-only"
assert_not_contains "$PARALLEL" "found and fixed" \
    "parallel investigation does not instruct agents to fix"
assert_contains "$REVIEWER" "Do not create a worktree yourself" \
    "read-only reviewers cannot infer worktree authority"
assert_contains "$REPO_ROOT/skills/requesting-code-review/SKILL.md" \
    "Freeze the review-relevant paths" "working-tree review has a freshness boundary"
assert_contains "$REPO_ROOT/skills/requesting-code-review/SKILL.md" \
    "Git-invisible inputs" "ignored review inputs require explicit scope"
assert_not_contains "$REPO_ROOT/skills/requesting-code-review/SKILL.md" \
    "canonical working-tree identifier" "review leaf does not duplicate APEX serialization policy"
assert_contains "$SPEC_REVIEWER" "Ready for planning | Issues Found" \
    "spec review reports readiness rather than design approval"
assert_not_contains "$SPEC_REVIEWER" "Status:** Approved" \
    "spec reviewer cannot grant decision approval"
assert_not_contains "$SPEC_REVIEWER" "Approve unless" \
    "spec reviewer calibration does not imply approval authority"
assert_contains "$SPEC_REVIEWER" "repository convention or active governance" \
    "spec reviewer follows the resolved documentation path"
assert_contains "$SPEC_REVIEWER" "[GOVERNING_SPEC_CONTRACT]" \
    "spec reviewer receives the applicable contract"
assert_contains "$BRAINS" "do not transcribe the same approved design" \
    "brainstorming does not duplicate an approved design into a second spec"
assert_contains "$BRAINS" "selected independent review cannot" \
    "independent spec review remains governance-selected"
assert_contains "$BRAINS" '`spec review` in `selected_mechanisms`' \
    "spec review selection uses the governance mechanism"
assert_contains "$BRAINS" '`spec-document-reviewer` in `delegated_roles`' \
    "delegated spec review requires its authorized role"
assert_contains "$BRAINS" 'An `Issues Found` result blocks planning' \
    "blocking review findings are consumed"
assert_contains "$BRAINS" 'only after `Ready for planning`' \
    "selected spec review must reach readiness"
assert_contains "$BRAINS" 'writing, self-review, or independent review' \
    "all sources of material choices return to user authority"
assert_contains "$BRAINS" '"Resolve review issues" -> "Review exposed material choice?"' \
    "review fixes check for material changes"
assert_contains "$BRAINS" '"Review exposed material choice?" -> "Independent review ready?"' \
    "non-material review fixes return to re-review"
assert_contains "$SPEC_REVIEWER" 'Every violation of a required governing-contract' \
    "governing contract violations block readiness"
assert_contains "$SPEC_REVIEWER" 'Progressive disclosure' \
    "spec review checks on-demand detail loading"
assert_contains "$SPEC_REVIEWER" 'document volume disproportionate' \
    "spec review checks documentation bloat"

if command -v node >/dev/null 2>&1; then
    node "$SCRIPT_DIR/test-governance-composition-cases.mjs" || failures=$((failures + 1))
else
    echo "  [SKIP] node unavailable; run test-governance-composition-cases.mjs on a Node-capable host"
fi

if [ "$failures" -gt 0 ]; then
    echo "STATUS: FAILED ($failures failures)"
    exit 1
fi

echo "STATUS: PASSED"
