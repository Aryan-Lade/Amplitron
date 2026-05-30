# ============================================================

# Amplitron - Quick Start Guide for Windows

# ============================================================

## Overview

Amplitron is a professional real-time guitar amplifier simulator. The main executable is a GUI application, but it also supports command-line arguments for help and version info.

## Quick Start - Option A: Pre-built Executable

If you have a pre-built `amplitron.exe`:

```powershell
# Show CLI help
amplitron.exe --help

# Show version
amplitron.exe --version

# Run the GUI application
amplitron.exe
```

## Quick Start - Option B: Build from Source

### Prerequisites

You need to install:

1. **CMake** (3.16+)
   - Download from: https://cmake.org/download/
   - Or use: `choco install cmake -y`

2. **Visual Studio 2022 or 2019** (with C++ development tools)
   - Download Community Edition: https://visualstudio.microsoft.com/downloads/
   - Or use: `choco install visualstudio2022community -y`

3. **Dependencies** (one of the following):

   **Option B1: Using vcpkg (Recommended)**

   ```powershell
   # Install vcpkg
   git clone https://github.com/Microsoft/vcpkg.git
   cd vcpkg
   .\bootstrap-vcpkg.bat

   # Install dependencies
   .\vcpkg install portaudio:x64-windows sdl2:x64-windows rtmidi:x64-windows

   # Set environment variable for CMake
   $env:CMAKE_TOOLCHAIN_FILE = "C:\path\to\vcpkg\scripts\buildsystems\vcpkg.cmake"
   ```

   **Option B2: Manual Installation**
   - PortAudio: Download from http://www.portaudio.com/download.html
   - SDL2: Download from https://github.com/libsdl-org/SDL/releases
   - RtMidi: Download from https://github.com/thestk/rtmidi
   - Extract to `C:\Program Files\`

### Build Steps

From the Amplitron root directory:

```powershell
# 1. Run the automated setup and build script
.\setup_and_build_windows.ps1

# Or manually:

# 2. Create build directory
mkdir build
cd build

# 3. Configure with CMake
cmake -DCMAKE_BUILD_TYPE=Release ..

# 4. Build
cmake --build . --config Release --parallel

# 5. Run tests (optional)
Release\amplitron-tests.exe

# 6. Run the application
Release\amplitron.exe
```

## Command-Line Options

```
Usage: amplitron [options]

Options:
  -h, --help      Show this help message and exit
  -v, --version   Show version information and exit

Audio devices are configured via File -> Settings in the GUI.
Visit https://github.com/sudip-mondal-2002/Amplitron for docs.
```

## Troubleshooting

### Problem: "CMake not found"

**Solution:**

- Install CMake from https://cmake.org/download/
- Or use `choco install cmake -y`
- Restart PowerShell after installation

### Problem: "Visual Studio not found"

**Solution:**

- Install Visual Studio 2022 Community from https://visualstudio.microsoft.com/downloads/
- Make sure to install C++ development tools
- Run from "Developer PowerShell for VS 2022" if issues persist

### Problem: "PortAudio/SDL2/RtMidi not found"

**Solution:**

Option 1: Use vcpkg

```powershell
# If you have vcpkg installed:
.\vcpkg install portaudio:x64-windows sdl2:x64-windows rtmidi:x64-windows
$env:CMAKE_TOOLCHAIN_FILE = "C:\path\to\vcpkg\scripts\buildsystems\vcpkg.cmake"
cd build && cmake -DCMAKE_BUILD_TYPE=Release ..
```

Option 2: Manual installation

- Download each library
- Extract to `C:\Program Files\<LibraryName>`
- CMake will search there automatically

### Problem: Build succeeds but executable not found

**Solution:**

```powershell
# Look for the executable
Get-ChildItem -Recurse build -Filter "amplitron.exe"
```

The binary is typically at: `build\Release\amplitron.exe`

### Problem: "audio engine failed to initialize"

**Solution:**

- This is normal if no audio devices are detected
- In the GUI, go to File → Settings → Audio Devices
- Select your input device (USB cable or microphone)
- Select your output device (speakers or headphones)

## Running the Test Suite

After building:

```powershell
cd build
Release\amplitron-tests.exe
```

Expected output: 105+ tests passing

## More Information

- GitHub: https://github.com/sudip-mondal-2002/Amplitron
- Documentation: https://sudip-mondal-2002.github.io/Amplitron/
- Issues: https://github.com/sudip-mondal-2002/Amplitron/issues

## Architecture Overview

The project includes:

- **Audio Engine**: Real-time DSP using PortAudio
- **GUI**: Dear ImGui + SDL2 visual pedal board
- **Effects**: 16+ studio-quality effects (overdrive, delay, reverb, etc.)
- **MIDI Support**: Hardware controller mapping via RtMidi
- **Presets**: Save/load complete signal chains as JSON
- **Recording**: Capture processed output to WAV files
- **Tests**: 105+ tests covering all major components

See `CLAUDE.md` for detailed architecture documentation.
