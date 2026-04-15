# Windows Setup

Full Windows installation guide. For complete details, see [docs/WINDOWS.md](https://github.com/ulises-jeremias/dots-ai/blob/main/docs/WINDOWS.md).

## Installation modes

| Mode | Best for | Requirements |
|------|----------|-------------|
| **WSL2** (recommended) | Full workstation experience | Windows 10/11 with WSL2 |
| **Git Bash** | Skills + agents only | Git for Windows |
| **Skills only** | Minimal — just AI skills | PowerShell 5.1+ |

## Quick install (WSL2)

```powershell
# In PowerShell (auto-detects WSL2)
irm https://raw.githubusercontent.com/ulises-jeremias/dots-ai/main/install.ps1 | iex
```

> [!IMPORTANT]
> After installation in WSL2, open a WSL terminal and run `dots-doctor` to validate.

## Manual install

```powershell
# Clone the repo
git clone https://github.com/ulises-jeremias/dots-ai.git
cd dots-ai

# Run installer with explicit mode
.\install.ps1 -Mode wsl2     # WSL2 mode
.\install.ps1 -Mode gitbash  # Git Bash mode
.\install.ps1 -Mode skills   # Skills only
```

## Platform matrix

| Feature | WSL2 | Git Bash | Skills Only |
|---------|:----:|:--------:|:-----------:|
| Full chezmoi apply | Yes | No | No |
| AI skills + agents | Yes | Yes | Yes |
| CLI helpers (`dots-*`) | Yes | Partial | No |
| Dev companion | Yes | No | No |
| LLM server | Yes | No | No |

## Troubleshooting

| Issue | Solution |
|-------|---------|
| WSL2 not installed | Run `wsl --install` in admin PowerShell |
| Permission denied | Run PowerShell as Administrator |
| chezmoi not found | Install via `winget install twpayne.chezmoi` |
| Skills not synced | Run `dots-skills sync` in WSL2 terminal |

## See also

- [Technical Quickstart](TECHNICAL_QUICKSTART) — Linux/macOS setup
- [Profiles](PROFILES) — profile selection
