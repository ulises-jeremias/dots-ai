# Claude Code adapter (optional)

Claude Code supports **custom subagents** as Markdown files with frontmatter.

Locations (Claude Code precedence):

- Project-level: `.claude/agents/`
- User-level: `~/.claude/agents/`

This repo ships a small set of recommended subagent templates under:

`~/.local/share/dots-ai/dev-companion/adapters/claude/agents/`

To use them in a project, copy or symlink them into that project’s `.claude/agents/` directory.

The subagents rely on dots-ai skills under `~/.local/share/dots-ai/skills/`.
