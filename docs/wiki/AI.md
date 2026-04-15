# AI Overview

The AI layer is the core of `dots-ai` — skills, agents, and the dev companion. For full details, see [docs/AI_LAYER.md](https://github.com/ulises-jeremias/dots-ai/blob/main/docs/AI_LAYER.md).

## Directory structure (after install)

| Path | Purpose |
|------|---------|
| `~/.local/share/dots-ai/skills/` | Bundled skills (managed by chezmoi) |
| `~/.local/share/dots-ai/skills-external/` | External skills (JIRA, Confluence packs) |
| `~/.local/share/dots-ai/mcp/` | MCP provider templates |
| `~/.local/share/dots-ai/dev-companion/` | Dev companion runner + queue |
| `~/.local/share/dots-ai/prompts/` | Reusable internal prompts |
| `~/.local/bin/dots-*` | CLI helpers |

## Skills system

Skills are markdown documents (`SKILL.md`) that teach AI tools how to perform workflows. Each skill includes a `skill.json` manifest declaring compatibility with AI tools:

| Tool | Skills directory |
|------|-----------------|
| Claude Code | `~/.claude/skills/` |
| GitHub Copilot CLI | `~/.copilot/skills/` |
| Cursor | `~/.cursor/skills/` |
| OpenCode | `~/.config/opencode/skills/` |
| pi agent | `~/.pi/agent/skills/` |

`dots-skills sync` reads each manifest and creates symlinks only for supported tools.

> [!NOTE]
> See the [Skills System](SKILLS) page for full documentation on manifests, registry, and publishing.

## AI Agents

13 specialized subagents are deployed to Claude Code, OpenCode, Cursor, and Windsurf:

| Agent | Purpose |
|-------|---------|
| `dev-assistant` | Repo inspection and workflow orchestration |
| `architect` | System design and architecture |
| `code-reviewer` | Code quality and maintainability |
| `security-reviewer` | OWASP Top 10 and vulnerability detection |
| `planner` | Feature planning and task breakdown |
| `tdd-guide` | Test-driven development |
| `refactor-cleaner` | Dead code removal and simplification |
| `build-error-resolver` | Build, TypeScript, and CI failures |
| `database-reviewer` | PostgreSQL and query optimization |
| `docs-lookup` | Framework docs and API references |
| `e2e-runner` | Playwright end-to-end testing |
| `performance-optimizer` | Profiling and optimization |
| `typescript-reviewer` | TypeScript type safety |

## The Ralph Loop

dots-ai implements the [Ralph Loop](https://ghuntley.com/loop/) — a conceptual model for agentic AI:

| Ralph concept | dots-ai implementation |
|---------------|----------------------|
| Backing specifications | `AGENTS.md` templates deployed to each repo |
| Context engineering | Modular skills that prime each loop with domain context |
| Persistent memory | `knowledge/` in the workspace instance |
| Fix the loop | `workspace-knowledge-sync` skill |
| Monolithic orchestrator | `dev-assistant` as single entry point |
| Forward mode | Dev companion driving delivery phases |

## See also

- [Skills System](SKILLS) — full skills documentation
- [Dev Companion](DEV_COMPANION) — companion layers and workflows
- [LLM Providers](LLM_PROVIDERS) — provider configuration
