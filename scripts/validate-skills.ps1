param(
    [string]$Python = "$PSScriptRoot\..\.venv\Scripts\python.exe",
    [string]$SkillCreatorPath = $env:SKILL_CREATOR_PATH
)

$ErrorActionPreference = 'Stop'
$root = (Resolve-Path "$PSScriptRoot\..").Path

if (-not (Test-Path -LiteralPath $Python)) {
    throw "Python environment not found at $Python. Create .venv and install requirements-skill-validation.txt."
}

$validator = if ($SkillCreatorPath) { Join-Path $SkillCreatorPath 'scripts\quick_validate.py' } else { $null }
if (-not $validator -or -not (Test-Path -LiteralPath $validator)) {
    throw 'Set SKILL_CREATOR_PATH to the installed official skill-creator directory.'
}

$failed = @()
Get-ChildItem (Join-Path $root 'skills') -Directory | Where-Object {
    Test-Path -LiteralPath (Join-Path $_.FullName 'SKILL.md')
} | ForEach-Object {
    Write-Host "=== $($_.Name) ==="
    & $Python $validator $_.FullName
    if ($LASTEXITCODE -ne 0) { $failed += $_.Name }
}

if ($failed.Count) {
    throw "Skill validation failed: $($failed -join ', ')"
}
