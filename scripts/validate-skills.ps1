param(
    [string]$Python = "$PSScriptRoot\..\.venv\Scripts\python.exe",
    [string]$SkillCreatorPath = $env:SKILL_CREATOR_PATH
)

$ErrorActionPreference = 'Stop'
$root = (Resolve-Path "$PSScriptRoot\..").Path
$expected = @('governing-project-work', 'managing-project-docs')
$actual = @(Get-ChildItem (Join-Path $root 'skills') -Directory | Sort-Object Name | ForEach-Object Name)

if (Compare-Object $expected $actual) {
    throw "Expected exactly: $($expected -join ', '); found: $($actual -join ', ')"
}
if (-not (Test-Path -LiteralPath $Python)) {
    throw "Python environment not found at $Python"
}

$validator = if ($SkillCreatorPath) { Join-Path $SkillCreatorPath 'scripts\quick_validate.py' } else { $null }
if (-not $validator -or -not (Test-Path -LiteralPath $validator)) {
    throw 'Set SKILL_CREATOR_PATH to the official skill-creator directory.'
}

foreach ($name in $expected) {
    $skill = Join-Path $root "skills\$name"
    $skillFile = Join-Path $skill 'SKILL.md'
    $declaredName = Select-String -LiteralPath $skillFile -Pattern '^name:\s*(.+)\s*$' |
        Select-Object -First 1
    if (-not $declaredName -or $declaredName.Matches[0].Groups[1].Value.Trim() -ne $name) {
        throw "Frontmatter name must match skill directory: $name"
    }
    & $Python $validator $skill
    if ($LASTEXITCODE -ne 0) { throw "Skill validation failed: $name" }

    $content = Get-Content -Raw -LiteralPath $skillFile
    foreach ($match in [regex]::Matches($content, '\[[^\]]+\]\(([^)]+)\)')) {
        $target = $match.Groups[1].Value
        if ($target -match '^(?:[a-z]+:|#)') { continue }
        $relativeTarget = ($target -split '#', 2)[0].Replace('/', [IO.Path]::DirectorySeparatorChar)
        if (-not (Test-Path -LiteralPath (Join-Path $skill $relativeTarget))) {
            throw "Broken SKILL.md link in ${name}: $target"
        }
    }
}

$references = @(
    'skills\governing-project-work\references\boundary.md',
    'skills\managing-project-docs\references\documentation.md'
)
foreach ($relativePath in $references) {
    $path = Join-Path $root $relativePath
    if (-not (Test-Path -LiteralPath $path) -or (Get-Item $path).Length -eq 0) {
        throw "Missing skill reference: $relativePath"
    }
}

$topologyPath = Join-Path $root 'skills\managing-project-docs\references\documentation.md'
$topology = Get-Content -Raw -LiteralPath $topologyPath
$readme = Get-Content -Raw -LiteralPath (Join-Path $root 'README.md')
$requiredTopologyRows = @(
    '| specification | durable | `docs/specs/<topic>.md` | `assets/templates/specification.md` |',
    '| decision record | durable | `docs/design/YYYY-MM-DD-<topic>-design.md` | `assets/templates/decision-record.md` |',
    '| work plan | working | `docs/plans/<topic>.md` | `assets/templates/work-plan.md` |',
    '| handoff | transient | `docs/handoffs/<topic>.md` | `assets/templates/handoff.md` |'
)
foreach ($row in $requiredTopologyRows) {
    if (-not $topology.Contains($row)) {
        throw "Missing or changed documentation topology row: $row"
    }
}

$pathPrecedence = @(
    '1. an explicit user-selected path',
    "2. the repository's established convention for that artifact type",
    '3. an explicit convention in the accepted project documentation',
    '4. the fallback path in the topology table'
)
$previousIndex = -1
foreach ($clause in $pathPrecedence) {
    $index = $topology.IndexOf($clause, [StringComparison]::Ordinal)
    if ($index -le $previousIndex) {
        throw "Missing or reordered path-precedence clause: $clause"
    }
    $previousIndex = $index
}

$requiredSupportingPaths = @('docs/specs/legacy/<topic>-NN.md')
foreach ($requiredPath in $requiredSupportingPaths) {
    if (-not $topology.Contains($requiredPath)) {
        throw "Missing supporting documentation path: $requiredPath"
    }
}

