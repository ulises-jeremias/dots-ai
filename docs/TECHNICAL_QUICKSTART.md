# Technical Quickstart

This guide is for engineers who want to bootstrap, validate, and operate the workstation baseline quickly.

## Prerequisites

- `git`
- `chezmoi`
- Network access to the repository remote

## 1) Clone and initialize

```bash
git clone git@github.com:ulises-jeremias/dots-ai.git
cd internal-workstation
chezmoi init --source "$PWD/home"
```

## Optional: opt-in secrets via `~/.config/dots-ai/env.d/`

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

## 2) Preview and apply

```bash
chezmoi apply --dry-run
chezmoi apply
```

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
