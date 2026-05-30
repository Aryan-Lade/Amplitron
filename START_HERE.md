# 🎸 AMPLITRON - START HERE

## Welcome to Amplitron!

If you're here, you want to build and run the Amplitron guitar amplifier simulator on Windows.

**You're in the right place!** I've created a complete setup system for you.

---

## 🚀 Quick Start (Choose ONE)

### 🟢 I just want to build (Simplest - 5-30 min)

```batch
build.bat
```

Then wait for it to complete. That's it!

### 🟡 I want an interactive menu (Recommended)

```powershell
powershell -ExecutionPolicy Bypass -File amplitron_setup.ps1
```

Then choose from the menu.

### 🔵 I want full auto-install (Most complete - 10-60 min)

**Requirements: Administrator access**

```powershell
powershell -ExecutionPolicy Bypass -File install_dependencies_choco.ps1
```

---

## 📚 Documentation (Pick What You Need)

| File                       | Purpose             | Read If...              |
| -------------------------- | ------------------- | ----------------------- |
| **START_HERE.md**          | Quick visual guide  | You're confused         |
| **BUILD_WINDOWS.md**       | Comprehensive guide | You want all details    |
| **QUICK_START_WINDOWS.md** | Cheat sheet         | You want quick commands |
| **SETUP_FLOWCHART.md**     | Decision tree       | You want a flowchart    |

---

## 🔧 Check Your Setup

Before building, verify you have what you need:

```batch
check_setup.bat
```

This will tell you what's missing (if anything).

---

## 🎯 Common Scenarios

### "I don't have any build tools"

→ Run: `install_dependencies_choco.ps1` (requires admin)
→ Or: Read `BUILD_WINDOWS.md` for manual installation

### "I have Visual Studio but no CMake"

→ Run: `choco install cmake -y`
→ Then: `build.bat`

### "I want to understand what's happening"

→ Run: `powershell -ExecutionPolicy Bypass -File amplitron_setup.ps1`
→ Choose option 1, 2, 3 one at a time

### "Build failed - what's wrong?"

→ Read: `BUILD_WINDOWS.md` [Troubleshooting] section
→ Or: Show me the error in the build output

---

## ✅ After Building

When `build.bat` or other scripts complete successfully:

```powershell
# Run the application
build\Release\amplitron.exe

# Test the CLI
build\Release\amplitron.exe --help
build\Release\amplitron.exe --version

# Run the test suite (105+ tests)
build\Release\amplitron-tests.exe
```

---

## 🎮 What is Amplitron?

A **professional real-time guitar amplifier simulator** featuring:

- 16+ studio-quality effects (overdrive, delay, reverb, etc.)
- Ultra-low latency (~1.3ms)
- Visual drag-&-drop pedal board
- MIDI hardware controller support
- Preset save/load
- WAV recording
- Chromatic tuner
- Available on Windows, macOS, Linux, Android, iOS, and Web

---

## 🤔 Unsure Where to Start?

**Answer these questions:**

1. Do you have CMake installed?
   - NO → Read `BUILD_WINDOWS.md` or run `install_dependencies_choco.ps1`
   - YES → Go to question 2

2. Do you have Visual Studio 2019 or 2022?
   - NO → Install from https://visualstudio.microsoft.com/downloads/
   - YES → Go to question 3

3. Do you want:
   - SIMPLE BUILD? → Run `build.bat`
   - INTERACTIVE? → Run `amplitron_setup.ps1`
   - MANUAL? → Read `BUILD_WINDOWS.md`

---

## 📂 File Organization

```
AMPLITRON/
│
├─ BUILD SCRIPTS (Pick one)
│  ├─ build.bat ........................ Simplest
│  ├─ amplitron_setup.ps1 ............. Interactive menu
│  ├─ setup_and_build_windows.ps1 ..... Detailed auto-build
│  ├─ check_setup.bat ................. Environment check
│  └─ install_dependencies_choco.ps1 .. Auto-install tools
│
├─ DOCUMENTATION (Pick what you need)
│  ├─ START_HERE.md ................... Quick overview ← YOU ARE HERE
│  ├─ SETUP_FLOWCHART.md .............. Visual flowchart
│  ├─ BUILD_WINDOWS.md ................ Complete guide
│  ├─ QUICK_START_WINDOWS.md .......... Quick reference
│  ├─ README.md ....................... Project overview
│  ├─ CLAUDE.md ....................... Architecture (16+ effects)
│  └─ SETUP_COMPLETE.md ............... Solution summary
│
├─ PROJECT FILES
│  ├─ CMakeLists.txt .................. Build configuration
│  ├─ src/ ............................ Source code
│  ├─ tests/ .......................... Test suite
│  └─ presets/ ........................ Example presets
│
└─ build/ (Created during build)
   ├─ Release/
   │  ├─ amplitron.exe ................ GUI application
   │  └─ amplitron-tests.exe .......... Test suite
   └─ ... (other build artifacts)
```

---

## ⚡ TL;DR (Too Long; Didn't Read)

**Just do this:**

```powershell
# Option 1: Automatic (recommended for first-time)
build.bat

# Option 2: If that didn't work, run this interactive menu
powershell -ExecutionPolicy Bypass -File amplitron_setup.ps1
```

Then run the `.exe` it creates!

---

## 🆘 Getting Help

| Problem              | Solution                                                                 |
| -------------------- | ------------------------------------------------------------------------ |
| "Something missing?" | Run `check_setup.bat`                                                    |
| "Build failed?"      | Read `BUILD_WINDOWS.md` troubleshooting section                          |
| "Don't understand?"  | Read `SETUP_FLOWCHART.md` for a visual guide                             |
| "Want details?"      | Read `BUILD_WINDOWS.md`                                                  |
| "Still stuck?"       | Open GitHub issue: https://github.com/sudip-mondal-2002/Amplitron/issues |

---

## 🎯 Next Step

**Pick your setup method and run the command:**

| I want to...            | Run this                                                                  |
| ----------------------- | ------------------------------------------------------------------------- |
| Just build it           | `build.bat`                                                               |
| See interactive menu    | `powershell -ExecutionPolicy Bypass -File amplitron_setup.ps1`            |
| Auto-install everything | `powershell -ExecutionPolicy Bypass -File install_dependencies_choco.ps1` |
| Check what I have       | `check_setup.bat`                                                         |
| Do it manually          | Read `BUILD_WINDOWS.md`                                                   |

**That's it!** Pick one and run it. 🎸

---

**Questions?** Read one of the docs below. Still confused? Open an issue on GitHub.

- **BUILD_WINDOWS.md** — Complete reference
- **SETUP_FLOWCHART.md** — Visual decision tree
- **QUICK_START_WINDOWS.md** — Command reference
- **CLAUDE.md** — Architecture & effects overview
