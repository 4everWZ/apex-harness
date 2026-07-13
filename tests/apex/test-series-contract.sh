#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
failures=0

pass() { echo "  [PASS] $1"; }
fail() { echo "  [FAIL] $1"; failures=$((failures + 1)); }
has() { grep -Fq "$2" "$1" && pass "$3" || fail "$3"; }
lacks() { grep -Fq "$2" "$1" && fail "$3" || pass "$3"; }

expected="coordinating-subagents debugging-systematically governing-project-work managing-git managing-project-docs shaping-solutions testing-changes using-apex"
actual="$(find "$ROOT/skills" -mindepth 1 -maxdepth 1 -type d -exec test -f '{}/SKILL.md' \; -print | sed 's#.*/##' | sort | tr '\n' ' ' | sed 's/ $//')"
[ "$actual" = "$expected" ] && pass "exactly eight intended skills exist" || {
  fail "exactly eight intended skills exist"
  echo "    expected: $expected"
  echo "    actual:   $actual"
}

for skill in $expected; do
  file="$ROOT/skills/$skill/SKILL.md"
  has "$file" "name: $skill" "$skill frontmatter matches directory"
  lacks "$file" "superpowers:" "$skill has no stale namespace"
done

entry="$ROOT/skills/using-apex/SKILL.md"
has "$entry" "For a routine, bounded edit, use no leaf" "entry keeps routine work lightweight"
has "$entry" '`governing-project-work`' "entry routes substantial governance"
has "$entry" '`managing-project-docs`' "entry knows the direct documentation leaf"
has "$entry" "not a mandatory parent call" "entry does not shadow direct leaves"
lacks "$entry" "references/codex-tools.md" "entry has no platform tool catalog"

governance="$ROOT/skills/governing-project-work/SKILL.md"
has "$governance" "Missing mutation authority is not permission" "governance keeps authority explicit"

subagents="$ROOT/skills/coordinating-subagents/SKILL.md"
has "$subagents" "Delegation alone is read-only" "delegation does not grant mutation"
has "$subagents" "This coordination workflow is opt-in" "subagent workflow requires user activation"
has "$subagents" "Codex and its runtime retain their normal" "subagent workflow preserves Codex defaults"
lacks "$subagents" "reasoning effort" "subagent workflow does not override reasoning settings"
has "$subagents" "approved task boundary or plan remain the source of truth" \
  "subagents use Git and task boundary as source of truth"
has "$subagents" "Summaries describe observed state" "summaries do not claim content identity"

docs_skill="$ROOT/skills/managing-project-docs/SKILL.md"
has "$docs_skill" "This skill is directly selectable" "documentation does not require bootstrap"
has "$docs_skill" "do not activate full project governance" "documentation does not imply full governance"

git_skill="$ROOT/skills/managing-git/SKILL.md"
has "$git_skill" 'default to `.worktrees/`' "manual worktree fallback uses project-local default"
has "$git_skill" "Never bundle them into merge or push" "Git lifecycle actions remain separate"

testing="$ROOT/skills/testing-changes/SKILL.md"
has "$testing" "Do not force TDD" "TDD is conditional"

has "$ROOT/skills/governing-project-work/SKILL.md" 'research-contracts.md' \
  "governance routes specialized research contracts"
has "$ROOT/skills/using-apex/SKILL.md" \
  '`brainstorming` or `writing-plans` → `shaping-solutions`' \
  "injected entry documents old-name migration"

for old_name in \
  apex-governance \
  brainstorming \
  writing-plans \
  using-git-worktrees \
  finishing-a-development-branch \
  dispatching-parallel-agents \
  subagent-driven-development \
  executing-plans \
  requesting-code-review \
  receiving-code-review \
  systematic-debugging \
  test-driven-development \
  verification-before-completion; do
  has "$entry" "\`$old_name\`" "migration names $old_name explicitly"
done

while IFS= read -r import; do
  target="${import#@./}"
  [ -f "$ROOT/$target" ] && pass "GEMINI import exists: $target" || fail "GEMINI import exists: $target"
done < <(grep '^@\./' "$ROOT/GEMINI.md")

if find "$ROOT/skills/using-apex" -type f -name '*-tools.md' | grep -q .; then
  fail "entry contains no platform tool catalogs"
else
  pass "entry contains no platform tool catalogs"
fi

if [ "$failures" -gt 0 ]; then
  echo "STATUS: FAILED ($failures failures)"
  exit 1
fi
echo "STATUS: PASSED"
