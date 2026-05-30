# Amplitron Complete Setup and Build Script for Windows
# This script:
# 1. Checks for CMake installation
# 2. Attempts to install missing dependencies
# 3. Configures and builds the project
# 4. Tests the built CLI

param(
    [ValidateSet("Release", "Debug")]
    [string]$BuildType = "Release",
    [switch]$SkipDependencies
)

$ErrorActionPreference = "Continue"
$PROJECT_ROOT = Split-Path -Parent $MyInvocation.MyCommand.Path
$BUILD_DIR = Join-Path $PROJECT_ROOT "build"

Write-Host "=====================================================" -ForegroundColor Cyan
Write-Host "  Amplitron - Complete Setup & Build for Windows" -ForegroundColor Cyan
Write-Host "=====================================================" -ForegroundColor Cyan
Write-Host ""

# =====================================================================
# Step 1: Check for CMake
# =====================================================================
Write-Host "[1/5] Checking for CMake..." -ForegroundColor Yellow

$cmake_path = (Get-Command cmake -ErrorAction SilentlyContinue).Source

if (-not $cmake_path) {
    Write-Host "  ❌ CMake not found in PATH" -ForegroundColor Red
    Write-Host "  Please install CMake from: https://cmake.org/download/" -ForegroundColor Cyan
    Write-Host "  Or use: choco install cmake -y" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  Attempting to find CMake in common locations..." -ForegroundColor Yellow
    
    $common_paths = @(
        "C:\Program Files\CMake\bin\cmake.exe",
        "C:\Program Files (x86)\CMake\bin\cmake.exe",
        "$env:PROGRAMFILES\CMake\bin\cmake.exe"
    )
    
    foreach ($path in $common_paths) {
        if (Test-Path $path) {
            $cmake_path = $path
            Write-Host "  ✓ Found CMake at: $cmake_path" -ForegroundColor Green
            $env:PATH = (Split-Path $cmake_path) + ";" + $env:PATH
            break
        }
    }
    
    if (-not $cmake_path) {
        Write-Host "  Still not found. Please install CMake manually." -ForegroundColor Red
        exit 1
    }
} else {
    Write-Host "  ✓ CMake found: $cmake_path" -ForegroundColor Green
}

# Verify CMake version
Write-Host "  Checking CMake version..." -ForegroundColor Yellow
$cmake_version = & cmake --version 2>$null | Select-Object -First 1
Write-Host "  $cmake_version" -ForegroundColor Green
Write-Host ""

# =====================================================================
# Step 2: Check for Visual Studio / Build Tools
# =====================================================================
Write-Host "[2/5] Checking for C++ build tools..." -ForegroundColor Yellow

$vs_found = $false
$compiler_info = $null

# Check for Visual Studio 2022
$vs2022_path = "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsall.bat"
if (Test-Path $vs2022_path) {
    $vs_found = $true
    $compiler_info = "Visual Studio 2022 Community"
} else {
    # Check for Visual Studio 2019
    $vs2019_path = "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvarsall.bat"
    if (Test-Path $vs2019_path) {
        $vs_found = $true
        $compiler_info = "Visual Studio 2019 Community"
    }
}

if ($vs_found) {
    Write-Host "  ✓ $compiler_info detected" -ForegroundColor Green
} else {
    # Check if we can compile with available compilers
    $temp_test = Join-Path $env:TEMP "cmake_test.c"
    'int main() { return 0; }' | Out-File -FilePath $temp_test -Encoding ASCII
    
    $result = & cmake -E capabilities 2>$null | Select-String "Visual Studio"
    if ($result) {
        Write-Host "  ✓ CMake detected Visual Studio generator" -ForegroundColor Green
    } else {
        Write-Host "  ⚠ Visual Studio/Build Tools not clearly detected" -ForegroundColor Yellow
        Write-Host "    CMake may attempt MinGW or other available compiler" -ForegroundColor Yellow
    }
    
    Remove-Item $temp_test -ErrorAction SilentlyContinue
}
Write-Host ""

# =====================================================================
# Step 3: Run dependency setup script
# =====================================================================
if (-not $SkipDependencies) {
    Write-Host "[3/5] Setting up dependencies..." -ForegroundColor Yellow
    
    $setup_script = Join-Path $PROJECT_ROOT "scripts\setup_dependencies.ps1"
    if (Test-Path $setup_script) {
        Write-Host "  Running: $setup_script" -ForegroundColor Yellow
        & powershell -ExecutionPolicy Bypass -File $setup_script
        Write-Host ""
    } else {
        Write-Host "  ⚠ Dependency setup script not found" -ForegroundColor Yellow
    }
} else {
    Write-Host "[3/5] Skipping dependency setup (--SkipDependencies)" -ForegroundColor Yellow
    Write-Host ""
}

# =====================================================================
# Step 4: Configure and Build with CMake
# =====================================================================
Write-Host "[4/5] Configuring and building project..." -ForegroundColor Yellow

