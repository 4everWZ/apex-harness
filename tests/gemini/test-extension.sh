#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"

NODE_BIN="${NODE_BIN:-$(command -v node 2>/dev/null || command -v node.exe 2>/dev/null || true)}"
[[ -n "$NODE_BIN" ]] || { echo "FAIL: node is required to validate Gemini JSON"; exit 1; }
MANIFEST="$ROOT/gemini-extension.json"
if [[ "$NODE_BIN" == *.exe ]] && command -v wslpath >/dev/null 2>&1; then
  MANIFEST="$(wslpath -w "$MANIFEST")"
fi
"$NODE_BIN" -e '
const manifest = JSON.parse(require("fs").readFileSync(process.argv[1], "utf8"));
if (manifest.name !== "apex" || manifest.contextFileName !== "GEMINI.md") process.exit(1);
' "$MANIFEST"

grep -Fxq '@./skills/using-apex/SKILL.md' "$ROOT/GEMINI.md"
test -f "$ROOT/skills/using-apex/SKILL.md"
echo "PASS: Gemini CLI extension imports using-apex"
