# dots-ai `env.d/` — opt-in environment variables

This directory is intended for **opt-in, per-service environment variables** (tokens, API keys, etc.)
that you may want available in your shell globally, while still being able to enable/disable them
quickly.

The workstation baseline sources `~/.config/dots-ai/env.d/*.env` from your shell startup (see
`~/.zshrc` managed by chezmoi).

## How it works

- Files ending in `*.env` are sourced automatically by the shell.
- Files with other extensions (like `.example` or `.disabled`) are ignored.

## Enable / disable a service

Example for JIRA:

```bash
# Enable
cp ~/.config/dots-ai/env.d/jira.env.example ~/.config/dots-ai/env.d/jira.env
$EDITOR ~/.config/dots-ai/env.d/jira.env

# Disable (keep it around)
mv ~/.config/dots-ai/env.d/jira.env ~/.config/dots-ai/env.d/jira.env.disabled

# Re-enable
mv ~/.config/dots-ai/env.d/jira.env.disabled ~/.config/dots-ai/env.d/jira.env
```

## Security notes

- Never commit secrets to git.
- Prefer scoping tokens to the minimum required permissions.
- If you rotate a token, update only your local `*.env` file.
