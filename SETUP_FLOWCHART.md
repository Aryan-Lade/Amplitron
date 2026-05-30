# AMPLITRON - WINDOWS SETUP FLOWCHART

```
╔═══════════════════════════════════════════════════════════════╗
║                    AMPLITRON ON WINDOWS                      ║
║              Complete Setup & Build Guide                    ║
╚═══════════════════════════════════════════════════════════════╝


📋 STEP 1: CHOOSE YOUR SETUP PATH
═══════════════════════════════════════════════════════════════

┌─ BEGINNERS / JUST WANT TO BUILD ──────────────────────┐
│ Run: build.bat                                         │
│ Time: 5-30 minutes (depending on downloads)           │
│ What it does:                                          │
│  • Checks for CMake                                    │
│  • Downloads external headers                         │
│  • Configures & builds automatically                  │
│  • Shows you where the .exe is                        │
└────────────────────────────────────────────────────────┘

┌─ INTERMEDIATE / WANT TO UNDERSTAND ────────────────────┐
│ Run: powershell -ExecutionPolicy Bypass `             │
│      -File amplitron_setup.ps1                         │
│ Time: 5-30 minutes                                     │
│ What it does:                                          │
│  • Interactive menu (1-6 options)                      │
│  • You choose each step                                │
│  • Clear feedback at each stage                        │
└────────────────────────────────────────────────────────┘

