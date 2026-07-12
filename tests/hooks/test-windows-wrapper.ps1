$ErrorActionPreference = 'Stop'
$root = (Resolve-Path (Join-Path $PSScriptRoot '..\..')).Path
$wrapper = Join-Path $root 'hooks\run-hook.cmd'

foreach ($scriptName in @('session-start', 'session-start-codex')) {
    $output = cmd.exe /d /c "`"$wrapper`" $scriptName"
    if ($LASTEXITCODE -ne 0) {
        throw "$scriptName wrapper exited $LASTEXITCODE"
    }
    $payload = ($output | Out-String) | ConvertFrom-Json
    if ($payload.hookSpecificOutput.hookEventName -ne 'SessionStart') {
        throw "$scriptName emitted the wrong event"
    }
    if ($payload.hookSpecificOutput.additionalContext -notmatch '# Using APEX') {
        throw "$scriptName omitted the APEX entry"
    }
    Write-Host "PASS: Windows wrapper $scriptName"
}
