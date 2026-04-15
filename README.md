<div align="center">

```ocaml
dots-ai — AI Developer Workstation Layer
```

**Agents · Skills · CLI Helpers · Dev Companion · MCP Templates**

<br>

[![Stars](https://img.shields.io/github/stars/ulises-jeremias/dots-ai?style=for-the-badge&logo=starship&color=c678dd&logoColor=d9e0ee&labelColor=282a36)](https://github.com/ulises-jeremias/dots-ai/stargazers)
[![License](https://img.shields.io/github/license/ulises-jeremias/dots-ai?style=for-the-badge&logo=github&color=ee999f&logoColor=d9e0ee&labelColor=282a36)](LICENSE)
[![Issues](https://img.shields.io/github/issues/ulises-jeremias/dots-ai?style=for-the-badge&logo=gitbook&color=7aa2f7&logoColor=d9e0ee&labelColor=282a36)](https://github.com/ulises-jeremias/dots-ai/issues)
[![Last Commit](https://img.shields.io/github/last-commit/ulises-jeremias/dots-ai?style=for-the-badge&logo=github&color=9ece6a&logoColor=d9e0ee&labelColor=282a36)](https://github.com/ulises-jeremias/dots-ai/commits)

<br>

[![Validate](https://github.com/ulises-jeremias/dots-ai/actions/workflows/validate-workstation.yml/badge.svg)](https://github.com/ulises-jeremias/dots-ai/actions/workflows/validate-workstation.yml)
[![Pre-commit](https://github.com/ulises-jeremias/dots-ai/actions/workflows/pre-commit.yml/badge.svg)](https://github.com/ulises-jeremias/dots-ai/actions/workflows/pre-commit.yml)
[![Security](https://github.com/ulises-jeremias/dots-ai/actions/workflows/security-scan.yml/badge.svg)](https://github.com/ulises-jeremias/dots-ai/actions/workflows/security-scan.yml)
[![Release](https://github.com/ulises-jeremias/dots-ai/actions/workflows/release-ai-assets.yml/badge.svg)](https://github.com/ulises-jeremias/dots-ai/actions/workflows/release-ai-assets.yml)

<br>

![Claude Code](https://img.shields.io/badge/Claude_Code-supported-d4a574?style=flat-square&logo=anthropic&logoColor=white)
![OpenCode](https://img.shields.io/badge/OpenCode-supported-58a6ff?style=flat-square&logo=terminal&logoColor=white)
![Cursor](https://img.shields.io/badge/Cursor-supported-bc8cff?style=flat-square&logo=cursor&logoColor=white)
![Copilot CLI](https://img.shields.io/badge/Copilot_CLI-supported-7ee787?style=flat-square&logo=github&logoColor=white)
![Windsurf](https://img.shields.io/badge/Windsurf-supported-ffa657?style=flat-square&logo=codeium&logoColor=white)

<br>

[Documentation](https://github.com/ulises-jeremias/dots-ai/wiki) · [Quick Start](#-quick-start) · [Contributing](CONTRIBUTING.md) · [Docs Index](docs/)

</div>

---

Standardizes the AI developer tooling layer across **Linux**, **macOS**, and **Windows** — with profile-based installation, shared skills and agents for AI coding tools, MCP templates, and a dev companion runner.

Works **standalone** or alongside a desktop dotfiles repo (e.g. [HorneroConfig](https://github.com/ulises-jeremias/dotfiles)).

<details>
<summary><b>Table of Contents</b></summary>

- [Quick Start](#-quick-start)
- [What You Get](#-what-you-get)
- [AI Skills](#-ai-skills)
- [AI Agents](#-ai-agents)
- [CLI Helpers](#-cli-helpers)
- [MCP Templates](#-mcp-templates)
- [Documentation](#-documentation)
- [Relationship to Other Dotfiles](#-relationship-to-other-dotfiles)
- [License](#-license)

</details>

---

## Quick Start

### Linux / macOS (5 minutes)

```bash
# One-liner install
bash <(curl -fsSL https://raw.githubusercontent.com/ulises-jeremias/dots-ai/main/install.sh)

# Or manually:
git clone git@github.com:ulises-jeremias/dots-ai.git
cd dots-ai
chezmoi init --source .
chezmoi apply --dry-run   # preview
chezmoi apply             # apply

# Validate
dots-doctor
```

### Windows — WSL2 (Recommended)

```powershell
# In PowerShell (auto-detects WSL2)
irm https://raw.githubusercontent.com/ulises-jeremias/dots-ai/main/install.ps1 | iex
```

> [!TIP]
> See [docs/WINDOWS.md](docs/WINDOWS.md) for full Windows setup with 3 installation modes.

### Skills Only (no full install)

For anyone who just wants the AI skills and agents without the full toolchain:

```bash
# Linux / macOS / WSL2
curl -fsSL https://github.com/ulises-jeremias/dots-ai/releases/latest/download/install-skills.sh | sh
```

> [!IMPORTANT]
> After `chezmoi apply`, open a **new terminal** and run `dots-doctor` to validate the installation.

---

## What You Get

| Area | Outcome |
| --- | --- |
| **Workstation bootstrap** | Idempotent `chezmoi` source state with profile-driven behavior |
| **Core tooling** | Optional package installation per machine preference |
| **Language stacks** | Node, Python, Docker, AI tooling selected during init |
| **AI layer** | Shared prompts, skills, and dev companions installed globally |
| **Agentic AI setup** | 13 specialized subagents for OpenCode, Claude Code, Cursor & Windsurf — works out of the box |
| **MCP templates** | Ready-to-use provider templates (GitHub, ClickUp, Jira, Slack, Notion) |
| **Dev Companion** | LLM-powered background job runner with multi-provider support |
| **CLI helpers** | `dots-*` commands for skills management, health checks, and updates |
| **LLM server** | Local GPU-accelerated inference (vLLM + Ollama) with profile switching |
| **CI quality** | Ubuntu + Arch Linux + macOS + Windows validation |

---

## AI Skills

Skills are markdown documents that teach AI tools how to perform specific workflows. They live in `~/.local/share/dots-ai/skills/` and are symlinked to each AI tool's config directory by `dots-skills sync`.

| Skill | Purpose |
|-------|---------|
| `dev-assistant` | Repository inspection, routing, and discovery orchestration |
| `dev-companion` | Delivery workflow companion (WHAT/HOW pattern) |
| `workspace-knowledge-sync` | Session knowledge persistence |
| `github-cli-workflow` | `gh pr create --draft` with template/file body |
| `gitlab-cli-workflow` | `glab mr create --draft` with template/file body |
| `dbt-validation` | Run dbt parse/compile/test following repo docs |
| `snowflake-validation` | Read-only Snowflake validation patterns |
| `workflow-generic-project` | Delivery phases for any project |
| `workstation-triage` | Health check and diagnostics |
| `clickup-cli` | ClickUp task management via CLI |
| `slack-cli` | Official Slack CLI for app development |
| `ui-ux-pro-max` | UI/UX intelligence — 67 styles, 96 palettes, 13 stacks |

### External Skills (opt-in)

| Skill | Install |
|-------|---------|
| JIRA Assistant (14 skills) | `install_skill_jira_assistant = true` in chezmoi config |
| Confluence Assistant (17 skills) | `install_skill_confluence_assistant = true` in chezmoi config |

> [!NOTE]
> See [docs/SKILLS.md](docs/SKILLS.md) for the full skills system — manifests, registry, compatibility matrix, and publishing guide.

---

## AI Agents

13 specialized subagents installed to `~/.claude/agents/`, `~/.config/opencode/agents/`, Cursor rules, and Windsurf rules:

| Agent | Purpose |
|-------|---------|
| `dev-assistant` | Repo inspection and dev workflow orchestration |
| `architect` | System design and architecture decisions |
| `build-error-resolver` | Build, TypeScript, lint, and CI failures |
| `code-reviewer` | Code quality, security, and maintainability |
| `database-reviewer` | PostgreSQL, schema design, query optimization |
| `docs-lookup` | Framework documentation and API references |
| `e2e-runner` | Playwright end-to-end testing |
| `performance-optimizer` | Performance profiling and optimization |
| `planner` | Feature planning and task breakdown |
| `refactor-cleaner` | Dead code removal and simplification |
| `security-reviewer` | OWASP Top 10 and vulnerability detection |
| `tdd-guide` | Test-driven development workflow |
| `typescript-reviewer` | TypeScript type safety improvements |

---

## CLI Helpers

| Command | Description |
|---------|-------------|
| `dots-doctor` | Health check: validates tools, directories, and skills |
| `dots-skills list` | Show installed skills and their status per AI tool |
| `dots-skills sync` | Regenerate symlinks for all skills |
| `dots-skills install <name>` | Install a skill from the registry |
| `dots-devcompanion enqueue <id>` | Queue a background job for the LLM runner |
| `dots-devcompanion run-once` | Process the next queued job |
| `dots-llm-server start` | Start local LLM server (coding / reasoning profiles) |
| `dots-loadenv` | Load env vars from `~/.config/dots-ai/env.d/` |
| `dots-update-check` | Check if the local baseline is behind origin |
| `dots-bootstrap` | Re-run `chezmoi apply` with dry-run preview |

> [!TIP]
> See [docs/CLI_HELPERS.md](docs/CLI_HELPERS.md) for detailed subcommand reference.

---

## MCP Templates

Ready-to-use Model Context Protocol server templates in `~/.local/share/dots-ai/mcp/`:

- `github/` — GitHub MCP server
- `clickup/` — ClickUp MCP server
- `notion/` — Notion MCP server
- `slack/` — Slack MCP server

See [docs/MCP_TEMPLATES.md](docs/MCP_TEMPLATES.md) for configuration instructions.

---

## Documentation

For deeper documentation, see the [`docs/`](docs/) directory:

| Document | Topic |
|----------|-------|
| [ARCHITECTURE.md](docs/ARCHITECTURE.md) | Layered design model and source state conventions |
| [TECHNICAL_QUICKSTART.md](docs/TECHNICAL_QUICKSTART.md) | Step-by-step engineer onboarding |
| [SKILLS.md](docs/SKILLS.md) | Full skills system — manifests, registry, publishing |
| [AI_LAYER.md](docs/AI_LAYER.md) | AI directory structure and Ralph Loop model |
| [DEV_COMPANION.md](docs/DEV_COMPANION.md) | Companion layers, Cursor rules, registry |
| [DEV_COMPANION_LLM.md](docs/DEV_COMPANION_LLM.md) | LLM provider priority and configuration |
| [CLI_HELPERS.md](docs/CLI_HELPERS.md) | Full CLI command reference |
| [PROFILES.md](docs/PROFILES.md) | Profile-to-package-group mapping |
| [CHEZMOI_WORKFLOW.md](docs/CHEZMOI_WORKFLOW.md) | Init, apply, and update flows |
| [WINDOWS.md](docs/WINDOWS.md) | Windows setup (3 install modes) |
| [CLIENT_AI_PLAYBOOKS.md](docs/CLIENT_AI_PLAYBOOKS.md) | Client workflow skill conventions |
| [MCP_TEMPLATES.md](docs/MCP_TEMPLATES.md) | MCP provider setup |
| [REPOSITORY_GOVERNANCE.md](docs/REPOSITORY_GOVERNANCE.md) | Change management and quality gates |

Architecture Decision Records: [`docs/adrs/`](docs/adrs/)

---

## Relationship to Other Dotfiles

`dots-ai` is designed to be **independent** of any desktop configuration:

- Use it alongside [HorneroConfig](https://github.com/ulises-jeremias/dotfiles) (Hyprland + Arch Linux desktop)
- Use it standalone on macOS, Ubuntu, or any other system
- Use it on a headless server or CI machine with the `ai` profile

---

## License

MIT — see [LICENSE](LICENSE)

---

<div align="center">

[![Star History Chart](https://api.star-history.com/svg?repos=ulises-jeremias/dots-ai&type=Date)](https://star-history.com/#ulises-jeremias/dots-ai&Date)

<a href="https://github.com/ulises-jeremias/dots-ai/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=ulises-jeremias/dots-ai" />
</a>

</div>
