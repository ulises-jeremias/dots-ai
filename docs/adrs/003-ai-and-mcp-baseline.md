# ADR-003: AI and MCP baseline in shared local paths

## Status

Accepted

## Context

dots-ai needs a reusable AI enablement layer — skills, prompts, templates, and MCP provider configs — that:

- Works across multiple AI tools (Claude Code, OpenCode, Cursor, Copilot CLI, pi)
- Never stores or commits credentials
- Can be extended with external skills from npm, GitHub, or direct URLs
- Has a clear, auditable installation path

Storing AI assets in tool-specific directories (e.g. only `~/.claude/`) would fragment the system and force duplication. Embedding credentials in templates would create security risks.

## Decision

Ship all AI assets under `~/.local/share/dots-ai/` and enforce **env-var-only secrets** via `~/.config/dots-ai/env.d/*.env`.

Directory layout:

- `skills/` — bundled skills managed by chezmoi
- `skills-external/` — external skills from npm/GitHub/URL
- `prompts/` — reusable internal prompts
- `templates/` — text templates for AI agents
- `mcp/` — MCP provider starter templates (secret-free)
- `skills-registry.yaml` — runtime skills index
- `dev-companion/` — optional background runner

`dots-skills sync` reads each skill's `skill.json` manifest and creates symlinks in per-tool directories (e.g. `~/.claude/skills/`, `~/.config/opencode/skills/`).

Key factors:

- **Single source of truth** — one canonical path, symlinked to each tool
- **XDG-compliant** — `~/.local/share/` for data, `~/.config/` for config
- **Secret-free repo** — MCP templates use `${ENV_VAR}` placeholders; real tokens stay in `env.d/`
- **Extensible** — external skills plug in without modifying the chezmoi source state

## Consequences

### Positive

- Consistent, auditable AI baseline across all supported tools
- No credential leakage through repository files
- Easier enablement across teams and projects — everyone gets the same skills
- MCP templates are safe to commit and share; only local env vars differ

### Negative

- Symlink management adds complexity (`dots-skills sync` must run after changes)
- Per-tool compatibility must be declared explicitly in `skill.json`
- The `env.d/` mechanism requires documentation and onboarding for new users
