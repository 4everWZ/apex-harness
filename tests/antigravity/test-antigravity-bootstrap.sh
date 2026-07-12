#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
ENTRY="$ROOT/skills/using-apex/SKILL.md"
HOOK="$ROOT/hooks/session-start"

[ -f "$ENTRY" ] || { echo "FAIL: using-apex entry missing"; exit 1; }
[ -f "$HOOK" ] || { echo "FAIL: session-start hook missing"; exit 1; }

if find "$ROOT/skills/using-apex" -type f -name '*-tools.md' | grep -q .; then
  echo "FAIL: platform tool catalogs should not be bundled"
  exit 1
fi

grep -q 'using-apex' "$HOOK" || {
  echo "FAIL: session-start hook does not bootstrap using-apex"
  exit 1
}

echo "PASS: Antigravity uses the shared bootstrap without a stale tool catalog"
