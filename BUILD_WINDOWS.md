# Amplitron Build & Setup Guide - Windows

## Quick Links

- **Want a pre-built executable?** Download from [Releases](https://github.com/sudip-mondal-2002/Amplitron/releases)
- **Want to build from source?** See [Build Instructions](#build-from-source)
- **Having issues?** See [Troubleshooting](#troubleshooting)

---

## Build from Source

### Minimum Requirements

- Windows 7 or later
- CMake 3.16+
- Visual Studio 2019/2022 or Build Tools for C++
- ~500 MB disk space

### Setup Options

#### Option 1: Fully Automated (Recommended for Beginners)

**Requirements:** Chocolatey (and Administrator access)

```powershell
# 1. Install Chocolatey if you don't have it:
# See: https://chocolatey.org/install

# 2. Install build tools automatically:
powershell -ExecutionPolicy Bypass -File install_dependencies_choco.ps1

# 3. Build the project:
powershell -ExecutionPolicy Bypass -File setup_and_build_windows.ps1
```

**What this does:**

- Installs CMake, Visual Studio 2022, PortAudio, SDL2
- Configures and builds the project
- Runs basic tests
- Creates the executable at `build\Release\amplitron.exe`

#### Option 2: Semi-Automated (Recommended for Experienced Users)

**Requirements:** Manual dependency installation

```powershell
# 1. Install dependencies manually (see Dependency Installation below)

# 2. Check your setup:
.\check_setup.bat

# 3. Build:
powershell -ExecutionPolicy Bypass -File setup_and_build_windows.ps1
```

#### Option 3: Manual Build (for Advanced Users)

```powershell
# 1. Install all dependencies (see below)

# 2. Create build directory:
mkdir build
cd build

# 3. Configure:
cmake -DCMAKE_BUILD_TYPE=Release ..

# 4. Build:
cmake --build . --config Release --parallel

# 5. Run:
Release\amplitron.exe
```

---

## Dependency Installation

### Method A: Using vcpkg (Recommended)

vcpkg is a modern C++ package manager that makes dependency management easy.

```powershell
# 1. Clone vcpkg:
git clone https://github.com/Microsoft/vcpkg.git
cd vcpkg

# 2. Bootstrap:
.\bootstrap-vcpkg.bat

# 3. Install dependencies:
.\vcpkg install portaudio:x64-windows sdl2:x64-windows rtmidi:x64-windows

# 4. When building, add the CMake toolchain flag:
# (Done automatically by setup_and_build_windows.ps1 if VCPKG_ROOT is set)
$env:VCPKG_ROOT = "C:\path\to\vcpkg"
```

### Method B: Manual Installation

1. **PortAudio** (Audio I/O)
   - Download: http://www.portaudio.com/download.html
   - Extract to: `C:\Program Files\portaudio`
   - CMake will find it automatically

2. **SDL2** (Graphics)
   - Download: https://github.com/libsdl-org/SDL/releases
   - Choose: `SDL2-devel-2.x.x-VC.zip`
   - Extract to: `C:\Program Files\SDL2`

3. **RtMidi** (MIDI support)
   - Download: https://github.com/thestk/rtmidi
   - Extract to: `C:\Program Files\rtmidi`

4. **CMake** (Build system)
   - Download: https://cmake.org/download/
   - Run installer (adds to PATH automatically)

5. **Visual Studio** (Compiler)
   - Download: https://visualstudio.microsoft.com/downloads/
   - Choose: Community Edition
   - Install: "Desktop development with C++"

### Method C: Chocolatey (Windows Package Manager)

If you have Chocolatey installed:

```powershell
choco install cmake visualstudio2022community -y
# Then use Method A or B for the C++ dependencies
```

---

## Building

### Quick Build

```powershell
powershell -ExecutionPolicy Bypass -File setup_and_build_windows.ps1
```

This automatically:

- Checks your environment
- Runs CMake configuration
- Compiles the project
- Tests the build
- Shows you where the executable is

### Full Build Process

```powershell
# 1. Setup (downloads external headers if needed)
powershell -ExecutionPolicy Bypass -File scripts\setup_dependencies.ps1

# 2. Configure
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release ..

# 3. Build
cmake --build . --config Release --parallel

# 4. Test (optional)
Release\amplitron-tests.exe

# 5. Run
Release\amplitron.exe
```

---

## Running

### After Building

```powershell
# Run with GUI (default):
build\Release\amplitron.exe

# Show help:
build\Release\amplitron.exe --help

# Show version:
build\Release\amplitron.exe --version
```

### Running Tests

```powershell
build\Release\amplitron-tests.exe
```

Expected: 105+ tests passing

---

## Troubleshooting

### "CMake not found"

**Solution:**

1. Install CMake from https://cmake.org/download/
2. Or: `choco install cmake -y`
3. Restart PowerShell

### "Visual Studio not found"

**Solution:**

1. Install from https://visualstudio.microsoft.com/downloads/
2. Choose Community Edition
3. Install "Desktop development with C++"
4. Or: `choco install visualstudio2022community -y`

### "PortAudio/SDL2 not found"

**Solution:**

- Use vcpkg (Method A above) - most reliable
- Or manually extract to `C:\Program Files\LibraryName`
- Check with: `.\check_setup.bat`

### CMake configuration fails with "generator not found"

**Solution:**

- Make sure Visual Studio 2022 or 2019 is installed
- Run from "Developer PowerShell for VS 2022"
- Or explicitly specify generator:
  ```powershell
  cmake -G "Visual Studio 17 2022" ..
  ```

### Build fails with linker errors

**Solution:**

1. Verify dependencies are in the correct locations:
   ```powershell
   .\check_setup.bat
   ```
2. If using vcpkg, set:
   ```powershell
   $env:VCPKG_ROOT = "C:\path\to\vcpkg"
   ```
3. Try cleaning and rebuilding:
   ```powershell
   rm -r build
   mkdir build
   cd build
   cmake -DCMAKE_BUILD_TYPE=Release ..
   cmake --build . --config Release --parallel
   ```

### "Audio engine failed to initialize"

**Normal behavior** - means no audio device was detected. In the GUI:

1. Click File → Settings
2. Select your input device (USB cable, microphone, etc.)
3. Select your output device (speakers, headphones, etc.)
4. Click Apply

### Build is slow

**Solution:**

- Use Release build instead of Debug:
  ```powershell
  .\setup_and_build_windows.ps1  # Already uses Release
  ```
- Increase parallel build jobs:
  ```powershell
  cmake --build . --config Release --parallel 8
  ```

### Out of disk space

Amplitron needs ~500 MB for build artifacts.

- Full build: ~300 MB
- Installed: ~50 MB
- Clean with: `rm -r build`

---

## Next Steps

1. **Run the application:** `build\Release\amplitron.exe`
2. **Connect your guitar** via USB audio interface
3. **Explore the presets** in File → Load Preset
4. **Customize** by adding/removing effects
5. **Save your setup** in File → Save Preset

---

## Getting Help

- **GitHub Issues:** https://github.com/sudip-mondal-2002/Amplitron/issues
- **Documentation:** https://sudip-mondal-2002.github.io/Amplitron/
- **Architecture Guide:** See `CLAUDE.md` in the project root

---

## System Information

- **Architecture:** x86-64
- **Language:** C++17
- **Build System:** CMake
- **Audio Engine:** PortAudio + SDL2
- **GUI Framework:** Dear ImGui
- **License:** MIT

## File Descriptions

| File                             | Purpose                           |
| -------------------------------- | --------------------------------- |
| `setup_and_build_windows.ps1`    | Main build script (automated)     |
| `check_setup.bat`                | Quick environment check           |
| `install_dependencies_choco.ps1` | Auto-install deps with Chocolatey |
| `scripts/setup_dependencies.ps1` | Download external headers         |
| `scripts/build_windows.ps1`      | Alternative build script          |
| `QUICK_START_WINDOWS.md`         | Quick start guide                 |
| `CMakeLists.txt`                 | CMake configuration               |
| `README.md`                      | Project overview                  |
