# dots-ai

> Personal AI developer workstation layer — agents, skills, CLI helpers, and dev companion.

[![Validate Workstation](https://github.com/ulises-jeremias/dots-ai/actions/workflows/validate-workstation.yml/badge.svg)](https://github.com/ulises-jeremias/dots-ai/actions/workflows/validate-workstation.yml)
[![Pre-commit](https://github.com/ulises-jeremias/dots-ai/actions/workflows/pre-commit.yml/badge.svg)](https://github.com/ulises-jeremias/dots-ai/actions/workflows/pre-commit.yml)
[![Security Scan](https://github.com/ulises-jeremias/dots-ai/actions/workflows/security-scan.yml/badge.svg)](https://github.com/ulises-jeremias/dots-ai/actions/workflows/security-scan.yml)
[![Release AI Assets](https://github.com/ulises-jeremias/dots-ai/actions/workflows/release-ai-assets.yml/badge.svg)](https://github.com/ulises-jeremias/dots-ai/actions/workflows/release-ai-assets.yml)

This repository standardizes the AI developer tooling layer across Linux, macOS, and Windows, with profile-based installation, shared skills and agents for AI coding tools, MCP templates, and a dev companion runner.

It is designed to work standalone or alongside a separate desktop dotfiles repository (e.g. [HorneroConfig](https://github.com/ulises-jeremias/dotfiles)).

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

See [docs/WINDOWS.md](docs/WINDOWS.md) for full Windows setup.

### Skills Only (no full install)

For anyone who just wants the AI skills and agents without the full toolchain:

```bash
# Linux / macOS / WSL2
curl -fsSL https://github.com/ulises-jeremias/dots-ai/releases/latest/download/install-skills.sh | sh
```

---

## What you get

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
| **CI quality** | Ubuntu + Arch Linux + macOS + Windows validation |

---

## Profiles

Choose a profile during init or go fully custom:

| Profile | Includes |
| --- | --- |
| `technical` | Core + Node + Python + Docker + AI |
| `data` | Core + Python + AI |
| `infra` | Core + Docker + Node + Python |
| `node` | Core + Node |
| `python` | Core + Python |
| `ai` | Core + AI |
| `non-technical` | Core + AI |
| `none` | Choose everything manually |

---

## Post-Setup Validation

After `chezmoi apply`, open a **new terminal** and run:

```bash
dots-doctor
```

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

---

## AI Agents

Generic subagents installed to `~/.claude/agents/`, `~/.config/opencode/agents/`, Cursor rules, and Windsurf rules:

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
| `dots-loadenv` | Load env vars from `~/.config/dots-ai/env.d/` |
| `dots-update-check` | Check if the local baseline is behind origin |
| `dots-bootstrap` | Re-run `chezmoi apply` with dry-run preview |

---

## MCP Templates

Ready-to-use Model Context Protocol server templates in `~/.local/share/dots-ai/mcp/`:

- `github/` — GitHub MCP server
- `clickup/` — ClickUp MCP server
- `notion/` — Notion MCP server
- `slack/` — Slack MCP server

See [docs/MCP_TEMPLATES.md](docs/MCP_TEMPLATES.md) for configuration instructions.

---

## Relationship to other dotfiles

`dots-ai` is designed to be **independent** of any desktop configuration:

- Use it alongside [HorneroConfig](https://github.com/ulises-jeremias/dotfiles) (Hyprland + Arch Linux desktop)
- Use it standalone on macOS, Ubuntu, or any other system
- Use it on a headless server or CI machine with the `ai` profile

---

## License

MIT — see [LICENSE](LICENSE)
