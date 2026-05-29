#!/usr/bin/env bash
# ============================================================
# Amplitron - Master Setup Script for Windows
# ============================================================
# This script provides all setup and build options
# Run with: powershell -File amplitron_setup.ps1

param(
    [ValidateSet("auto", "check", "install", "build", "full")]
    [string]$Action = "auto"
)

$ErrorActionPreference = "Continue"

Write-Host ""
Write-Host "╔════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║  AMPLITRON - Guitar Amp Simulator - Windows Setup          ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

function Show-Menu {
    Write-Host "What would you like to do?" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "  1. Check environment" -ForegroundColor Cyan
    Write-Host "  2. Install dependencies" -ForegroundColor Cyan
    Write-Host "  3. Build project" -ForegroundColor Cyan
    Write-Host "  4. Full setup + build" -ForegroundColor Cyan
    Write-Host "  5. View documentation" -ForegroundColor Cyan
    Write-Host "  6. Exit" -ForegroundColor Cyan
    Write-Host ""
}

function Check-Environment {
    Write-Host "═══ Environment Check ═══" -ForegroundColor Yellow
    Write-Host ""
    
    $checks = @()
    
    # CMake
    $cmake = Get-Command cmake -ErrorAction SilentlyContinue
    if ($cmake) {
        $version = & cmake --version 2>$null | Select-Object -First 1
        Write-Host "✓ CMake: $version" -ForegroundColor Green
        $checks += "cmake"
    } else {
        Write-Host "✗ CMake: Not found" -ForegroundColor Red
    }
    
    # Visual Studio
    if (Test-Path "C:\Program Files\Microsoft Visual Studio\2022\Community" -ErrorAction SilentlyContinue) {
        Write-Host "✓ Visual Studio 2022: Found" -ForegroundColor Green
        $checks += "vs"
    } elseif (Test-Path "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community" -ErrorAction SilentlyContinue) {
        Write-Host "✓ Visual Studio 2019: Found" -ForegroundColor Green
        $checks += "vs"
    } else {
        Write-Host "✗ Visual Studio: Not found" -ForegroundColor Red
    }
    
    # PortAudio
    if (Test-Path "C:\Program Files\portaudio\include\portaudio.h" -ErrorAction SilentlyContinue) {
        Write-Host "✓ PortAudio: Found" -ForegroundColor Green
        $checks += "portaudio"
    } else {
        Write-Host "✗ PortAudio: Not found" -ForegroundColor Red
    }
    
    # SDL2
    if (Test-Path "C:\Program Files\SDL2\include\SDL.h" -ErrorAction SilentlyContinue) {
        Write-Host "✓ SDL2: Found" -ForegroundColor Green
        $checks += "sdl2"
    } else {
        Write-Host "✗ SDL2: Not found" -ForegroundColor Red
    }
    
    Write-Host ""
    if ($checks.Count -eq 4) {
        Write-Host "All dependencies found! Ready to build." -ForegroundColor Green
    } else {
        Write-Host "Missing: " -ForegroundColor Yellow -NoNewline
        Write-Host ($checks | Select-Object -Unique | % { if ($_ -eq "cmake") { "CMake"; } elseif ($_ -eq "vs") { "Visual Studio"; } else { $_ } }) -ForegroundColor Red
    }
    Write-Host ""
}

