# ═══════════════════════════════════════════════════════════════════════════
# MEDINA INSTALL — INSTALLATIO SOVEREIGNA (PowerShell)
# "Unum mandatum. Totum systema." (One command. Whole system.)
#
# Self-contained PowerShell install script for Windows.
# Usage: .\install.ps1
# Or:    iwr <url>/install.ps1 | iex
#
# No GitHub dependency. No npm required (optional for SDK).
# Attribution: Alfredo Medina Hernandez | Medina Tech | Dallas, TX
# ═══════════════════════════════════════════════════════════════════════════

$ErrorActionPreference = "Stop"

# ── Constants ─────────────────────────────────────────────────────────────
$PHI = "1.618033988749895"
$VERSION = "1.0.0"
$InstallDir = if ($env:MEDINA_HOME) { $env:MEDINA_HOME } else { Join-Path $env:USERPROFILE ".medina" }
$BinDir = Join-Path $InstallDir "bin"
$ExtDir = Join-Path $InstallDir "extensions"
$SdkDir = Join-Path $InstallDir "sdk"
$CliDir = Join-Path $InstallDir "cli"
$CanisterDir = Join-Path $InstallDir "canister"

# ── Banner ────────────────────────────────────────────────────────────────
function Show-Banner {
    Write-Host ""
    Write-Host "  ╔═══════════════════════════════════════════════════════════╗" -ForegroundColor DarkYellow
    Write-Host "  ║                                                           ║" -ForegroundColor DarkYellow
    Write-Host "  ║              M E D I N A    I N S T A L L E R             ║" -ForegroundColor DarkYellow
    Write-Host "  ║                                                           ║" -ForegroundColor DarkYellow
    Write-Host "  ║        Sovereign Memory-Operating Intelligence            ║" -ForegroundColor DarkYellow
    Write-Host "  ║              v$VERSION — phi = $PHI                  ║" -ForegroundColor DarkYellow
    Write-Host "  ║                                                           ║" -ForegroundColor DarkYellow
    Write-Host "  ╚═══════════════════════════════════════════════════════════╝" -ForegroundColor DarkYellow
    Write-Host ""
}

# ── Detect source mode ───────────────────────────────────────────────────
function Get-SourceMode {
    if ((Test-Path ".\extensions") -and (Test-Path ".\cli") -and (Test-Path ".\canister")) {
        return "bundle"
    }
    elseif ((Test-Path "..\extensions") -and (Test-Path "..\organism-cli") -and (Test-Path "..\icp")) {
        return "repo"
    }
    return "standalone"
}

# ── Create directories ───────────────────────────────────────────────────
function Initialize-Dirs {
    Write-Host "  > Creating install directory: $InstallDir" -ForegroundColor Cyan
    @($BinDir, $ExtDir, $SdkDir, $CliDir, $CanisterDir) | ForEach-Object {
        New-Item -ItemType Directory -Path $_ -Force | Out-Null
    }
    Write-Host "  + Directory structure created" -ForegroundColor Green
}

# ── Install from bundle ──────────────────────────────────────────────────
function Install-FromBundle {
    Write-Host "  > Installing from extracted bundle..." -ForegroundColor Cyan

    if (Test-Path ".\extensions") {
        Copy-Item -Path ".\extensions\*" -Destination $ExtDir -Recurse -Force
        $count = (Get-ChildItem -Directory $ExtDir).Count
        Write-Host "  + Installed $count browser extensions" -ForegroundColor Green
    }
    if (Test-Path ".\cli") {
        Copy-Item -Path ".\cli\*" -Destination $CliDir -Recurse -Force
        Write-Host "  + Installed Organism CLI" -ForegroundColor Green
    }
    if (Test-Path ".\sdk") {
        Copy-Item -Path ".\sdk\*" -Destination $SdkDir -Recurse -Force
        Write-Host "  + Installed SDK packages" -ForegroundColor Green
    }
    if (Test-Path ".\canister") {
        Copy-Item -Path ".\canister\*" -Destination $CanisterDir -Recurse -Force
        Write-Host "  + Installed ICP canister sources" -ForegroundColor Green
    }
}

# ── Install from repository ──────────────────────────────────────────────
function Install-FromRepo {
    $repoRoot = Resolve-Path ".."
    Write-Host "  > Installing from repository: $repoRoot" -ForegroundColor Cyan

    if (Test-Path "$repoRoot\extensions") {
        Copy-Item -Path "$repoRoot\extensions\*" -Destination $ExtDir -Recurse -Force
        $count = (Get-ChildItem -Directory $ExtDir).Count
        Write-Host "  + Installed $count browser extensions" -ForegroundColor Green
    }
    if (Test-Path "$repoRoot\organism-cli") {
        Copy-Item -Path "$repoRoot\organism-cli\*" -Destination $CliDir -Recurse -Force
        Write-Host "  + Installed Organism CLI" -ForegroundColor Green
    }
    if (Test-Path "$repoRoot\packages") {
        Copy-Item -Path "$repoRoot\packages\*" -Destination $SdkDir -Recurse -Force
        Write-Host "  + Installed SDK packages" -ForegroundColor Green
    }
    if (Test-Path "$repoRoot\icp") {
        Copy-Item -Path "$repoRoot\icp\dfx.json" -Destination $CanisterDir -Force
        Copy-Item -Path "$repoRoot\icp\src" -Destination $CanisterDir -Recurse -Force
        Write-Host "  + Installed ICP canister sources" -ForegroundColor Green
    }
}