┌─ ADVANCED / WANT FULL AUTO + INSTALL ──────────────────┐
│ Run: powershell -ExecutionPolicy Bypass `             │
│      -File install_dependencies_choco.ps1              │
│ Note: Requires admin + Chocolatey                      │
│ Time: 10-60 minutes (includes tool installation)      │
│ What it does:                                          │
│  • Auto-installs CMake, VS2022, PortAudio, SDL2       │
│  • Installs Chocolatey if needed                       │
│  • Builds the project                                  │
└────────────────────────────────────────────────────────┘

┌─ MANUAL / WANT TO UNDERSTAND EVERYTHING ───────────────┐
│ Read: BUILD_WINDOWS.md                                 │
│ Time: 30-60 minutes                                    │
│ What you'll do:                                        │
│  • Manually install each tool                          │
│  • Run CMake commands yourself                         │
│  • Full control and understanding                      │
└────────────────────────────────────────────────────────┘


📊 DECISION TREE
═══════════════════════════════════════════════════════════════

                        START
                         │
                    Do you have:
                         │
        ┌────────────────┼────────────────┐
        │                │                │
    NO CMake        YES CMake       HAS ADMIN?
        │                │            /    \
        │                │           Y      N
        ▼                ▼            │      │
    build.bat    check_setup.bat      │      │
        │                │           ▼      ▼
        │                │         choco  BUILD_WINDOWS.md
        │                │          script    (manual)
        │                │            │
        └────────┬───────┴────────────┘
                 │
        Missing Dependencies?
                 │
            ┌────┴────┐
           YES       NO
            │         │
            ▼         ▼
         Install   build.bat
           tools      │
            │         │
            ▼         ▼
        build.bat   SUCCESS!
            │
            ▼
        SUCCESS!


🎯 QUICK COMMANDS
═══════════════════════════════════════════════════════════════

SIMPLEST (just build):
  > build.bat

CHECK YOUR SETUP:
  > check_setup.bat

AUTO-INSTALL TOOLS (admin required):
  > powershell -ExecutionPolicy Bypass -File install_dependencies_choco.ps1

INTERACTIVE MENU:
  > powershell -ExecutionPolicy Bypass -File amplitron_setup.ps1

DETAILED AUTO-BUILD:
  > powershell -ExecutionPolicy Bypass -File setup_and_build_windows.ps1

MANUAL BUILD (if you know CMake):
  > mkdir build && cd build
  > cmake -DCMAKE_BUILD_TYPE=Release ..
  > cmake --build . --config Release --parallel


✅ AFTER SUCCESSFUL BUILD
═══════════════════════════════════════════════════════════════

EXECUTABLE LOCATION:
  build\Release\amplitron.exe

RUN THE GUI:
  > build\Release\amplitron.exe

TEST CLI:
  > build\Release\amplitron.exe --help
  > build\Release\amplitron.exe --version

RUN TESTS (105+ tests):
  > build\Release\amplitron-tests.exe


❌ TROUBLESHOOTING QUICK FIXES
═══════════════════════════════════════════════════════════════

ISSUE: "CMake not found"
FIX:   choco install cmake -y
       Restart PowerShell

ISSUE: "Visual Studio not found"
FIX:   choco install visualstudio2022community -y
       (Or download from https://visualstudio.microsoft.com/)

ISSUE: "PortAudio/SDL2 not found"
FIX:   choco install portaudio sdl2 -y
       Restart PowerShell

ISSUE: Build fails with linker errors
FIX:   Read BUILD_WINDOWS.md [Dependency Installation] section
       Try using vcpkg (Method A in BUILD_WINDOWS.md)

ISSUE: "Need admin but don't have it"
FIX:   Use manual installation (see BUILD_WINDOWS.md Method B)
       Or extract .zip dependencies to C:\Program Files\


📚 DOCUMENTATION FILES
═══════════════════════════════════════════════════════════════

SETUP_COMPLETE.md              ← You are here! Overview
BUILD_WINDOWS.md               ← Detailed build guide
QUICK_START_WINDOWS.md         ← Quick reference
README.md                      ← Project overview
CLAUDE.md                      ← Architecture (16+ effects)
CMakeLists.txt                 ← Build configuration


🔧 FILES I CREATED FOR YOU
═══════════════════════════════════════════════════════════════

build.bat
  → Simplest one-click build
  → Recommended for beginners

check_setup.bat
  → Quick environment diagnostic
  → Shows what's installed/missing

amplitron_setup.ps1
  → Interactive menu system
  → Choose what to do step-by-step

setup_and_build_windows.ps1
  → Detailed automated build
  → Shows detailed feedback

install_dependencies_choco.ps1
  → Auto-installs all dependencies
  → Requires admin + Chocolatey

BUILD_WINDOWS.md
  → Complete reference guide
  → All options, all solutions

QUICK_START_WINDOWS.md
  → One-page quick reference
  → Commands and troubleshooting


🎮 WHAT YOU'RE BUILDING
═══════════════════════════════════════════════════════════════

Amplitron = Professional Guitar Amplifier Simulator

Features:
  ✓ 16+ studio-quality effects
  ✓ Ultra-low latency (~1.3ms)
  ✓ Visual drag-&-drop pedal board
  ✓ MIDI hardware controller support
  ✓ Preset save/load system
  ✓ WAV recording
  ✓ Chromatic tuner
  ✓ Spectrum analyzer
  ✓ Undo/redo history

Platforms:
  ✓ Windows
  ✓ macOS
  ✓ Linux
  ✓ Android
  ✓ iOS
  ✓ Web (browser)


🚀 FINAL CHECKLIST
═══════════════════════════════════════════════════════════════

Before running, make sure:

□ You're in the AMPLITRON root directory
□ You can see these files: CMakeLists.txt, README.md, src/

Then:

□ Choose your setup path (above)
□ Run the appropriate script
□ Follow any prompts
□ Wait for build to complete
□ Check for build\Release\amplitron.exe

After building:

□ Run: build\Release\amplitron.exe
□ See the GUI window open
□ Go to File → Settings
□ Select audio devices
□ Plug in your guitar (via USB)
□ Play!


💡 TIPS
═══════════════════════════════════════════════════════════════

• If you're unsure, run: check_setup.bat first
• All scripts have built-in error handling
• Scripts will tell you exactly what's wrong
• Restart PowerShell after installing tools
• Use Developer PowerShell for VS2022 if having issues
• Read the colored output - red = error, green = success


📞 GETTING HELP
═══════════════════════════════════════════════════════════════

Issue:                          Try This:
─────────────────────────────────────────────────────────────
"I'm lost"                      → Read SETUP_COMPLETE.md (this file)
"Something is missing"          → Run check_setup.bat
"Build failed"                  → Read BUILD_WINDOWS.md Troubleshooting
"Want to understand more"       → Read CLAUDE.md (architecture)
"Just want to build"            → Run build.bat

GitHub Issues: https://github.com/sudip-mondal-2002/Amplitron/issues
Website:      https://sudip-mondal-2002.github.io/Amplitron/


═════════════════════════════════════════════════════════════════
You've got this! Pick a path above and run the script. 🎸
═════════════════════════════════════════════════════════════════
```
