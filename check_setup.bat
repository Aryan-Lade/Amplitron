@echo off
REM ============================================================
REM Amplitron - Windows Environment Check & Setup
REM ============================================================
REM This script checks for required tools and offers installation
REM instructions or automatic setup guidance

setlocal enabledelayedexpansion
color 0A
title Amplitron - Windows Setup Check

echo.
echo ============================================================
echo   Amplitron - Windows Environment Check
echo ============================================================
echo.

set "all_good=1"

REM Check CMake
echo [1/5] Checking for CMake...
cmake --version >nul 2>&1
if errorlevel 1 (
    echo   X CMake not found
    set "all_good=0"
) else (
    for /f "tokens=3" %%i in ('cmake --version') do (
        echo   OK CMake %%i installed
        goto :cmake_ok
    )
    :cmake_ok
)

REM Check Visual Studio Build Tools
echo [2/5] Checking for C++ compiler...
cl.exe >nul 2>&1
if errorlevel 1 (
    REM Try to find MSVC
    if exist "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC" (
        echo   OK Visual Studio 2022 detected
    ) else if exist "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Tools\MSVC" (
        echo   OK Visual Studio 2019 detected
    ) else (
        echo   X Visual Studio Build Tools not found
        set "all_good=0"
    )
) else (
    echo   OK MSVC compiler available
)

REM Check PortAudio
echo [3/5] Checking for PortAudio...
if exist "C:\Program Files\portaudio\include\portaudio.h" (
    echo   OK PortAudio found
) else (
    echo   X PortAudio not found
    set "all_good=0"
)

REM Check SDL2
echo [4/5] Checking for SDL2...
if exist "C:\Program Files\SDL2\include\SDL.h" (
    echo   OK SDL2 found
) else (
    echo   X SDL2 not found
    set "all_good=0"
)

REM Check RtMidi
echo [5/5] Checking for RtMidi...
if exist "C:\Program Files\rtmidi\include\rtmidi\RtMidi.h" (
    echo   OK RtMidi found
) else (
    echo   X RtMidi not found
    set "all_good=0"
)

echo.
echo ============================================================

if "!all_good!"=="1" (
    color 0B
    echo   ALL DEPENDENCIES FOUND - Ready to build!
    echo.
    echo   Build with:
    echo     powershell -ExecutionPolicy Bypass ^
    echo     -File setup_and_build_windows.ps1
    echo.
    pause
    exit /b 0
) else (
    color 0C
    echo   MISSING DEPENDENCIES
    echo.
    echo   Please install the missing tools:
    echo.
    echo   1. Install CMake:
    echo      - Download: https://cmake.org/download/
    echo      - Or: choco install cmake -y
    echo.
    echo   2. Install Visual Studio 2022 Community:
    echo      - Download: https://visualstudio.microsoft.com/downloads/
    echo      - Include "Desktop development with C++"
    echo      - Or: choco install visualstudio2022community -y
    echo.
    echo   3. Install dependencies (choose ONE method):
    echo.
    echo      Method A: Using vcpkg (recommended)
    echo      - git clone https://github.com/Microsoft/vcpkg.git
    echo      - cd vcpkg
    echo      - .\bootstrap-vcpkg.bat
    echo      - .\vcpkg install portaudio:x64-windows ^
    echo        sdl2:x64-windows rtmidi:x64-windows
    echo.
    echo      Method B: Manual installation
    echo      - PortAudio: http://www.portaudio.com/download.html
    echo      - SDL2: https://github.com/libsdl-org/SDL/releases
    echo      - RtMidi: https://github.com/thestk/rtmidi
    echo      - Extract each to C:\Program Files\LibraryName\
    echo.
    echo   After installation, run this script again to verify.
    echo.
    pause
    exit /b 1
)