if (-Not (Test-Path $BUILD_DIR)) {
    Write-Host "  Creating build directory: $BUILD_DIR" -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $BUILD_DIR | Out-Null
}

Push-Location $BUILD_DIR
try {
    Write-Host "  Running CMake configuration..." -ForegroundColor Yellow
    Write-Host "  Command: cmake -DCMAKE_BUILD_TYPE=$BuildType .." -ForegroundColor Gray
    
    cmake -DCMAKE_BUILD_TYPE=$BuildType .. 2>&1 | ForEach-Object { Write-Host "    $_" }
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host "  ❌ CMake configuration failed (exit code: $LASTEXITCODE)" -ForegroundColor Red
        Write-Host ""
        Write-Host "  Troubleshooting steps:" -ForegroundColor Yellow
        Write-Host "    1. Ensure Visual Studio 2022 or 2019 is installed" -ForegroundColor White
        Write-Host "    2. Verify dependencies are in PATH or installed to default locations:" -ForegroundColor White
        Write-Host "       - PortAudio: C:\Program Files\portaudio" -ForegroundColor White
        Write-Host "       - SDL2: C:\Program Files\SDL2" -ForegroundColor White
        Write-Host "       - RtMidi: C:\Program Files\rtmidi" -ForegroundColor White
        Write-Host "    3. Run: vcpkg install portaudio:x64-windows sdl2:x64-windows rtmidi:x64-windows" -ForegroundColor White
        Write-Host "    4. Then set: \$env:CMAKE_PREFIX_PATH = 'C:\vcpkg\installed\x64-windows'" -ForegroundColor White
        Pop-Location
        exit 1
    }
    
    Write-Host "  ✓ CMake configuration successful" -ForegroundColor Green
    Write-Host ""
    Write-Host "  Building project ($BuildType)..." -ForegroundColor Yellow
    Write-Host "  Command: cmake --build . --config $BuildType --parallel" -ForegroundColor Gray
    
    cmake --build . --config $BuildType --parallel 2>&1 | ForEach-Object { Write-Host "    $_" }
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host "  ❌ Build failed (exit code: $LASTEXITCODE)" -ForegroundColor Red
        Pop-Location
        exit 1
    }
    
    Write-Host "  ✓ Build successful" -ForegroundColor Green
    Write-Host ""
}
finally {
    Pop-Location
}

# =====================================================================
# Step 5: Verify and Report
# =====================================================================
Write-Host "[5/5] Verifying build artifacts..." -ForegroundColor Yellow

$exe_candidates = @(
    (Join-Path $BUILD_DIR "$BuildType\amplitron.exe"),
    (Join-Path $BUILD_DIR "amplitron.exe"),
    (Join-Path $BUILD_DIR "Release\amplitron.exe"),
    (Join-Path $BUILD_DIR "Debug\amplitron.exe")
)

$exe_path = $null
foreach ($candidate in $exe_candidates) {
    if (Test-Path $candidate) {
        $exe_path = $candidate
        break
    }
}

Write-Host ""
Write-Host "=====================================================" -ForegroundColor Green
Write-Host "  BUILD COMPLETE ✓" -ForegroundColor Green
Write-Host "=====================================================" -ForegroundColor Green
Write-Host ""

if ($exe_path) {
    Write-Host "Executable: $exe_path" -ForegroundColor Green
    Write-Host ""
    Write-Host "Next steps:" -ForegroundColor Cyan
    Write-Host "  1. Test the CLI help:" -ForegroundColor White
    Write-Host "     & '$exe_path' --help" -ForegroundColor Gray
    Write-Host ""
    Write-Host "  2. Run the application:" -ForegroundColor White
    Write-Host "     & '$exe_path'" -ForegroundColor Gray
    Write-Host ""
    Write-Host "  3. Run the test suite:" -ForegroundColor White
    $test_exe = Join-Path $BUILD_DIR "$BuildType\amplitron-tests.exe"
    if (-not (Test-Path $test_exe)) {
        $test_exe = Join-Path $BUILD_DIR "amplitron-tests.exe"
    }
    Write-Host "     & '$test_exe'" -ForegroundColor Gray
    Write-Host ""
    
    # Auto-test if CLI responds
    Write-Host "Testing CLI..." -ForegroundColor Yellow
    $help_output = & $exe_path --help 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "  ✓ CLI is working!" -ForegroundColor Green
        Write-Host ""
        Write-Host "CLI Help Output:" -ForegroundColor Cyan
        Write-Host "$help_output"
    } else {
        Write-Host "  ⚠ CLI help test failed" -ForegroundColor Yellow
    }
} else {
    Write-Host "❌ Could not locate amplitron.exe" -ForegroundColor Red
    Write-Host "Build directory: $BUILD_DIR" -ForegroundColor White
    Write-Host "Contents:" -ForegroundColor Yellow
    Get-ChildItem -Recurse $BUILD_DIR -Filter "*.exe" -ErrorAction SilentlyContinue | ForEach-Object {
        Write-Host "  Found: $($_.FullName)" -ForegroundColor Green
    }
}

Write-Host ""
