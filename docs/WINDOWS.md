# Windows Setup Guide

> dots-ai on Windows

> [!TIP]
> **WSL2 is the recommended setup.** It runs the exact same Ubuntu-based workstation as Linux/macOS users, including all install scripts, the full `chezmoi` workflow, and AI tools.

---

## Overview

Windows is supported via two modes:

| Mode | What you get | Recommended for |
|------|-------------|-----------------|
| **WSL2 + Ubuntu** (full) | Complete workstation: chezmoi, toolchain, AI agents, dots-* scripts | Everyone who can install WSL2 |
| **Git Bash only** (basic) | dots-* scripts in Git Bash, AI skills/agents installed | Quick start, no WSL2 |
| **Skills only** | AI skills + agents for Claude, OpenCode, Cursor, Windsurf — no install required | Non-technical users, any Windows |

WSL2 is strongly recommended. It runs the exact same Ubuntu-based setup as the rest of the team, including all install scripts and the full `chezmoi` workflow.

---

## Option 1: Full Setup via WSL2 (Recommended)

### Prerequisites

- Windows 10 version 2004+ or Windows 11
- PowerShell 5.1 or PowerShell 7+

### Step 1: Enable WSL2

Open PowerShell as Administrator and run:

```powershell
wsl --install
```

This installs WSL2 + Ubuntu automatically. **Restart your machine** when prompted.

After restart, open **Ubuntu** from the Start Menu and complete the initial user setup (username and password).

### Step 2: Install the workstation

Open Ubuntu (WSL2) and run:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/ulises-jeremias/dots-ai/main/install.sh)
```

Or use the PowerShell installer (auto-detects WSL2):

```powershell
irm https://raw.githubusercontent.com/ulises-jeremias/dots-ai/main/install.ps1 | iex
```

### Step 3: Validate

Open a new Ubuntu terminal and run:

```bash
dots-doctor
```

Expected output:

```
[dots-doctor] checks completed: 15/15 passed
[dots-doctor] result: COMPLIANT
```

### Step 4: Use your AI tool

All AI agents are installed and ready. Launch Claude Code, OpenCode, Cursor, or Windsurf from inside WSL2 or point them at your WSL2 filesystem.

```bash
# From inside WSL2
opencode

