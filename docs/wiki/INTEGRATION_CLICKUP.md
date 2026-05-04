# ClickUp Integration

> ClickUp task management with the CLI-first path.

---

## Best path

Use the `clickup` CLI. The ClickUp MCP template is legacy reference only.

## Setup

```bash
clickup auth login
clickup auth status
clickup space select
```

## Why this is the recommended path

- Lower token usage than MCP
- Better shell-friendly output
- Easier task and branch linking

## AI workflows

- `clickup-cli` for terminal-driven task management
- MCP only if you must keep an older agent setup alive

## Verify

```bash
clickup auth status
dots-doctor
```

## See also

- [Credentials & Env Files](CREDENTIALS)
- [MCP Templates](MCP)
