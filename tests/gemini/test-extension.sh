#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"

python3 - "$ROOT/gemini-extension.json" <<'PY'
import json, sys
manifest = json.load(open(sys.argv[1], encoding="utf-8"))
assert manifest["name"] == "apex"
assert manifest["contextFileName"] == "GEMINI.md"
PY

grep -Fxq '@./skills/using-apex/SKILL.md' "$ROOT/GEMINI.md"
test -f "$ROOT/skills/using-apex/SKILL.md"
echo "PASS: Gemini CLI extension imports using-apex"