# ── Create launcher scripts ─────────────────────────────────────────────
function New-Launchers {
    $medinaCmd = @"
@echo off
set MEDINA_HOME=%USERPROFILE%\.medina
node "%MEDINA_HOME%\cli\src\index.js" %*
"@
    Set-Content -Path (Join-Path $BinDir "medina.cmd") -Value $medinaCmd

    $organismCmd = @"
@echo off
set MEDINA_HOME=%USERPROFILE%\.medina
node "%MEDINA_HOME%\cli\src\index.js" %*
"@
    Set-Content -Path (Join-Path $BinDir "organism.cmd") -Value $organismCmd

    Write-Host "  + Created launcher scripts: medina.cmd, organism.cmd" -ForegroundColor Green
}

# ── Configure PATH ───────────────────────────────────────────────────────
function Set-EnvPath {
    $currentPath = [Environment]::GetEnvironmentVariable("Path", "User")
    if ($currentPath -notlike "*$BinDir*") {
        [Environment]::SetEnvironmentVariable("Path", "$BinDir;$currentPath", "User")
        [Environment]::SetEnvironmentVariable("MEDINA_HOME", $InstallDir, "User")
        Write-Host "  + Added to user PATH" -ForegroundColor Green
    }
    else {
        Write-Host "  + PATH already configured" -ForegroundColor Green
    }
}

# ── Verify ───────────────────────────────────────────────────────────────
function Show-Summary {
    Write-Host ""
    Write-Host "  Installation Summary:" -ForegroundColor White
    Write-Host "    Install dir:  $InstallDir"
    $extCount = if (Test-Path $ExtDir) { (Get-ChildItem -Directory $ExtDir -ErrorAction SilentlyContinue).Count } else { 0 }
    $sdkCount = if (Test-Path $SdkDir) { (Get-ChildItem -Directory $SdkDir -ErrorAction SilentlyContinue).Count } else { 0 }
    Write-Host "    Extensions:   $extCount extensions"
    Write-Host "    CLI:          $CliDir\src\index.js"
    Write-Host "    SDK packages: $sdkCount packages"
    Write-Host "    Launchers:    $BinDir\medina.cmd"

    # Check Node.js
    try {
        $nodeVer = & node -v 2>$null
        Write-Host "  + Node.js $nodeVer available" -ForegroundColor Green
    }
    catch {
        Write-Host "  ! Node.js not found — install Node.js 18+ for CLI features" -ForegroundColor Yellow
    }
}

# ── Final ─────────────────────────────────────────────────────────────────
function Show-Complete {
    Write-Host ""
    Write-Host "  ╔═══════════════════════════════════════════════════════════╗" -ForegroundColor Green
    Write-Host "  ║                                                           ║" -ForegroundColor Green
    Write-Host "  ║           MEDINA INSTALLED SUCCESSFULLY                   ║" -ForegroundColor Green
    Write-Host "  ║                                                           ║" -ForegroundColor Green
    Write-Host "  ║  Commands:                                                ║" -ForegroundColor Green
    Write-Host "  ║    medina          — Launch sovereign AI                  ║" -ForegroundColor Green
    Write-Host "  ║    medina status   — System status                       ║" -ForegroundColor Green
    Write-Host "  ║    medina serve    — Start download server                ║" -ForegroundColor Green
    Write-Host "  ║    medina workers  — Show Alpha workers                   ║" -ForegroundColor Green
    Write-Host "  ║                                                           ║" -ForegroundColor Green
    Write-Host "  ║  Open a new terminal to use the commands.                 ║" -ForegroundColor Green
    Write-Host "  ║                                                           ║" -ForegroundColor Green
    Write-Host "  ╚═══════════════════════════════════════════════════════════╝" -ForegroundColor Green
    Write-Host ""
}

# ── Main ─────────────────────────────────────────────────────────────────
Show-Banner
$mode = Get-SourceMode
Write-Host "  > Install mode: $mode" -ForegroundColor Cyan

Initialize-Dirs

switch ($mode) {
    "bundle"     { Install-FromBundle }
    "repo"       { Install-FromRepo }
    "standalone" { Write-Host "  ! No local source found. Extract the bundle first." -ForegroundColor Yellow }
}

New-Launchers
Set-EnvPath
Show-Summary
Show-Complete
