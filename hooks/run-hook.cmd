: << 'CMDBLOCK'
@echo off
REM Windows uses the native PowerShell hook so WSL/Git-Bash path semantics cannot
REM corrupt the plugin path. Unix executes the shell section below.

if "%~1"=="" (
    echo run-hook.cmd: missing script name >&2
    exit /b 1
)

set "HOOK_DIR=%~dp0"
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%HOOK_DIR%session-start-windows.ps1" -ScriptName "%~1"
exit /b %ERRORLEVEL%
CMDBLOCK

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SCRIPT_NAME="$1"
shift
exec bash "${SCRIPT_DIR}/${SCRIPT_NAME}" "$@"
