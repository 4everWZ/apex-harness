param(
    [string]$Python = "$PSScriptRoot\..\.venv\Scripts\python.exe",
    [string]$SkillCreatorPath = $env:SKILL_CREATOR_PATH
)

$ErrorActionPreference = 'Stop'
$root = (Resolve-Path "$PSScriptRoot\..").Path

function Assert-NonEmptyFile {
    param([string]$Path)

    if (-not (Test-Path -LiteralPath $Path -PathType Leaf) -or
        (Get-Item -LiteralPath $Path).Length -eq 0) {
        throw "Missing or empty file: $Path"
    }
}

function Get-TrackedMarkdownFiles {
    $relativePaths = @(& git -C $root ls-files -- '*.md')
    if ($LASTEXITCODE -ne 0) {
        throw 'Unable to enumerate tracked Markdown files with Git.'
    }
    @(
        $relativePaths |
            Where-Object { $_ } |
            ForEach-Object { Join-Path $root ($_ -replace '/', '\') }
    )
}

function Assert-RelativeMarkdownLinks {
    $linkPattern = '\[[^\]]*\]\((?<target><[^>]+>|[^)\s]+)(?:\s+["''][^)]*)?\)'

    foreach ($path in Get-TrackedMarkdownFiles) {
        $content = [string](Get-Content -Raw -LiteralPath $path)
        foreach ($match in [regex]::Matches($content, $linkPattern)) {
            $target = $match.Groups['target'].Value.Trim('<>')
            if (-not $target -or $target.StartsWith('#') -or
                $target -match '^(?:[A-Za-z][A-Za-z0-9+.-]*:|//)') {
                continue
            }

            $target = $target.Split('#', 2)[0]
            if (-not $target) {
                continue
            }

            try {
                $target = [Uri]::UnescapeDataString($target)
                $base = Split-Path -Parent $path
                $resolved = [IO.Path]::GetFullPath((Join-Path $base $target))
            } catch {
                throw "Invalid relative Markdown link in ${path}: $target"
            }

            if (-not (Test-Path -LiteralPath $resolved -PathType Leaf)) {
                throw "Broken relative Markdown link in ${path}: $target"
            }
        }
    }
}

if (-not (Test-Path -LiteralPath $Python -PathType Leaf)) {
    throw "Python environment not found at $Python"
}

$officialValidator = if ($SkillCreatorPath) {
    Join-Path $SkillCreatorPath 'scripts\quick_validate.py'
} else {
    $null
}
if (-not $officialValidator -or -not (Test-Path -LiteralPath $officialValidator -PathType Leaf)) {
    throw 'Set SKILL_CREATOR_PATH to the official skill-creator directory.'
}

$skillsRoot = Join-Path $root 'skills'
$skillDirs = @(
    Get-ChildItem -LiteralPath $skillsRoot -Directory |
        Sort-Object Name
)
if ($skillDirs.Count -eq 0) {
    throw 'No skill directories found.'
}

foreach ($skillDir in $skillDirs) {
    $skillPath = Join-Path $skillDir.FullName 'SKILL.md'
    Assert-NonEmptyFile $skillPath

    $declaredName = Select-String -LiteralPath $skillPath `
        -Pattern '^name:\s*(.+)\s*$' -CaseSensitive | Select-Object -First 1
    if (-not $declaredName -or
        $declaredName.Matches[0].Groups[1].Value.Trim() -cne $skillDir.Name) {
        throw "Frontmatter name must match skill directory: $($skillDir.Name)"
    }

    & $Python $officialValidator $skillDir.FullName
    if ($LASTEXITCODE -ne 0) {
        throw "Official skill validation failed: $($skillDir.Name)"
    }
}

Assert-RelativeMarkdownLinks

$templateRoot = Join-Path $root 'skills\managing-project-docs\assets\templates'
if (-not (Test-Path -LiteralPath $templateRoot -PathType Container)) {
    throw "Missing template directory: $templateRoot"
}
$templateFiles = @(
    Get-ChildItem -LiteralPath $templateRoot -File |
        Sort-Object Name
)
if ($templateFiles.Count -eq 0) {
    throw 'Template directory is empty.'
}
foreach ($templateFile in $templateFiles) {
    Assert-NonEmptyFile $templateFile.FullName
}

$manifestPath = Join-Path $root '.codex-plugin\plugin.json'
Assert-NonEmptyFile $manifestPath
try {
    $manifest = Get-Content -Raw -LiteralPath $manifestPath | ConvertFrom-Json
} catch {
    throw "Invalid plugin manifest JSON: $manifestPath"
}
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

Write-Host 'PASS: official skill validation and package structure contracts are valid.'
