# AGENTS.md — dots-ai

> AI agent quick reference for this repository.

## Purpose

`dots-ai` is a chezmoi-managed workstation AI layer. It distributes skills, agents, MCP templates, CLI helpers, and a dev companion runner.

## Key paths (after install)

| Path | Contents |
|------|----------|
| `~/.local/share/dots-ai/skills/` | Bundled skills (managed by chezmoi) |
| `~/.local/share/dots-ai/skills-external/` | External skills (npm/github) |
| `~/.local/share/dots-ai/mcp/` | MCP provider templates |
| `~/.local/share/dots-ai/dev-companion/` | Dev companion runner + queue |
| `~/.local/lib/dots-ai/` | Shared shell libraries |
| `~/.local/bin/dots-*` | CLI helpers |
| `~/.claude/agents/` | Claude Code agent definitions |
| `~/.config/opencode/agents/` | OpenCode agent definitions |

## CLI helpers (dots-\* prefix)

```bash
dots-doctor           # health check
dots-skills list      # list installed skills
dots-skills sync      # regenerate AI tool symlinks
dots-update-check     # check for updates
dots-loadenv --emit   # load env vars from ~/.config/dots-ai/env.d/
dots-devcompanion     # dev companion runner
```

## Repository conventions

1. Read in order: `README.md` → `docs/` → `AGENTS.md` → `CONTRIBUTING.md`
2. All scripts use `dots-` prefix (not `nan-`)
3. All shared assets live under `~/.local/share/dots-ai/` (not `~/.local/share/dots/`)
4. Scripts must be idempotent and safe to re-run
5. Prefer `lib/easy-options/easyoptions.sh` for CLI argument parsing
6. Use `set -euo pipefail` in all bash scripts
7. All commits, PRs, and docs in English

## Chezmoi source layout

```
home/                    ← .chezmoiroot points here
├── .chezmoidata/        ← data: profiles, packages, AI flags
├── .chezmoiscripts/     ← idempotent bootstrap scripts
├── .chezmoitemplates/   ← reusable project templates
├── dot_local/bin/       ← dots-* CLI helpers → ~/.local/bin/
├── dot_local/lib/       ← shared libs → ~/.local/lib/dots-ai/
├── dot_local/share/     ← skills, MCP, dev-companion → ~/.local/share/dots-ai/
├── dot_claude/          ← ~/.claude/ (agents + settings)
├── dot_cursor/          ← ~/.cursor/ (rules + skills)
├── dot_windsurf/        ← ~/.windsurf/ (rules)
├── dot_copilot/         ← ~/.copilot/ (skills)
├── dot_pi/              ← ~/.pi/ (agent skills)
├── dot_codeium/         ← ~/.codeium/ (windsurf memories)
└── dot_config/opencode/ ← ~/.config/opencode/ (agents + skills)
```

## Skills architecture

Skills follow a two-layer model:
- **Bundled skills** — defined in this repo, distributed via chezmoi to `~/.local/share/dots-ai/skills/`
- **External skills** — installed from npm, GitHub, or URLs by `dots-skills install`, placed in `~/.local/share/dots-ai/skills-external/`

Each skill contains a `skill.json` manifest that declares compatibility with each AI tool. `dots-skills sync` reads those manifests and creates symlinks in tool-specific directories.

## Guards

- Never commit secrets or credentials
- Never skip idempotency checks in bootstrap scripts
- Never hardcode tool-specific paths — use the `DOTS_AI_SHARE` variable
- Always test with `chezmoi apply --dry-run` before applying
