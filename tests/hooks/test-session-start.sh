#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
NODE_BIN="${NODE_BIN:-$(command -v node 2>/dev/null || command -v node.exe 2>/dev/null || true)}"

if [[ -z "$NODE_BIN" ]]; then
  echo "SKIP: node is unavailable inside this shell"
  exit 0
fi

check_hook() {
  local label="$1" script="$2"
  local output
  output="$(PLUGIN_ROOT="$ROOT" CLAUDE_PLUGIN_ROOT="$ROOT" bash "$script")"
  printf '%s' "$output" | "$NODE_BIN" -e '
const fs = require("fs");
const payload = JSON.parse(fs.readFileSync(0, "utf8"));
const hook = payload.hookSpecificOutput;
if (!hook || hook.hookEventName !== "SessionStart") process.exit(1);
if (typeof hook.additionalContext !== "string" || !hook.additionalContext.includes("# Using APEX")) process.exit(1);
if (!hook.additionalContext.includes("brainstorming") || !hook.additionalContext.includes("shaping-solutions")) process.exit(1);
' || { echo "FAIL: $label"; exit 1; }
  echo "PASS: $label"
}

check_hook "Claude Code/Antigravity hook emits nested APEX context" "$ROOT/hooks/session-start"
check_hook "Codex hook emits nested APEX context" "$ROOT/hooks/session-start-codex"

wrapper_output="$(PLUGIN_ROOT="$ROOT" CLAUDE_PLUGIN_ROOT="$ROOT" bash "$ROOT/hooks/run-hook.cmd" session-start-codex)"
printf '%s' "$wrapper_output" | "$NODE_BIN" -e 'JSON.parse(require("fs").readFileSync(0,"utf8"))' \
  || { echo "FAIL: Codex wrapper"; exit 1; }
echo "PASS: Codex wrapper dispatch"
