# Technical Quickstart

> Step-by-step engineer onboarding for the dots-ai workstation.

---

This guide is for engineers who want to bootstrap, validate, and operate the workstation baseline quickly.

## Prerequisites

- `git` — installed and configured
- `chezmoi` — installed ([chezmoi.io/install](https://www.chezmoi.io/install/))
- Network access to the repository remote
- SSH key added to GitHub

---

## 1) Clone and initialize

```bash
git clone git@github.com:ulises-jeremias/dots-ai.git
cd dots-ai
chezmoi init --source=. -c ~/.config/chezmoi/dots-ai.toml
```

> [!TIP]
> For a one-liner install, use: `bash <(curl -fsSL https://raw.githubusercontent.com/ulises-jeremias/dots-ai/main/install.sh)`

---

## 2) Optional: opt-in secrets via `~/.config/dots-ai/env.d/`

This baseline supports **opt-in, globally-sourced** environment variables (tokens, API keys, etc.)
via `~/.config/dots-ai/env.d/*.env`.

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

> [!CAUTION]
> Never commit API tokens or secrets. The `env.d/` directory is for local machine use only.

---

## 3) Preview and apply

```bash
chezmoi apply --source=. -c ~/.config/chezmoi/dots-ai.toml --dry-run
chezmoi apply --source=. -c ~/.config/chezmoi/dots-ai.toml
```

---

## 4) Validate baseline

```bash
dots-doctor
```

If non-compliance is reported, follow the command output and contact the Technology team when needed.

> [!IMPORTANT]
> Always open a **new terminal** after `chezmoi apply` to ensure PATH updates take effect.

---

## 5) Keep your baseline updated

```bash
dots-update-check
chezmoi update
dots-doctor
```

---

## 6) Useful operational commands

| Command | Purpose |
|---------|---------|
| `dots-bootstrap --apply` | Run a guided bootstrap flow |
| `dots-sync-ai` | Confirm AI assets exist in expected directories |
| `dots-doctor` | Validate required tooling and expected files |
| `dots-skills list` | Show installed skills and their status |
| `dots-skills sync` | Regenerate skill symlinks after apply |

---

## Uninstall

To remove the workstation baseline from your machine:

```bash
# Remove chezmoi-managed files
chezmoi purge

# Remove AI resources
rm -rf ~/.local/share/dots-ai
rm -rf ~/.local/bin/dots-*

# Remove skill symlinks
rm -rf ~/.claude/skills/ ~/.config/opencode/skills/ ~/.cursor/skills/ ~/.copilot/skills/

# Remove agent definitions
rm -rf ~/.claude/agents/ ~/.config/opencode/agents/
```

> [!WARNING]
> `chezmoi purge` removes **all** chezmoi-managed files. Review what will be removed with `chezmoi managed` before running.

---

## See Also

- [CHEZMOI_WORKFLOW.md](CHEZMOI_WORKFLOW.md) — init, apply, and update flows
- [PROFILES.md](PROFILES.md) — profile-to-package-group mapping
- [WINDOWS.md](WINDOWS.md) — Windows setup guide
- [CLI_HELPERS.md](CLI_HELPERS.md) — full `dots-*` command reference
