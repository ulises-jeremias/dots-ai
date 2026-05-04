# Credentials & Env Files

> Keep secrets local, loaded from `~/.config/dots-ai/env.d/`, and out of git.

---

## How it works

Files ending in `.env` are sourced automatically. Files ending in `.example` or `.disabled` are ignored.

## Enable or disable a service

```bash
# Enable
cp ~/.config/dots-ai/env.d/jira.env.example ~/.config/dots-ai/env.d/jira.env
$EDITOR ~/.config/dots-ai/env.d/jira.env

# Disable without deleting
mv ~/.config/dots-ai/env.d/jira.env ~/.config/dots-ai/env.d/jira.env.disabled

# Re-enable later
mv ~/.config/dots-ai/env.d/jira.env.disabled ~/.config/dots-ai/env.d/jira.env
```

## Common files

| Service | File |
|---|---|
| Jira | `~/.config/dots-ai/env.d/jira.env` |
| Confluence | `~/.config/dots-ai/env.d/confluence.env` |
| Figma | `~/.config/dots-ai/env.d/figma.env` |

## Common checks

```bash
dots-loadenv
dots-doctor
```

`dots-doctor` lists the file names it can see, but never prints secret values.

## Security reminders

- Use the minimum token scope required.
- Do not paste secrets into chat.
- Do not commit `*.env` files.
