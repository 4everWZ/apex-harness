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

$manifestPath = Join-Path $root '.codex-plugin\plugin.json'
$manifest = Get-Content -Raw -LiteralPath $manifestPath | ConvertFrom-Json
if ($manifest.skills -ne './skills/' -or $null -ne $manifest.hooks) {
    throw 'Codex manifest must expose only ./skills/ and no hooks.'
}

$prohibited = @('.claude-plugin', 'GEMINI.md', 'gemini-extension.json', 'hooks', 'evals', 'tests')
foreach ($relativePath in $prohibited) {
    if (Test-Path -LiteralPath (Join-Path $root $relativePath)) {
        throw "Unsupported package path exists: $relativePath"
    }
}

Write-Host 'PASS: static structure and frontmatter for two Codex skills and four templates are valid.'
