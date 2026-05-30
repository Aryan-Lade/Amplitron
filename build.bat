@echo off
REM ============================================================
REM Amplitron - Windows Quick Build
REM ============================================================
REM This is the SIMPLEST way to build Amplitron on Windows
REM Just run: build.bat

setlocal enabledelayedexpansion

cd /d "%~dp0" || exit /b 1

title Amplitron - Build

echo.
echo ============================================================
echo   Amplitron - Guitar Amp Simulator
echo   Windows Build Script
echo ============================================================
echo.

REM Check for CMake
cmake --version >nul 2>&1
if errorlevel 1 (
    color 0C
    echo.
    echo ERROR: CMake not found!
    echo.
    echo Please install CMake first:
    echo   - Download: https://cmake.org/download/
    echo   - Or: choco install cmake -y
    echo.
    echo Then run this script again.
    echo.
    pause
    exit /b 1
)

echo [1/3] Checking dependencies...
powershell -NoProfile -ExecutionPolicy Bypass -File scripts\setup_dependencies.ps1 >nul 2>&1

echo [2/3] Building project...
if not exist build mkdir build
cd build

cmake -DCMAKE_BUILD_TYPE=Release .. || (
    echo.
    color 0C
    echo ERROR: CMake configuration failed!
    echo.
    echo Try these solutions:
    echo   1. Install Visual Studio 2022 Community:
    echo      https://visualstudio.microsoft.com/downloads/
    echo   2. Or: choco install visualstudio2022community -y
    echo   3. Install dependencies:
    echo      choco install portaudio sdl2 -y
    echo      (Or use vcpkg - see BUILD_WINDOWS.md)
    echo.
    pause
    exit /b 1
)

cmake --build . --config Release --parallel || (
    echo.
    color 0C
    echo ERROR: Build failed!
    echo.
    echo See BUILD_WINDOWS.md for detailed troubleshooting.
    echo.
    pause
    exit /b 1
)

echo [3/3] Finalizing...
cd ..

if exist build\Release\amplitron.exe (
    color 0B
    echo.
    echo ============================================================
    echo   BUILD SUCCESSFUL!
    echo ============================================================
    echo.
    echo Executable: build\Release\amplitron.exe
    echo.
    echo You can now:
    echo   - Run: build\Release\amplitron.exe
    echo   - Test CLI: build\Release\amplitron.exe --help
    echo   - Run tests: build\Release\amplitron-tests.exe
    echo.
    
    set /p run_now="Run now? (y/n): "
    if /i "!run_now!"=="y" (
        start "" build\Release\amplitron.exe
    )
) else (
    color 0C
    echo ERROR: Executable not created!
    echo Expected: build\Release\amplitron.exe
)

echo.
pause
