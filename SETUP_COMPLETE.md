# ✅ AMPLITRON SETUP - Complete Solution

## The Problem

The CLI (and GUI application) wasn't running because the build environment wasn't set up - missing dependencies, build tools, or proper configuration.

## The Solution

I've created a **complete, step-by-step setup system** with multiple options from fully-automatic to fully-manual.

---

## 🚀 Quick Start (Choose Your Path)

### Path 1: One-Click Build (Easiest)

**For people who want to just build it**

```powershell
# Double-click or run:
build.bat
```

That's it! This will:

- Check if you have CMake
- Download external headers
- Configure the project
- Compile everything
- Show you where the executable is

### Path 2: Interactive Setup (Recommended)

**For people who want to understand each step**

```powershell
# Run the interactive menu:
powershell -ExecutionPolicy Bypass -File amplitron_setup.ps1
```

Then choose:

1. Check environment
2. Install missing dependencies
3. Build project

### Path 3: Full Automated (Most Thorough)

**For people who want everything done automatically**

```powershell
# This installs tools + dependencies + builds:
powershell -ExecutionPolicy Bypass -File install_dependencies_choco.ps1
```

Then it will ask if you want to build.

### Path 4: Manual (for Advanced Users)

See `BUILD_WINDOWS.md` for detailed manual steps.

---

## 📋 What I Created For You

| File                               | Purpose                     | Use When                             |
| ---------------------------------- | --------------------------- | ------------------------------------ |
| **build.bat**                      | Simplest possible build     | You just want to build quickly       |
| **amplitron_setup.ps1**            | Interactive menu            | You want to understand each step     |
| **setup_and_build_windows.ps1**    | Detailed automated build    | You want comprehensive feedback      |
| **check_setup.bat**                | Environment check           | You want to verify your setup        |
| **install_dependencies_choco.ps1** | Auto-install via Chocolatey | You have admin access and Chocolatey |
| **BUILD_WINDOWS.md**               | Complete build guide        | You want to understand everything    |
| **QUICK_START_WINDOWS.md**         | Quick reference             | You want a cheat sheet               |
| **amplitron_setup.ps1**            | Master setup script         | You want an interactive menu         |

---

## 🎯 Typical Setup Workflow

### If you DON'T have build tools yet:

```powershell
# 1. Check what's missing
.\check_setup.bat

# 2. Install missing tools (choose one):
# Option A: Automatic (requires Chocolatey)
powershell -ExecutionPolicy Bypass -File install_dependencies_choco.ps1

# Option B: Manual - follow instructions in BUILD_WINDOWS.md
```

### Then build:

```powershell
# Any of these work:
build.bat                                              # Simplest
.\setup_and_build_windows.ps1                         # Most detailed
cmake --build build --config Release --parallel       # Manual
```

---

## 📊 Common Issues & Fixes

### "CMake not found"

```powershell
# Install:
choco install cmake -y
# Then restart PowerShell
```

### "Visual Studio not found"

```powershell
# Install:
choco install visualstudio2022community -y
# Then restart PowerShell
```

### "PortAudio/SDL2 not found"

```powershell
# Install:
choco install portaudio sdl2 -y
# Then restart PowerShell
```

### Still having issues?

1. Run: `.\check_setup.bat` to diagnose
2. Read: `BUILD_WINDOWS.md` for detailed troubleshooting
3. Search: `CLAUDE.md` for architecture info

---

## ▶️ Running the Application

After building successfully:

```powershell
# Run the GUI:
build\Release\amplitron.exe

# Test the CLI:
build\Release\amplitron.exe --help
build\Release\amplitron.exe --version

# Run tests:
build\Release\amplitron-tests.exe
```

---

## 🔍 File Structure

```
AMPLITRON/
├── build.bat                        ← Simplest build
├── amplitron_setup.ps1             ← Interactive menu
├── setup_and_build_windows.ps1     ← Detailed auto build
├── check_setup.bat                 ← Environment check
├── install_dependencies_choco.ps1  ← Auto-install deps
│
├── BUILD_WINDOWS.md                ← Complete guide
├── QUICK_START_WINDOWS.md          ← Quick reference
├── README.md                       ← Project overview
├── CLAUDE.md                       ← Architecture
│
├── CMakeLists.txt                  ← Build config
├── src/                            ← Source code
├── tests/                          ← Test suite
└── build/                          ← Build output (created during build)
    ├── Release/
    │   ├── amplitron.exe          ← GUI application
    │   └── amplitron-tests.exe    ← Test suite
    └── ...
```

---

## 🎮 What Amplitron Does

Amplitron is a **professional real-time guitar amplifier simulator** with:

- **16+ effects** (overdrive, delay, reverb, etc.)
- **Ultra-low latency** (~1.3ms)
- **Visual pedal board** (drag & drop)
- **MIDI support** (hardware controllers)
- **Preset system** (save/load chains)
- **Recording** (WAV output)
- **Tuner** (chromatic)
- **Spectrum analyzer**

It's NOT just a command-line tool - it's a full GUI application. The CLI args are just for help and version info.

---

## 📖 Documentation Files

| File                       | Content                                     |
| -------------------------- | ------------------------------------------- |
| **BUILD_WINDOWS.md**       | Dependency setup, manual build, all options |
| **QUICK_START_WINDOWS.md** | Quick reference for experienced users       |
| **CLAUDE.md**              | System architecture, 16+ DSP effects        |
| **README.md**              | Project overview, features, downloads       |
| **DEPLOYMENT.md**          | CI/CD pipeline and release process          |

---

## ✅ Next Steps

1. **Choose your setup method** above (Path 1-4)
2. **Follow the prompts** - scripts will guide you
3. **Run the application** - see the GUI
4. **Explore** - drag effects around, load presets
5. **Connect your guitar** - via USB audio interface

---

## 🆘 Need Help?

- **Check environment:** `check_setup.bat`
- **Read guides:** `BUILD_WINDOWS.md` or `QUICK_START_WINDOWS.md`
- **Architecture:** `CLAUDE.md`
- **GitHub Issues:** https://github.com/sudip-mondal-2002/Amplitron/issues
- **Website:** https://sudip-mondal-2002.github.io/Amplitron/

---

## 📦 What Gets Built

- **amplitron.exe** - GUI application (what you run)
- **amplitron-tests.exe** - Test suite (105+ tests)

---

## 🎯 Summary

You now have:

✅ Multiple setup options (automatic, interactive, manual)
✅ Clear error messages and troubleshooting
✅ Comprehensive documentation
✅ Scripts that verify your environment
✅ Automated build system

**Just run one of the scripts above and follow the prompts!**
