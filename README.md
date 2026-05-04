<div align="center">

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="static/hero-banner.svg">
  <source media="(prefers-color-scheme: light)" srcset="static/hero-banner.svg">
  <img alt="dots-ai" src="static/hero-banner.svg" width="800">
</picture>

<br>

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](LICENSE)
[![chezmoi](https://img.shields.io/badge/chezmoi-managed-blue?style=for-the-badge&logo=chezmoi&logoColor=white)](https://www.chezmoi.io/)
[![dots-ai](https://img.shields.io/badge/dots-ai-public-7c3aed?style=for-the-badge&logo=github&logoColor=white)](https://github.com/ulises-jeremias)

<br>

[![Validate Workstation](https://github.com/ulises-jeremias/dots-ai/actions/workflows/validate-workstation.yml/badge.svg)](https://github.com/ulises-jeremias/dots-ai/actions/workflows/validate-workstation.yml)
[![Devcontainer Chezmoi Validate](https://github.com/ulises-jeremias/dots-ai/actions/workflows/devcontainer-chezmoi-validate.yml/badge.svg)](https://github.com/ulises-jeremias/dots-ai/actions/workflows/devcontainer-chezmoi-validate.yml)
[![Pre-commit](https://github.com/ulises-jeremias/dots-ai/actions/workflows/pre-commit.yml/badge.svg)](https://github.com/ulises-jeremias/dots-ai/actions/workflows/pre-commit.yml)
[![MegaLinter v9](https://github.com/ulises-jeremias/dots-ai/actions/workflows/megalinter-v9.yml/badge.svg)](https://github.com/ulises-jeremias/dots-ai/actions/workflows/megalinter-v9.yml)
[![Security Scan](https://github.com/ulises-jeremias/dots-ai/actions/workflows/security-scan.yml/badge.svg)](https://github.com/ulises-jeremias/dots-ai/actions/workflows/security-scan.yml)
[![Release AI Assets](https://github.com/ulises-jeremias/dots-ai/actions/workflows/release-ai-assets.yml/badge.svg)](https://github.com/ulises-jeremias/dots-ai/actions/workflows/release-ai-assets.yml)

<br>

[Wiki](https://github.com/ulises-jeremias/dots-ai/wiki) · [Quick Start](https://github.com/ulises-jeremias/dots-ai/wiki/TECHNICAL_QUICKSTART) · [Integrations](https://github.com/ulises-jeremias/dots-ai/wiki/INTEGRATIONS) · [Technical Docs](docs/) · [Contributing](CONTRIBUTING.md)

</div>

---

`dots-ai` standardizes AI developer tooling across Linux, macOS, and Windows. It provides a chezmoi-managed workstation layer with AI skills, agents, CLI helpers, MCP templates, and dev companion tooling.

For end-user setup and day-to-day usage, start with the wiki. The repository `docs/` directory is reserved for technical references, architecture, maintainer contracts, and ADRs.

## Start Here

| Need | Go to |
|---|---|
| Install the workstation | [Wiki Quick Start](https://github.com/ulises-jeremias/dots-ai/wiki/TECHNICAL_QUICKSTART) |
| Install only AI skills and agents | [Guided AI Install](https://github.com/ulises-jeremias/dots-ai/wiki/GUIDED_AI_INSTALL) |
| Choose profiles or answer prompts | [Profiles](https://github.com/ulises-jeremias/dots-ai/wiki/PROFILES) and [Questionnaire](https://github.com/ulises-jeremias/dots-ai/wiki/QUESTIONNAIRE) |
| Configure credentials | [Credentials](https://github.com/ulises-jeremias/dots-ai/wiki/CREDENTIALS) |
| Configure ClickUp, Jira, Figma, Slack, etc. | [Integrations](https://github.com/ulises-jeremias/dots-ai/wiki/INTEGRATIONS) |
| Use `dots-*` commands | [CLI](https://github.com/ulises-jeremias/dots-ai/wiki/CLI) |
| Troubleshoot setup | [Troubleshooting](https://github.com/ulises-jeremias/dots-ai/wiki/TROUBLESHOOTING) |
| Understand architecture | [Technical Docs](docs/) |

## What It Provides

| Area | Outcome |
|---|---|
| Workstation bootstrap | Profile-driven chezmoi source state |
| AI layer | Shared skills and agents for supported AI coding tools |
| Integrations | Guided setup for GitHub, GitLab, ClickUp, Jira, Confluence, Slack, Figma, Linear, and Notion |
| CLI helpers | `dots-*` commands for validation, skills, updates, env loading, and dev companion workflows |
| MCP templates | Provider templates under `~/.local/share/dots-ai/mcp/` after apply |
| Technical governance | Architecture docs, ADRs, validation scripts, and CI checks |

## Related Project

Pair this workstation layer with [`ai-workspace`](https://github.com/ulises-jeremias/ai-workspace) for persistent memory, indexed repositories, personas, packs, and background job orchestration.

## Repository Map

| Path | Purpose |
|---|---|
| `home/` | chezmoi source state applied to the user machine |
| `docs/wiki/` | user-facing wiki source |
| `docs/` | technical references and maintainer contracts |
| `docs/adrs/` | Architecture Decision Records |
| `scripts/` | validation, release, and install support scripts |
| `.github/workflows/` | CI and release automation |

## Security

Never commit credentials, tokens, or private keys. Use the wiki credentials flow for local secrets: [Credentials](https://github.com/ulises-jeremias/dots-ai/wiki/CREDENTIALS).
