param(
    [Parameter(Mandatory = $true)]
    [ValidateSet('session-start', 'session-start-codex')]
    [string]$ScriptName
)

$ErrorActionPreference = 'Stop'
$pluginRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$entryPath = Join-Path $pluginRoot 'skills\using-apex\SKILL.md'
$content = Get-Content -Raw -LiteralPath $entryPath

$loader = if ($ScriptName -eq 'session-start-codex') {
    'Follow the Codex skill-loading instructions for applicable leaf skills.'
} else {
    'Use the Skill tool for applicable leaf skills.'
}

$context = @"
<EXTREMELY_IMPORTANT>
APEX governs this skill collection.

**Below is the full content of the 'using-apex' entry skill. It is already loaded. $loader**

$content
</EXTREMELY_IMPORTANT>
"@

[ordered]@{
    hookSpecificOutput = [ordered]@{
        hookEventName = 'SessionStart'
        additionalContext = $context
    }
} | ConvertTo-Json -Depth 4 -Compress
