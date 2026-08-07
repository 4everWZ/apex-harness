param(
    [string]$Python = "$PSScriptRoot\..\.venv\Scripts\python.exe",
    [string]$SkillCreatorPath = $env:SKILL_CREATOR_PATH
)

$ErrorActionPreference = 'Stop'
$root = (Resolve-Path "$PSScriptRoot\..").Path

function Assert-ExactSet {
    param(
        [string[]]$Expected,
        [string[]]$Actual,
        [string]$Label
    )

    if (Compare-Object $Expected $Actual -CaseSensitive) {
        throw "Changed ${Label}. Expected: $($Expected -join ', '); found: $($Actual -join ', ')"
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
        if ([regex]::Matches($content, $pattern).Count -ne 1) {
            throw "Expected exactly one heading in ${Path}: $heading"
        }
    }
}

function Assert-ExactLine {
    param(
        [string]$Path,
        [string]$Line
    )

    $matches = @(Get-Content -LiteralPath $Path | Where-Object { $_ -ceq $Line })
    if ($matches.Count -ne 1) {
        throw "Expected exactly one line in ${Path}: $Line"
    }
}

function Assert-ProhibitedPrefix {
    param(
        [string]$Path,
        [string[]]$Prefixes
    )

    foreach ($line in Get-Content -LiteralPath $Path) {
        $normalized = $line.TrimStart()
        foreach ($prefix in $Prefixes) {
            if ($normalized.StartsWith($prefix, [StringComparison]::Ordinal)) {
                throw "Prohibited field in ${Path}: $prefix"
            }
        }
    }
}

$expectedSkills = @('apex-harness', 'managing-project-docs')
$actualSkills = @(
    Get-ChildItem (Join-Path $root 'skills') -Directory |
        Sort-Object Name |
        ForEach-Object Name
)
Assert-ExactSet $expectedSkills $actualSkills 'skill set'

if (-not (Test-Path -LiteralPath $Python)) {
    throw "Python environment not found at $Python"
}
$officialValidator = if ($SkillCreatorPath) {
    Join-Path $SkillCreatorPath 'scripts\quick_validate.py'
} else {
    $null
}
if (-not $officialValidator -or -not (Test-Path -LiteralPath $officialValidator)) {
    throw 'Set SKILL_CREATOR_PATH to the official skill-creator directory.'
}

