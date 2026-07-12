#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
failures=0

pass() { echo "  [PASS] $1"; }
fail() { echo "  [FAIL] $1"; failures=$((failures + 1)); }
has() { grep -Fq "$2" "$1" && pass "$3" || fail "$3"; }
lacks() { grep -Fq "$2" "$1" && fail "$3" || pass "$3"; }

expected="coordinating-subagents debugging-systematically governing-project-work managing-git shaping-solutions testing-changes using-apex"
actual="$(find "$ROOT/skills" -mindepth 1 -maxdepth 1 -type d -exec test -f '{}/SKILL.md' \; -print | sed 's#.*/##' | sort | tr '\n' ' ' | sed 's/ $//')"
[ "$actual" = "$expected" ] && pass "exactly seven intended skills exist" || {
  fail "exactly seven intended skills exist"
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
lacks "$entry" "references/codex-tools.md" "entry has no platform tool catalog"

governance="$ROOT/skills/governing-project-work/SKILL.md"
has "$governance" "Missing mutation authority is not permission" "governance keeps authority explicit"

subagents="$ROOT/skills/coordinating-subagents/SKILL.md"
has "$subagents" "Delegation alone is read-only" "delegation does not grant mutation"
has "$subagents" "Do not create a parallel" "subagents use Git and plan as source of truth"
has "$subagents" "Summaries describe observed state" "summaries do not claim content identity"

git_skill="$ROOT/skills/managing-git/SKILL.md"
has "$git_skill" 'default to `.worktrees/`' "manual worktree fallback uses project-local default"
has "$git_skill" "Never bundle them into merge or push" "Git lifecycle actions remain separate"

testing="$ROOT/skills/testing-changes/SKILL.md"
has "$testing" "Do not force TDD" "TDD is conditional"

has "$ROOT/skills/governing-project-work/SKILL.md" 'research-contracts.md' \
  "governance routes specialized research contracts"
has "$ROOT/README.md" '| `brainstorming`, `writing-plans` | `shaping-solutions` |' \
  "README documents old-name migration"

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
