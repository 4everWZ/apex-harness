#!/usr/bin/env bash

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
APEX_SKILL="$ROOT/skills/apex-governance"
SKILL="$APEX_SKILL/SKILL.md"
SPEC="$APEX_SKILL/references/spec_governance.md"
DEV="$APEX_SKILL/references/dev_spec_template.md"
ALGO="$APEX_SKILL/references/algo_spec_template.md"
TRADEOFF="$APEX_SKILL/references/tradeoff_template.md"
MATRIX="$APEX_SKILL/references/matrix_template.md"
failures=0

has() {
    local file="$1" pattern="$2" label="$3"
    if grep -Fq "$pattern" "$file"; then
        echo "  [PASS] $label"
    else
        echo "  [FAIL] $label"
        failures=$((failures + 1))
    fi
}

lacks() {
    local file="$1" pattern="$2" label="$3"
    if grep -Fq "$pattern" "$file"; then
        echo "  [FAIL] $label"
        failures=$((failures + 1))
    else
        echo "  [PASS] $label"
    fi
}

echo "=== APEX Spec Structure Contract ==="

has "$SKILL" 'references/spec_governance.md' "SKILL routes common spec governance"
has "$SKILL" 'references/dev_spec_template.md' "SKILL routes development profile"
has "$SKILL" 'references/algo_spec_template.md' "SKILL routes algorithm profile"

for template in "$DEV" "$ALGO"; do
    name="$(basename "$template")"
    has "$template" '**Decision Status:** draft | approved | deferred | rejected | superseded' "$name decision states"
    has "$template" '**Implementation Status:** not-started | in-progress | partial | implemented | not-applicable' "$name evidence states"
    has "$template" '**Decision Authority:**' "$name decision authority"
    has "$template" '## Verification and Acceptance' "$name observable acceptance"
    has "$template" '## Local Tradeoffs' "$name local tradeoffs"
    has "$template" '`spec_governance.md`' "$name common-governance route"
done

lacks "$DEV" '| Requirement ID |' "dev IDs stay optional"
lacks "$ALGO" '| Acceptance ID |' "algo IDs stay optional"
has "$DEV" '## Responsibilities and Ownership' "dev ownership contract"
has "$DEV" '## State and Data Flow' "dev state contract"
has "$DEV" 'public API or schema' "dev risk-triggered modules"
has "$ALGO" '**Algorithm Properties:**' "algo property selection"
has "$ALGO" '## Definitions and Assumptions' "algo semantic definitions"
has "$ALGO" 'interface conformance, algorithmic correctness, and empirical claim' "algo evidence layers"
has "$ALGO" 'floating-point, iterative, or approximate' "algo property-triggered modules"

has "$SPEC" 'Decision Reference` for every non-draft status' "lifecycle transition evidence"
has "$SPEC" 'Before moving to an inactive decision state' "inactive states stop active work"
has "$SPEC" 'Document-review readiness cannot change decision status' "readiness is not approval"
has "$SPEC" 'The prior revision' "approved amendments preserve governing history"
has "$SPEC" 'rejecting or withdrawing the draft does' "draft withdrawal preserves prior authority"
has "$SKILL" 'Load both templates only when both profiles materially affect one bounded contract' "mixed profile selection"
has "$SPEC" 'Apply this contract to new neutral specs and explicit migrations' "legacy compatibility"
has "$SPEC" 'Delete untriggered optional sections' "optional omission semantics"
has "$SPEC" 'Treat duplicated rules, unconditional profile expansion' "review checks progressive disclosure"
has "$SPEC" 'reports `Ready for planning` or `Issues Found`' "review readiness vocabulary"

has "$TRADEOFF" '**Decision Authority:**' "global decision authority"
has "$TRADEOFF" '**Decision Reference:**' "global transition evidence"
has "$TRADEOFF" 'lasting constraint also crosses the leaf boundary' "promotion boundary"
has "$TRADEOFF" 'Handle a contained deviation by amending and reapproving' "contained deviation ownership"
has "$TRADEOFF" 'scoped amendment whose outcome governs only the declared overlap' "update precedence"
has "$TRADEOFF" 'set the old status to' "supersession lifecycle"

has "$MATRIX" '| Requirement ID | Original Intent | Applicability | Current Status |' "matrix applicability"
has "$MATRIX" 'currently governing approved spec change' "scope exclusion authority"
has "$MATRIX" 'global records do not grant exclusion authority' "non-governing records cannot exclude"
has "$MATRIX" 'a bare command or test path is not evidence' "evidence pointer contract"
has "$MATRIX" 'stale/missing evidence' "stale implemented normalization"
has "$MATRIX" 'rejected leaf with no implementation evidence' "inactive leaf roll-up"
has "$MATRIX" 'one or more recorded rows, all validly `Out of Scope`' "empty scope cannot fake a roll-up"
has "$MATRIX" 'An empty matrix or missing acceptance coverage is `Issues Found`' "missing matrix coverage blocks roll-up"
has "$MATRIX" 'no implementation evidence and no active authorized execution' "zero-work roll-up excludes active work"
has "$MATRIX" 'all in-scope rows implemented with current evidence' "complete roll-up"

if [ "$failures" -gt 0 ]; then
    echo "STATUS: FAILED ($failures failures)"
    exit 1
fi

echo "STATUS: PASSED"