foreach ($name in $expectedSkills) {
    $skill = Join-Path $root "skills\$name"
    $declaredName = Select-String -LiteralPath (Join-Path $skill 'SKILL.md') `
        -Pattern '^name:\s*(.+)\s*$' -CaseSensitive | Select-Object -First 1
    if (-not $declaredName -or
        $declaredName.Matches[0].Groups[1].Value.Trim() -cne $name) {
        throw "Frontmatter name must match skill directory: $name"
    }
    & $Python $officialValidator $skill
    if ($LASTEXITCODE -ne 0) {
        throw "Official skill validation failed: $name"
    }
}

$documentationReferenceRoot = Join-Path $root 'skills\managing-project-docs\references'
$harnessReferenceRoot = Join-Path $root 'skills\apex-harness\references'
$expectedHarnessReferences = @(
    'research-ml.md', 'verification.md', 'workflow.md'
)
$actualHarnessReferences = @(
    Get-ChildItem $harnessReferenceRoot -File |
        Sort-Object Name |
        ForEach-Object Name
)
Assert-ExactSet $expectedHarnessReferences $actualHarnessReferences 'harness reference set'

$expectedReferences = @(
    'decisions.md', 'specifications.md', 'topology.md', 'working-docs.md'
)
$actualReferences = @(
    Get-ChildItem $documentationReferenceRoot -File |
        Sort-Object Name |
        ForEach-Object Name
)
Assert-ExactSet $expectedReferences $actualReferences 'documentation reference set'

$workflowPath = Join-Path $harnessReferenceRoot 'workflow.md'
$verificationPath = Join-Path $harnessReferenceRoot 'verification.md'
$researchMlPath = Join-Path $harnessReferenceRoot 'research-ml.md'
$decisionsPath = Join-Path $documentationReferenceRoot 'decisions.md'
$specificationsPath = Join-Path $documentationReferenceRoot 'specifications.md'
$topologyPath = Join-Path $documentationReferenceRoot 'topology.md'
$workingDocsPath = Join-Path $documentationReferenceRoot 'working-docs.md'
$requiredFiles = @(
    $workflowPath, $verificationPath, $researchMlPath, $decisionsPath,
    $specificationsPath, $topologyPath, $workingDocsPath
)
foreach ($path in $requiredFiles) {
    if (-not (Test-Path -LiteralPath $path -PathType Leaf) -or
        (Get-Item -LiteralPath $path).Length -eq 0) {
        throw "Missing or empty skill reference: $path"
    }
}

Assert-Headings $topologyPath @(
    'Choose the artifact', 'Resolve paths', 'Choose specification boundaries',
    'Resolve content conflicts', 'Preserve identity', 'Keep references sparse',
    'Consolidate an over-split set', 'Retire or delete an artifact',
    'Optional document index'
)
Assert-Headings $specificationsPath @(
    'Select the contract boundary', 'Interpret status', 'Draft and synchronize',
    'Reject a draft', 'Supersede or retire'
)
Assert-Headings $decisionsPath @(
    'Promote a decision', 'Preserve path identity', 'Change status'
)
Assert-Headings $workingDocsPath @(
    'Decide whether a working document is needed', 'Work plans', 'Handoffs'
)
Assert-Headings $workflowPath @(
    'Classify by semantic consequence', 'Consultation boundary',
    'Completion claims', 'Persisted execution boundary', 'Execution loop'
)
Assert-Headings $verificationPath @(
    'Choose evidence', 'Verification cycle', 'TDD is a technique', 'Stop'
)
Assert-Headings $researchMlPath @(
    'Preserve experiment meaning', 'Check the real experimental boundaries',
    'Keep claims proportional to evidence'
)

$topologyLines = @(
    '| Artifact | Lifecycle | Create only when | Fallback path | Authoritative for |',
    '|---|---|---|---|---|',
    '| specification | durable | a stable contract meets the specification boundary rule below | `docs/specs/<topic>.md` | current behavior, interfaces, invariants, and acceptance |',
    '| decision record | durable | a material choice or proposal needs independent acceptance or durable rationale | `docs/design/YYYY-MM-DD-<topic>-design.md` | the choice, tradeoff, and rationale |',
    '| work plan | working | unfinished work must remain coordinated or resumable | `docs/plans/<topic>.md` | ordered execution and unresolved work |',
    '| handoff | transient | responsibility is actually transferring | `docs/handoffs/<topic>.md` | the current state of that transfer |'
)
foreach ($line in $topologyLines) {
    Assert-ExactLine $topologyPath $line
}

$specifications = Get-Content -Raw -LiteralPath $specificationsPath
$workflow = Get-Content -Raw -LiteralPath $workflowPath
if (-not $specifications.Contains('docs/specs/legacy/<topic>-NN.md')) {
    throw 'Missing retained-specification fallback path.'
}
if (-not $workflow.Contains('docs/plans/<topic>-boundary.md')) {
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
Assert-ExactSet $expectedTemplates $actualTemplates 'template set'

$specificationTemplate = Join-Path $templateRoot 'specification.md'
$decisionTemplate = Join-Path $templateRoot 'decision-record.md'
$workPlanTemplate = Join-Path $templateRoot 'work-plan.md'
$handoffTemplate = Join-Path $templateRoot 'handoff.md'

Assert-ExactLine $specificationTemplate '## Governing decisions — optional'
Assert-ExactLine $specificationTemplate '- **Superseded by:** [retained predecessor only; omit otherwise]'
Assert-ExactLine $decisionTemplate '- **Superseded by:** [retained predecessor only; omit otherwise]'
Assert-ExactLine $workPlanTemplate '- **Primary contracts:** [minimum direct links when they exist]'
Assert-ExactLine $workPlanTemplate '- **Project boundary:** [link only when persisted]'
Assert-ExactLine $handoffTemplate '## Primary working artifact'
Assert-ExactLine $handoffTemplate '- Active work plan:'
Assert-ExactLine $handoffTemplate '- Project boundary: [only when no active work plan exists and one is persisted]'

Assert-ProhibitedPrefix $specificationTemplate @('- **Supersedes:**', '- **Project boundary:**')
Assert-ProhibitedPrefix $decisionTemplate @(
    '- **Supersedes:**', '- **Affected contract:**', '- **Affected artifacts:**',
    '- **Project boundary:**'
)
Assert-ProhibitedPrefix $workPlanTemplate @('- **Related decisions:**', '- **Active work plan:**')
Assert-ProhibitedPrefix $handoffTemplate @('- Specification:', '- Decision:')

function Get-StatusNames {
    param([string]$Path)

    $lines = @(
        Select-String -LiteralPath $Path `
            -Pattern '^-\s+\*\*Status:\*\*\s*(.+)$' -CaseSensitive
    )
    if ($lines.Count -ne 1) {
        throw "Expected exactly one status field: $Path"
    }
    $statuses = @(
        $lines[0].Matches[0].Groups[1].Value.Split([char]'|') |
            ForEach-Object { $_.Trim() }
    )
    if ($statuses -ccontains '' -or
        @($statuses | Sort-Object -Unique -CaseSensitive).Count -ne $statuses.Count) {
        throw "Invalid status options: $Path"
    }
    @($statuses | Sort-Object -CaseSensitive)
}

Assert-ExactSet @('active', 'draft', 'superseded') `
    (Get-StatusNames $specificationTemplate) 'specification statuses'
Assert-ExactSet @('active', 'proposed', 'rejected', 'superseded') `
    (Get-StatusNames $decisionTemplate) 'decision statuses'

$manifestPath = Join-Path $root '.codex-plugin\plugin.json'
$manifest = Get-Content -Raw -LiteralPath $manifestPath | ConvertFrom-Json
$manifestKeys = @($manifest.PSObject.Properties.Name)
if ($manifestKeys -cnotcontains 'skills' -or
    @($manifestKeys | Where-Object { $_ -ieq 'hooks' }).Count -ne 0 -or
    $manifest.skills -isnot [string] -or $manifest.skills -cne './skills/') {
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

Write-Host 'PASS: official skill validation and repository structure contracts are valid.'
