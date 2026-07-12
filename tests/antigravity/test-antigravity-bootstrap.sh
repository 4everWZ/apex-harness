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

NODE_BIN="${NODE_BIN:-$(command -v node 2>/dev/null || command -v node.exe 2>/dev/null || true)}"
[[ -n "$NODE_BIN" ]] || { echo "FAIL: node is required to validate hook JSON"; exit 1; }
output="$(CLAUDE_PLUGIN_ROOT="$ROOT" bash "$HOOK")"
printf '%s' "$output" | "$NODE_BIN" -e '
const payload = JSON.parse(require("fs").readFileSync(0, "utf8"));
const context = payload.hookSpecificOutput?.additionalContext;
if (typeof context !== "string" || !context.includes("# Using APEX")) process.exit(1);
' || { echo "FAIL: shared hook did not emit consumable APEX context"; exit 1; }

echo "PASS: shared Antigravity hook payload is structurally consumable"
echo "UNVERIFIED: Antigravity host discovery/install requires a host smoke test"
