# MCP Templates

The platform ships MCP starter templates for:

- GitHub
- ClickUp
- Notion
- Slack

## Provider package format

Each provider directory includes:

- `README.md` with setup guidance
- `config.template.json` with env-var placeholders
- `wrapper.sh` sample launcher

## Required environment variables

Examples include:

- `GITHUB_TOKEN`
- `CLICKUP_API_TOKEN`
- `NOTION_API_TOKEN`
- `SLACK_BOT_TOKEN`
- `SLACK_APP_TOKEN`

All templates are secret-free by default and require local environment setup.
