# MCP Templates

Model Context Protocol server templates for AI tool integration. For full details, see [docs/MCP_TEMPLATES.md](https://github.com/ulises-jeremias/dots-ai/blob/main/docs/MCP_TEMPLATES.md).

## Available providers

| Provider | Path | Purpose |
|----------|------|---------|
| GitHub | `~/.local/share/dots-ai/mcp/github/` | Repository management, issues, PRs |
| ClickUp | `~/.local/share/dots-ai/mcp/clickup/` | Task management, sprint tracking |
| Notion | `~/.local/share/dots-ai/mcp/notion/` | Page management, databases |
| Slack | `~/.local/share/dots-ai/mcp/slack/` | Channel messages, notifications |

## Setup

Each provider directory contains a template configuration. To use:

1. Copy the template to your AI tool's MCP config directory
2. Set the required environment variables (API tokens, URLs)
3. Restart your AI tool

> [!IMPORTANT]
> MCP templates are **examples** — they require explicit local configuration with your own credentials. Never commit API tokens.

## Environment variables

Use the opt-in env mechanism to store credentials:

```bash
mkdir -p ~/.config/dots-ai/env.d
$EDITOR ~/.config/dots-ai/env.d/mcp.env
```

Then load them with `dots-loadenv`.

## See also

- [CLI Reference](CLI) — `dots-loadenv` usage
- [Security](SECURITY) — credential management
