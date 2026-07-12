#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"

for required in \
  .claude-plugin/plugin.json \
  .codex-plugin/plugin.json \
  hooks/hooks.json \
  hooks/hooks-codex.json \
  hooks/session-start-windows.ps1 \
  tests/hooks/test-windows-wrapper.ps1 \
  tests/antigravity/test-antigravity-bootstrap.sh \
  gemini-extension.json \
  GEMINI.md; do
  test -f "$ROOT/$required" || { echo "FAIL: missing supported adapter file $required"; exit 1; }
done

for unsupported in \
  .cursor-plugin/plugin.json \
  .kimi-plugin/plugin.json \
  .opencode/plugins/apex.js \
  .pi/extensions/apex.ts \
  hooks/hooks-cursor.json \
  tests/kimi \
  tests/opencode \
  tests/pi; do
  test ! -e "$ROOT/$unsupported" || { echo "FAIL: unsupported adapter remains: $unsupported"; exit 1; }
done

echo "PASS: adapter scope is Claude Code, Codex, Antigravity, and Gemini CLI only"
