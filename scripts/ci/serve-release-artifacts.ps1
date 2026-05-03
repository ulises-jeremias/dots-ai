# Serve a directory over HTTP on 127.0.0.1 for hermetic Windows CI jobs.
# Mirrors scripts/ci/serve-release-artifacts.sh. Loopback only.
#
# Usage:
#   pwsh -File scripts/ci/serve-release-artifacts.ps1 -Path dist -Port 8123
#
# Writes the server PID to <Path>\.http-server.pid so the caller can stop it.

[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)][string]$Path,
    [Parameter(Mandatory = $true)][int]$Port
)

$ErrorActionPreference = 'Stop'

if (-not (Test-Path $Path -PathType Container)) {
    Write-Error "serve-release-artifacts: not a directory: $Path"
    exit 1
}

# Prefer python3 (preinstalled on windows-latest) for parity with bash variant.
$python = Get-Command python3 -ErrorAction SilentlyContinue
if (-not $python) {
    $python = Get-Command python -ErrorAction SilentlyContinue
}
if (-not $python) {
    Write-Error "serve-release-artifacts: python3 / python is required"
    exit 1
}

$absPath = (Resolve-Path $Path).Path
$logPath = Join-Path $absPath "server.log"
$pidPath = Join-Path $absPath ".http-server.pid"

$proc = Start-Process -FilePath $python.Path `
    -ArgumentList @("-m", "http.server", "$Port", "--bind", "127.0.0.1") `
    -WorkingDirectory $absPath `
    -RedirectStandardOutput $logPath `
    -RedirectStandardError "$logPath.err" `
    -PassThru -WindowStyle Hidden

$proc.Id | Out-File -FilePath $pidPath -Encoding ascii -Force

# Wait until the server accepts connections (max ~10s).
$ready = $false
for ($i = 0; $i -lt 50; $i++) {
    try {
        Invoke-WebRequest -Uri "http://127.0.0.1:$Port/" -UseBasicParsing -TimeoutSec 2 | Out-Null
        $ready = $true
        break
    } catch {
        Start-Sleep -Milliseconds 200
    }
}

if (-not $ready) {
    Write-Error "serve-release-artifacts: server did not become ready on port $Port"
    if (Test-Path $logPath) { Get-Content $logPath | Write-Host }
    exit 1
}

Write-Host "serve-release-artifacts: ready on http://127.0.0.1:$Port (pid $($proc.Id))"
