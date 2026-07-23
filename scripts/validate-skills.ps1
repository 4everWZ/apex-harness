param(
    [string]$Python = "$PSScriptRoot\..\.venv\Scripts\python.exe",
    [string]$SkillCreatorPath = $env:SKILL_CREATOR_PATH
)

$ErrorActionPreference = 'Stop'
$root = (Resolve-Path "$PSScriptRoot\..").Path
$expectedSkills = @('governing-project-work', 'managing-project-docs')
$actualSkills = @(
    Get-ChildItem (Join-Path $root 'skills') -Directory |
        Sort-Object Name |
        ForEach-Object Name
)

if (Compare-Object $expectedSkills $actualSkills) {
    throw "Expected exactly: $($expectedSkills -join ', '); found: $($actualSkills -join ', ')"
}
if (-not (Test-Path -LiteralPath $Python)) {
    throw "Python environment not found at $Python"
}

$validator = if ($SkillCreatorPath) {
    Join-Path $SkillCreatorPath 'scripts\quick_validate.py'
} else {
    $null
}
if (-not $validator -or -not (Test-Path -LiteralPath $validator)) {
    throw 'Set SKILL_CREATOR_PATH to the official skill-creator directory.'
}

foreach ($name in $expectedSkills) {
    $skill = Join-Path $root "skills\$name"
    $skillFile = Join-Path $skill 'SKILL.md'
    $declaredName = Select-String -LiteralPath $skillFile -Pattern '^name:\s*(.+)\s*$' |
        Select-Object -First 1
    if (-not $declaredName -or $declaredName.Matches[0].Groups[1].Value.Trim() -ne $name) {
        throw "Frontmatter name must match skill directory: $name"
    }

    & $Python $validator $skill
    if ($LASTEXITCODE -ne 0) {
        throw "Skill validation failed: $name"
    }
}

foreach ($markdown in Get-ChildItem (Join-Path $root 'skills') -Recurse -File -Filter '*.md') {
    $content = Get-Content -Raw -LiteralPath $markdown.FullName
    foreach ($match in [regex]::Matches($content, '\[[^\]]+\]\(([^)]+)\)')) {
        $target = $match.Groups[1].Value
        if ($target -match '^(?:[a-z]+:|#)') {
            continue
        }
        $relativeTarget = ($target -split '#', 2)[0].Replace(
            '/',
            [IO.Path]::DirectorySeparatorChar
        )
        if (-not (Test-Path -LiteralPath (Join-Path $markdown.DirectoryName $relativeTarget))) {
            throw "Broken link in $($markdown.FullName): $target"
        }
    }
}

$documentationReferenceRoot = Join-Path $root 'skills\managing-project-docs\references'
$expectedDocumentationReferences = @(
    'decisions.md', 'specifications.md', 'topology.md', 'working-docs.md'
)
$actualDocumentationReferences = @(
    Get-ChildItem $documentationReferenceRoot -File |
        Sort-Object Name |
        ForEach-Object Name
)
if (Compare-Object $expectedDocumentationReferences $actualDocumentationReferences) {
    throw "Expected exactly these documentation references: $($expectedDocumentationReferences -join ', '); found: $($actualDocumentationReferences -join ', ')"
}

$requiredFiles = @(
    'skills\governing-project-work\references\boundary.md',
    'skills\managing-project-docs\references\decisions.md',
    'skills\managing-project-docs\references\specifications.md',
    'skills\managing-project-docs\references\topology.md',
    'skills\managing-project-docs\references\working-docs.md'
)
foreach ($relativePath in $requiredFiles) {
    $path = Join-Path $root $relativePath
    if (-not (Test-Path -LiteralPath $path) -or (Get-Item $path).Length -eq 0) {
        throw "Missing skill reference: $relativePath"
    }
}

function Assert-Headings {
    param(
        [string]$Path,
        [string[]]$Headings
    )

    $content = Get-Content -Raw -LiteralPath $Path
    foreach ($heading in $Headings) {
        $pattern = '(?m)^## ' + [regex]::Escape($heading) + '\r?$'
        if (-not [regex]::IsMatch($content, $pattern)) {
            throw "Missing heading in ${Path}: $heading"
        }
    }
}

$topologyPath = Join-Path $documentationReferenceRoot 'topology.md'
$specificationsPath = Join-Path $documentationReferenceRoot 'specifications.md'
$decisionsPath = Join-Path $documentationReferenceRoot 'decisions.md'
$workingDocsPath = Join-Path $documentationReferenceRoot 'working-docs.md'
$boundaryPath = Join-Path $root 'skills\governing-project-work\references\boundary.md'

