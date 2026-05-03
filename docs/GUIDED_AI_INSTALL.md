# Guided AI Install (non-developers)

> Install dots-ai AI skills, agents, and editor rules in a few copy-paste steps.
> No git clone, no chezmoi, no developer background required.

This guide installs **only the AI layer** (skills, agents, editor rules, Copilot custom instructions). If you want the **full dots-ai workstation** (shell, CLIs, language stacks, `dots-*` helpers) see the [README quick start](../README.md#quick-start) instead.

---

## Before you begin

- You need **Internet access**.
- You need **5 minutes** and the ability to copy-paste one command.
- You will install files into your **user profile** (under your home folder / `%USERPROFILE%`). Nothing is installed system-wide.
- If your company laptop blocks `curl` / PowerShell scripts, jump straight to [If something goes wrong](#if-something-goes-wrong).

> [!NOTE]
> These bundles are published to the [GitHub Releases page](https://github.com/ulises-jeremias/dots-ai/releases/latest). The commands below always pull the **latest** release.

---

## Pick your system

### Windows

1. Press **`Windows + X`** → click **"Terminal"** or **"PowerShell"**.
2. Paste this single line and press **Enter**:

   ```powershell
   irm https://github.com/ulises-jeremias/dots-ai/releases/latest/download/install-skills.ps1 | iex
   ```

3. When it finishes you should see a green `Installation complete.` message.

> [!TIP]
> If Windows SmartScreen or your antivirus interrupts the download, read [If something goes wrong](#if-something-goes-wrong) below — this is normal on corporate laptops.

### macOS

1. Open **Terminal** (`Cmd + Space`, type `Terminal`, press **Return**).
2. Paste this single line and press **Return**:

   ```bash
   curl -fsSL https://github.com/ulises-jeremias/dots-ai/releases/latest/download/install-skills.sh | sh
   ```

3. Wait for `Installation complete.` at the end.

### Linux / WSL2

Same as macOS:

```bash
curl -fsSL https://github.com/ulises-jeremias/dots-ai/releases/latest/download/install-skills.sh | sh
```

---

## Install for only one tool

By default the installer sets up skills for **every supported AI tool**. If you only use one, pass its name:

| Tool | Linux / macOS / WSL2 | Windows (PowerShell) |
|------|----------------------|----------------------|
| **Claude Desktop / Code** | `install-skills.sh ... \| sh -s -- --tool claude` | `$env:DOTS_AI_TOOL="claude"; irm ... \| iex` |
| **Cursor** | `install-skills.sh ... \| sh -s -- --tool cursor` | `$env:DOTS_AI_TOOL="cursor"; irm ... \| iex` |
| **OpenCode** | `install-skills.sh ... \| sh -s -- --tool opencode` | `$env:DOTS_AI_TOOL="opencode"; irm ... \| iex` |
| **Windsurf** | `install-skills.sh ... \| sh -s -- --tool windsurf` | `$env:DOTS_AI_TOOL="windsurf"; irm ... \| iex` |
| **GitHub Copilot** | `install-skills.sh ... \| sh -s -- --tool copilot` | `$env:DOTS_AI_TOOL="copilot"; irm ... \| iex` |

The `--tool` flag also accepts `all` to mean "every tool".

---

## What you should see

A successful run prints output similar to:

```text
[install-skills] version: v0.1.4
[install-skills] downloading skills package...
[install-skills] OK: skills installed to /home/you/.local/share/dots-ai/skills
[install-skills] installing agents for Cursor...
[install-skills] OK: Cursor rules installed to /home/you/.cursor/rules/
[install-skills] Installation complete.
```

Warnings that a specific tool package "could not be downloaded" are safe to ignore when that tool is not in use. Errors end with a clear `ERROR:` line.

---

## Verify it worked

Run the prerequisite check bundled with this repo — it is read-only and also prints whether the skills directory exists:

```bash
# Linux / macOS / WSL2
bash <(curl -fsSL https://raw.githubusercontent.com/ulises-jeremias/dots-ai/main/scripts/check-ai-install-prereqs.sh)
```

```powershell
# Windows (PowerShell)
irm https://raw.githubusercontent.com/ulises-jeremias/dots-ai/main/scripts/check-ai-install-prereqs.ps1 | iex
```

You should see `OK` lines ending with a summary like `AI install prereq check: READY`.

> [!TIP]
> You can run this checker **before** installing to confirm your machine meets the basic requirements.

---

## After installing

1. **Quit and re-open** the AI tool you use (Cursor, Claude, VS Code, OpenCode, etc.). New rules and instructions are loaded on startup.
2. In Cursor / Windsurf / Claude the AI should now reference dots-ai skills automatically when relevant.
3. For **GitHub Copilot** in VS Code: ensure you are signed in to Copilot; custom instructions are picked up from `~/.github/copilot-instructions.md` (or `%USERPROFILE%\.github\copilot-instructions.md`).

---

## If something goes wrong

| Symptom | What to do |
|---------|------------|
| `irm ... cannot be loaded because running scripts is disabled on this system` | PowerShell is locked down. Run it once as: `powershell -ExecutionPolicy Bypass -Command "irm https://... \| iex"`. Do **not** change system-wide policy. |
| `curl: command not found` (older macOS) | Use `wget`: `wget -qO - https://.../install-skills.sh \| sh` |
| `SSL certificate` / `could not resolve host` | You are likely behind a **corporate proxy or VPN**. Connect to VPN and retry, or ask IT for proxy variables (`HTTPS_PROXY`). |
| Antivirus or SmartScreen blocks the download | Choose **"Keep"** / **"Run anyway"** — the scripts live in this public repository and only write under your user profile. |
| Cursor / Claude still doesn't pick up changes | Close **all** windows of that tool (check the system tray) and reopen. |
| `No such file or directory: ~/.local/share/dots-ai/skills` | The install did not finish. Re-run the install command from [Pick your system](#pick-your-system) and watch for `ERROR:` lines. |

If you are still stuck, ask in the **#tech-support** Slack channel with:

- Your OS (Windows / macOS / Linux).
- The **last 20 lines** of output from the installer.
- The output of the `check-ai-install-prereqs` script.

---

## What actually gets installed (reference)

| Path | Purpose |
|------|---------|
| `~/.local/share/dots-ai/skills/` | Shared skills library (every tool reads from here) |
| `~/.claude/agents/` | Claude Code / Claude Desktop agents |
| `~/.config/opencode/agents/` | OpenCode agents |
| `~/.cursor/rules/` | Cursor rules |
| `~/.windsurf/rules/` | Windsurf rules |
| `~/.github/copilot-instructions.md` | GitHub Copilot custom instructions |

On Windows the equivalents live under `%USERPROFILE%\…` (and `%APPDATA%\opencode\` for OpenCode).

---

## Related docs

- [`docs/RELEASES.md`](RELEASES.md) — how release bundles are built and versioned.
- [`docs/WINDOWS.md`](WINDOWS.md) — deeper Windows setup notes.
- [`README.md`](../README.md) — full dots-ai workstation setup (requires developer tooling).
