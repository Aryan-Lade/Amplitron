# ============================================================
# Amplitron - Auto-Install Dependencies (requires admin & choco)
# ============================================================
# This script uses Chocolatey to automatically install build tools
# Usage: powershell -ExecutionPolicy Bypass -File install_dependencies_choco.ps1

#Requires -RunAsAdministrator

Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "  Amplitron - Auto-Install Build Dependencies" -ForegroundColor Cyan
Write-Host "  (Using Chocolatey)" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""

# Check if Chocolatey is installed
Write-Host "Checking for Chocolatey..." -ForegroundColor Yellow
$choco = Get-Command choco -ErrorAction SilentlyContinue

if (-not $choco) {
    Write-Host "❌ Chocolatey not found!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Installing Chocolatey..." -ForegroundColor Yellow
    
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ Failed to install Chocolatey" -ForegroundColor Red
        exit 1
    }
    
    Write-Host "✓ Chocolatey installed" -ForegroundColor Green
    $env:PATH = "$env:PROGRAMDATA\chocolatey\bin;" + $env:PATH
} else {
    Write-Host "✓ Chocolatey found at: $($choco.Source)" -ForegroundColor Green
}

Write-Host ""
Write-Host "Installing build tools..." -ForegroundColor Yellow
Write-Host ""

# Install CMake
Write-Host "  → Installing CMake..." -ForegroundColor Cyan
choco install cmake -y --force
if ($LASTEXITCODE -ne 0) {
    Write-Host "    ⚠ CMake installation had issues, but continuing..." -ForegroundColor Yellow
}
$env:PATH = "C:\Program Files\CMake\bin;" + $env:PATH

# Install Visual Studio 2022 Community (C++ development)
Write-Host "  → Installing Visual Studio 2022 Community (with C++ tools)..." -ForegroundColor Cyan
Write-Host "    (This may take 5-15 minutes)" -ForegroundColor Gray
choco install visualstudio2022community -y `
    --package-parameters="--add Microsoft.VisualStudio.Workload.NativeDesktop"
if ($LASTEXITCODE -ne 0) {
    Write-Host "    ⚠ VS 2022 installation had issues, trying VS 2019..." -ForegroundColor Yellow
    choco install visualstudio2019community -y `
        --package-parameters="--add Microsoft.VisualStudio.Workload.NativeDesktop"
}

# Install dependencies
Write-Host "  → Installing PortAudio..." -ForegroundColor Cyan
choco install portaudio -y

Write-Host "  → Installing SDL2..." -ForegroundColor Cyan
choco install libsdl2 -y

Write-Host "  → Installing Git (if needed)..." -ForegroundColor Cyan
choco install git -y

Write-Host ""
Write-Host "============================================================" -ForegroundColor Green
Write-Host "  Installation Complete!" -ForegroundColor Green
Write-Host "============================================================" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "  1. Close and reopen PowerShell for PATH changes to take effect" -ForegroundColor White
Write-Host "  2. Run the build script:" -ForegroundColor White
Write-Host "     powershell -ExecutionPolicy Bypass `\" -ForegroundColor Gray
Write-Host "       -File setup_and_build_windows.ps1" -ForegroundColor Gray
Write-Host ""

# Optionally run the build now
$response = Read-Host "Build now? (y/n)"
if ($response -eq "y") {
    & ".\setup_and_build_windows.ps1"
}
