# MCP Templates

> Model Context Protocol server templates for AI tool integration.

---

## What are MCP templates?

MCP (Model Context Protocol) templates provide ready-to-use server configurations that let AI tools access external services. Templates are installed to `~/.local/share/dots-ai/mcp/`.

---

## Available templates

| Provider | Directory | Purpose |
|----------|-----------|---------|
| **GitHub** | `github/` | Repository access, issues, PRs via GitHub MCP server |
| **ClickUp** | `clickup/` | Task management via ClickUp MCP server |
| **Slack** | `slack/` | Channel access and messaging via Slack MCP server |

---

## Template contents

Each provider directory contains:

| File | Purpose |
|------|---------|
| `README.md` | Setup instructions for the specific provider |
| `config.template.json` | Template configuration — copy and fill in credentials |
| `wrapper.sh` | Shell wrapper that starts the MCP server |

---

## Setup

1. Navigate to the provider directory: `~/.local/share/dots-ai/mcp/<provider>/`
2. Copy `config.template.json` to `config.json`
3. Fill in your credentials (API tokens, URLs)
4. Configure your AI tool to use the MCP server

All integrations use **environment variables** for secrets — never hardcode tokens.

---

## Security

- Templates ship with **placeholder values only**
- Actual credentials are **never committed** to the repository
- Use `~/.config/dots-ai/env.d/` for persistent secrets

---

**Canonical doc:** [`docs/MCP_TEMPLATES.md`](https://github.com/ulises-jeremias/dots-ai/blob/main/docs/MCP_TEMPLATES.md)