function Install-Dependencies {
    Write-Host "═══ Install Dependencies ═══" -ForegroundColor Yellow
    Write-Host ""
    
    # Check for admin
    $isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
    
    if (-not $isAdmin) {
        Write-Host "⚠ Administrator access required for installation" -ForegroundColor Yellow
        Write-Host ""
        Write-Host "Three options:" -ForegroundColor Cyan
        Write-Host "  1. Run this script as Administrator (right-click → Run as Administrator)" -ForegroundColor White
        Write-Host "  2. Use vcpkg for manual installation (see BUILD_WINDOWS.md)" -ForegroundColor White
        Write-Host "  3. Install dependencies manually to C:\Program Files\*" -ForegroundColor White
        Write-Host ""
        return
    }
    
    # Check for Chocolatey
    $choco = Get-Command choco -ErrorAction SilentlyContinue
    if ($choco) {
        Write-Host "✓ Chocolatey found at: $($choco.Source)" -ForegroundColor Green
        Write-Host ""
        Write-Host "Installing dependencies with Chocolatey..." -ForegroundColor Yellow
        
        Write-Host "  → CMake" -ForegroundColor Cyan
        & choco install cmake -y --force 2>&1 | Out-Null
        
        Write-Host "  → Visual Studio 2022 (5-15 min)" -ForegroundColor Cyan
        & choco install visualstudio2022community -y 2>&1 | Out-Null
        
        Write-Host "  → Build dependencies" -ForegroundColor Cyan
        & choco install portaudio sdl2 -y 2>&1 | Out-Null
        
        Write-Host ""
        Write-Host "✓ Installation complete!" -ForegroundColor Green
        Write-Host ""
        Write-Host "Note: Close and reopen PowerShell for PATH changes to take effect" -ForegroundColor Yellow
    } else {
        Write-Host "Chocolatey not found. Install it from:" -ForegroundColor Yellow
        Write-Host "  https://chocolatey.org/install" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "Or manually install:" -ForegroundColor Yellow
        Write-Host "  - CMake: https://cmake.org/download/" -ForegroundColor Cyan
        Write-Host "  - VS 2022: https://visualstudio.microsoft.com/downloads/" -ForegroundColor Cyan
        Write-Host "  - PortAudio: http://www.portaudio.com/download.html" -ForegroundColor Cyan
        Write-Host "  - SDL2: https://github.com/libsdl-org/SDL/releases" -ForegroundColor Cyan
    }
    Write-Host ""
}

function Build-Project {
    Write-Host "═══ Building Project ═══" -ForegroundColor Yellow
    Write-Host ""
    
    & ".\setup_and_build_windows.ps1"
}

function Show-Help {
    Write-Host "═══ Documentation ═══" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Files:" -ForegroundColor Cyan
    Write-Host "  • BUILD_WINDOWS.md - Detailed build guide" -ForegroundColor White
    Write-Host "  • QUICK_START_WINDOWS.md - Quick start" -ForegroundColor White
    Write-Host "  • README.md - Project overview" -ForegroundColor White
    Write-Host "  • CLAUDE.md - Architecture documentation" -ForegroundColor White
    Write-Host ""
    Write-Host "Scripts:" -ForegroundColor Cyan
    Write-Host "  • setup_and_build_windows.ps1 - Automated build" -ForegroundColor White
    Write-Host "  • check_setup.bat - Quick environment check" -ForegroundColor White
    Write-Host "  • install_dependencies_choco.ps1 - Auto-install deps" -ForegroundColor White
    Write-Host "  • build.bat - Simple build shortcut" -ForegroundColor White
    Write-Host ""
    Write-Host "Links:" -ForegroundColor Cyan
    Write-Host "  • GitHub: https://github.com/sudip-mondal-2002/Amplitron" -ForegroundColor White
    Write-Host "  • Website: https://sudip-mondal-2002.github.io/Amplitron/" -ForegroundColor White
    Write-Host ""
}

# Main menu loop
if ($Action -eq "auto") {
    while ($true) {
        Show-Menu
        $choice = Read-Host "Enter choice (1-6)"
        
        switch ($choice) {
            "1" { Check-Environment; break }
            "2" { Install-Dependencies; break }
            "3" { Build-Project; break }
            "4" { Check-Environment; Install-Dependencies; Build-Project; break }
            "5" { Show-Help; break }
            "6" { Write-Host "Goodbye!"; exit 0 }
            default { Write-Host "Invalid choice" -ForegroundColor Red }
        }
    }
} else {
    switch ($Action) {
        "check" { Check-Environment }
        "install" { Install-Dependencies }
        "build" { Build-Project }
        "full" { Check-Environment; Install-Dependencies; Build-Project }
        "auto" { }
    }
}

Write-Host ""
