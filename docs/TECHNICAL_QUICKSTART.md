# Technical Quickstart

This guide is for engineers who want to bootstrap, validate, and operate the workstation baseline quickly.

## Prerequisites

- `git`
- `chezmoi`
- Network access to the repository remote

> [!NOTE]
> On macOS, install chezmoi with `brew install chezmoi`. On Linux, use `sh -c "$(curl -fsLS get.chezmoi.io)"`.

## 1) Clone and initialize

```bash
git clone git@github.com:ulises-jeremias/dots-ai.git
cd dots-ai
chezmoi init --source "$PWD/home"
```

## Optional: opt-in secrets via `~/.config/dots-ai/env.d/`

This baseline supports **opt-in, globally-sourced** environment variables (tokens, API keys, etc.)
via `~/.config/dots-ai/env.d/*.env`.

> [!IMPORTANT]
> Never commit actual tokens. The `env.d/` directory is local-only and not managed by chezmoi.

To enable JIRA env vars (required only if you enable the JIRA Assistant skill pack):

```bash
mkdir -p ~/.config/dots-ai/env.d
$EDITOR ~/.config/dots-ai/env.d/jira.env
```

Example `jira.env` content:

```bash
export JIRA_SITE_URL="https://your-company.atlassian.net"
export JIRA_EMAIL="you@company.com"
export JIRA_API_TOKEN="your-api-token-here"
```

## 2) Preview and apply

```bash
chezmoi apply --dry-run
chezmoi apply
```

> [!TIP]
> Always preview with `--dry-run` before applying, especially on a machine that already has configurations you want to preserve.

## 3) Validate baseline

```bash
dots-doctor
```

If non-compliance is reported, follow the command output and contact the Technology team when needed.

## 4) Keep your baseline updated

```bash
dots-update-check
chezmoi update
```

## 5) Useful operational commands

- `dots-bootstrap --apply`: run a guided bootstrap flow.
- `dots-sync-ai`: confirm AI assets exist in expected directories.
- `dots-doctor`: validate required tooling and expected files.
- `dots-skills list`: show installed skills and their symlink status.
- `dots-skills check`: verify required tools for each skill are available.

## 6) Uninstalling

To remove the dots-ai baseline:

```bash
# Preview managed files
chezmoi managed

# Remove all chezmoi-managed files
chezmoi purge

# Clean up remaining directories
rm -rf ~/.local/share/dots-ai/
rm -rf ~/.config/dots-ai/
rm -f ~/.local/bin/dots-*
```

> [!WARNING]
> `chezmoi purge` removes **all** chezmoi-managed files. If chezmoi manages other dotfiles on your machine, selectively remove dots-ai files instead.

See the [Troubleshooting wiki page](wiki/TROUBLESHOOTING.md#uninstalling-dots-ai) for detailed uninstall steps including per-tool cleanup.

---

## See Also

- [CHEZMOI_WORKFLOW.md](CHEZMOI_WORKFLOW.md) — Detailed chezmoi apply/update workflow
- [PROFILES.md](PROFILES.md) — Profile selection and package groups
- [CLI_HELPERS.md](CLI_HELPERS.md) — Full `dots-*` command reference
- [WINDOWS.md](WINDOWS.md) — Windows-specific setup (WSL2, Git Bash, skills-only)
- [AI_LAYER.md](AI_LAYER.md) — AI skills and agents overview