# Or Claude Code
claude
```

---

## Option 2: Git Bash Only (Basic)

> [!NOTE]
> Git Bash mode installs **only** the `dots-*` helper scripts and AI assets. The full toolchain (chezmoi, Python, Node, Docker) is **not** available. Use WSL2 for the complete experience.

If you cannot install WSL2, you can get the `dots-*` scripts running in Git Bash.

### Prerequisites

Install [Git for Windows](https://git-scm.com/download/win), which includes Git Bash:

```powershell
winget install Git.Git
```

### Install

Run in PowerShell:

```powershell
irm https://raw.githubusercontent.com/ulises-jeremias/dots-ai/main/install.ps1 | iex
```

This installs:
- All `dots-*` scripts to `%USERPROFILE%\.local\bin\`
- `easy-options` library to `%USERPROFILE%\.local\lib\dots-ai\`
- dots-ai AI assets (skills, prompts, templates) to `%USERPROFILE%\.local\share\dots-ai\`

Or force Git Bash mode explicitly:

```powershell
.\install.ps1 -Mode GitBash
```

### Use dots-* scripts in Git Bash

Open Git Bash and:

```bash
dots-doctor
dots-skills list
dots-loadenv --show
```

> **Note:** The full toolchain (chezmoi, pacman/apt packages, Python/Node baseline) is NOT installed in Git Bash mode. Only the dots-* helper scripts and AI assets are available.

---

## Option 3: AI Skills Only (No Install Required)

For non-technical users or anyone who just wants the AI skills and agents without the full workstation setup.

> [!TIP]
> Prefer a **step-by-step copy-paste walkthrough** (screenshots-ready, with troubleshooting)? Use [GUIDED_AI_INSTALL.md](GUIDED_AI_INSTALL.md) — same installer, friendlier path.

### PowerShell (Windows)

```powershell
irm https://github.com/ulises-jeremias/dots-ai/releases/latest/download/install-skills.ps1 | iex
```

This installs skills and agents for all supported AI tools.

For a specific tool only:

```powershell
$env:DOTS_AI_TOOL = "claude"
irm https://github.com/ulises-jeremias/dots-ai/releases/latest/download/install-skills.ps1 | iex
```

### Bash / WSL2

```bash
curl -fsSL https://github.com/ulises-jeremias/dots-ai/releases/latest/download/install-skills.sh | sh
```

### Manual (no scripting)

1. Go to [Releases](https://github.com/ulises-jeremias/dots-ai/releases/latest)
2. Download the appropriate ZIP for your tool:
   - `dots-ai-agents-claude-vX.Y.Z.zip` — Claude Code / Claude Desktop
   - `dots-ai-agents-opencode-vX.Y.Z.zip` — OpenCode
   - `dots-ai-agents-cursor-vX.Y.Z.zip` — Cursor
   - `dots-ai-agents-windsurf-vX.Y.Z.zip` — Windsurf
3. Extract and copy as described in the release notes

#### Claude Desktop (Windows)

Extract `dots-ai-agents-claude-vX.Y.Z.zip` and copy:
- `dot_claude\agents\` → `%USERPROFILE%\.claude\agents\`

If `settings.json` doesn't exist yet, also copy:
- `dot_claude\settings.json` → `%USERPROFILE%\.claude\settings.json`

#### OpenCode (Windows)

Extract `dots-ai-agents-opencode-vX.Y.Z.zip` and copy:
- `dot_config\opencode\agents\` → `%APPDATA%\opencode\agents\`
- `dot_config\opencode\skills\` → `%APPDATA%\opencode\skills\`

---

## Troubleshooting

> [!WARNING]
> If you're behind a corporate proxy or firewall, direct downloads may fail. See the proxy workaround at the end of this section.

### WSL2 not recognized after install

```powershell
# Enable Windows Subsystem for Linux feature
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

# Enable Virtual Machine Platform
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

# Set WSL2 as default
wsl --set-default-version 2
```

### dots-doctor shows NON-COMPLIANT in WSL2

Most failures in WSL2 are missing optional tools. Re-run `chezmoi apply` to install them:

```bash
chezmoi apply --source=. -c ~/.config/chezmoi/dots-ai.toml
```

Or install specific tools:

```bash
# Install a specific tool manually (inside WSL2 Ubuntu)
sudo apt-get install -y <tool>
```

### PATH not updated after Git Bash install

Close and reopen all terminal windows. If still not working, manually add to PATH:

```powershell
$env:PATH = "${env:USERPROFILE}\.local\bin;${env:PATH}"
```

Or add permanently via System Properties → Environment Variables.

### Scripts not executable in Git Bash

Git Bash sometimes doesn't respect the executable bit. Run:

```bash
chmod +x ~/.local/bin/dots-*
```

### Proxy or corporate network issues

Some environments block direct downloads. If `curl` fails:

1. Download the installer manually from GitHub
2. Transfer to your machine
3. Run `.\install.ps1` from the local copy

---

## Platform Support Matrix

| Feature | WSL2 (Ubuntu) | Git Bash | PowerShell |
|---------|:---:|:---:|:---:|
| `chezmoi apply` (full install) | ✓ | — | — |
| `dots-*` scripts | ✓ | ✓ | — |
| AI skills & agents install | ✓ | ✓ | ✓ |
| Python toolchain (uv, pipx) | ✓ | — | — |
| Node toolchain (fnm, pnpm) | ✓ | — | — |
| Docker | ✓ | — | — |
| `dots-doctor` | ✓ | ✓ (basic) | — |

---

## See Also

- [TECHNICAL_QUICKSTART.md](TECHNICAL_QUICKSTART.md) — Linux/macOS full setup
- [PROFILES.md](PROFILES.md) — Profile selection guide
- [CLI_HELPERS.md](CLI_HELPERS.md) — dots-* script reference
- [AI_LAYER.md](AI_LAYER.md) — AI skills and agents overview