$requiredSynchronizationClauses = @(
    'specification owns a proposed contract in its change context',
    'Its presence in the implementation does not establish',
    'write the draft at its canonical',
    'whose integration baseline retains the active version',
    'do not normalize it by rewriting the specification unless the changed',
    'Apply an accepted contract',
    'Activate a specification only after its open decisions are resolved',
    'Do not treat documentation synchronization as complete'
)
foreach ($clause in $requiredSynchronizationClauses) {
    if (-not $topology.Contains($clause)) {
        throw "Missing specification-synchronization rule: $clause"
    }
}
if (-not $topology.Contains('decision record was first established,') -or
    -not $topology.Contains('Keep that path when the record becomes')) {
    throw 'Decision-record proposal and activation dates must preserve one stable path.'
}
if (-not $topology.Contains('When a specification draft is rejected or abandoned:') -or
    -not $topology.Contains('the last active') -or
    -not $topology.Contains('materialize the predecessor from the integration baseline or Git')) {
    throw 'Specification draft rejection and predecessor retention must be explicit.'
}
if (-not $topology.Contains('An explicit proposal path is temporary and noncanonical') -or
    -not $topology.Contains('Do not leave both copies active.')) {
    throw 'Accepted specification proposals must converge on one canonical active artifact.'
}
if (-not $topology.Contains("contract retires without a successor") -or
    -not $topology.Contains('leave a retired contract marked active')) {
    throw 'Successorless specification retirement must have a terminal transition.'
}
if (-not $topology.Contains('Before deleting a handoff for a completed or abandoned transfer')) {
    throw 'Handoff cleanup must transfer still-current facts before deletion.'
}
if (-not $topology.Contains('When not retaining a') -or
    -not $topology.Contains('clear the successor''s `Supersedes` field')) {
    throw 'Non-retained specification predecessors must not leave invalid lineage.'
}
if (-not $readme.Contains('only when the choice needs an independent') -or
    -not $readme.Contains('owner, lifecycle, or audience')) {
    throw 'README must preserve the qualified decision-record promotion boundary.'
}

$boundaryPath = Join-Path $root 'skills\governing-project-work\references\boundary.md'
$boundary = Get-Content -Raw -LiteralPath $boundaryPath
if (-not $boundary.Contains('docs/plans/<topic>-boundary.md')) {
    throw 'Missing governance boundary fallback path: docs/plans/<topic>-boundary.md'
}
if (-not $boundary.Contains('not by itself satisfy evidence freshness for a current claim')) {
    throw 'Audit-copy semantics must distinguish retention from current evidence freshness.'
}
if (-not $boundary.Contains('When an active boundary must move to a newly resolved path') -or
    -not $boundary.Contains('the only canonical working record before deleting the old copy')) {
    throw 'Persistent boundary relocation must converge on one canonical record.'
}
if (-not $boundary.Contains('after a material scope, authority, or claim-relevant input change')) {
    throw 'Persistent boundaries must be refreshed after material change.'
}

$templates = @(
    'decision-record.md', 'handoff.md', 'specification.md', 'work-plan.md'
)
$templateRoot = Join-Path $root 'skills\managing-project-docs\assets\templates'
$actualTemplates = @(Get-ChildItem $templateRoot -File | Sort-Object Name | ForEach-Object Name)
if (Compare-Object $templates $actualTemplates) {
    throw "Expected exactly these templates: $($templates -join ', '); found: $($actualTemplates -join ', ')"
}
foreach ($name in $templates) {
    $path = Join-Path $templateRoot $name
    if (-not (Test-Path -LiteralPath $path) -or (Get-Item $path).Length -eq 0) {
        throw "Missing documentation template: $name"
    }
}
$specificationTemplate = Get-Content -Raw -LiteralPath (Join-Path $templateRoot 'specification.md')
if (-not $specificationTemplate.Contains('draft (proposed) | active (accepted and verified) | superseded')) {
    throw 'Specification template must distinguish proposed and accepted status.'
}
if (-not $specificationTemplate.Contains('Stable evidence reference — optional')) {
    throw 'Specification template must support a stable acceptance-evidence reference.'
}
$decisionTemplate = Get-Content -Raw -LiteralPath (Join-Path $templateRoot 'decision-record.md')
if (-not $decisionTemplate.Contains('Proposed or selected direction, its disposition')) {
    throw 'Decision template must describe proposed, active, and rejected directions coherently.'
}

$manifestPath = Join-Path $root '.codex-plugin\plugin.json'
$manifest = Get-Content -Raw -LiteralPath $manifestPath | ConvertFrom-Json
if ($manifest.skills -ne './skills/' -or $null -ne $manifest.hooks) {
    throw 'Codex manifest must expose ./skills/ and must not configure hooks.'
}

$prohibited = @(
    '.app.json', '.claude-plugin', '.mcp.json', 'GEMINI.md',
    'gemini-extension.json', 'hooks', 'evals', 'tests'
)
foreach ($relativePath in $prohibited) {
    if (Test-Path -LiteralPath (Join-Path $root $relativePath)) {
        throw "Unsupported package path exists: $relativePath"
    }
}

Write-Host 'PASS: skill frontmatter is valid; required references, topology mappings, supporting paths, and templates are present; SKILL.md links resolve.'