Assert-Headings $topologyPath @(
    'Choose the owner', 'Resolve paths', 'Resolve content conflicts',
    'Preserve identity', 'Optional document index'
)
Assert-Headings $specificationsPath @(
    'Interpret status', 'Draft and synchronize', 'Reject a draft',
    'Supersede or retire'
)
Assert-Headings $decisionsPath @(
    'Promote a decision', 'Preserve path identity', 'Change status'
)
Assert-Headings $workingDocsPath @('Work plans', 'Handoffs')
Assert-Headings $boundaryPath @('Path', 'Risk', 'Authority', 'Evidence', 'Completion')

$expectedTopology = @{
    'specification' = @('durable', 'docs/specs/<topic>.md', 'assets/templates/specification.md')
    'decision record' = @('durable', 'docs/design/YYYY-MM-DD-<topic>-design.md', 'assets/templates/decision-record.md')
    'work plan' = @('working', 'docs/plans/<topic>.md', 'assets/templates/work-plan.md')
    'handoff' = @('transient', 'docs/handoffs/<topic>.md', 'assets/templates/handoff.md')
}
$foundTopology = @{}
foreach ($line in Get-Content -LiteralPath $topologyPath) {
    if ($line -notmatch '^\|') {
        continue
    }
    $cells = @(
        $line.Trim([char]'|').Split([char]'|') |
            ForEach-Object { $_.Trim().Trim([char]'`') }
    )
    if ($cells.Count -lt 4 -or -not $expectedTopology.ContainsKey($cells[0])) {
        continue
    }
    $expected = $expectedTopology[$cells[0]]
    $actual = @($cells[1], $cells[2], $cells[3])
    if (Compare-Object $expected $actual -SyncWindow 0) {
        throw "Changed topology mapping for $($cells[0])"
    }
    $foundTopology[$cells[0]] = $true
}
if (Compare-Object @($expectedTopology.Keys | Sort-Object) @($foundTopology.Keys | Sort-Object)) {
    throw 'Missing documentation topology mapping.'
}

$specifications = Get-Content -Raw -LiteralPath $specificationsPath
$boundary = Get-Content -Raw -LiteralPath $boundaryPath
if (-not $specifications.Contains('docs/specs/legacy/<topic>-NN.md')) {
    throw 'Missing retained-specification fallback path.'
}
if (-not $boundary.Contains('docs/plans/<topic>-boundary.md')) {
    throw 'Missing project-boundary fallback path.'
}

$templateRoot = Join-Path $root 'skills\managing-project-docs\assets\templates'
$expectedTemplates = @(
    'decision-record.md', 'handoff.md', 'specification.md', 'work-plan.md'
)
$actualTemplates = @(
    Get-ChildItem $templateRoot -File |
        Sort-Object Name |
        ForEach-Object Name
)
if (Compare-Object $expectedTemplates $actualTemplates) {
    throw "Expected exactly these templates: $($expectedTemplates -join ', '); found: $($actualTemplates -join ', ')"
}
foreach ($name in $expectedTemplates) {
    $path = Join-Path $templateRoot $name
    if ((Get-Item $path).Length -eq 0) {
        throw "Empty documentation template: $name"
    }
}

function Get-StatusNames {
    param([string]$Path)

    $statusLine = Select-String -LiteralPath $Path -Pattern '^-\s+\*\*Status:\*\*\s*(.+)$' |
        Select-Object -First 1
    if (-not $statusLine) {
        throw "Missing status field: $Path"
    }
    @(
        $statusLine.Matches[0].Groups[1].Value.Split([char]'|') |
            ForEach-Object { (($_.Trim()) -split '\s+', 2)[0] } |
            Sort-Object
    )
}

$specificationStatuses = Get-StatusNames (Join-Path $templateRoot 'specification.md')
if (Compare-Object @('active', 'draft', 'superseded') $specificationStatuses) {
    throw 'Specification template has invalid status values.'
}
$decisionStatuses = Get-StatusNames (Join-Path $templateRoot 'decision-record.md')
if (Compare-Object @('active', 'proposed', 'rejected', 'superseded') $decisionStatuses) {
    throw 'Decision template has invalid status values.'
}

$manifestPath = Join-Path $root '.codex-plugin\plugin.json'
$manifest = Get-Content -Raw -LiteralPath $manifestPath | ConvertFrom-Json
if ($manifest.skills -ne './skills/' -or $null -ne $manifest.hooks) {
    throw 'Codex manifest must expose ./skills/ and must not configure hooks.'
}

$prohibited = @(
    '.app.json', '.claude-plugin', '.mcp.json', 'GEMINI.md',
    'gemini-extension.json', 'hooks'
)
foreach ($relativePath in $prohibited) {
    if (Test-Path -LiteralPath (Join-Path $root $relativePath)) {
        throw "Unsupported package path exists: $relativePath"
    }
}

Write-Host 'PASS: skill structure, skill-local links, topology mappings, references, templates, status values, and manifest are valid.'
