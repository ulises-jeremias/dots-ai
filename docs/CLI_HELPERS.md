# CLI Helpers

Operational helper commands are installed with the `dots-` prefix to avoid collisions.

## Command reference

| Command | Purpose |
| --- | --- |
| `dots-bootstrap` | Guided bootstrap output with optional `--apply` |
| `dots-sync-ai` | Verify shared AI directories are present |
| `dots-doctor` | Validate baseline compliance and required tooling |
| `dots-update-check` | Check whether local baseline is outdated |
| `dots-skills` | Manage AI skills across all installed AI tools |
| `dots-loadenv` | Show/emit opt-in env loading for `~/.config/dots-ai/env.d/*.env` |

## dots-skills

```
dots-skills list              List installed skills and their status per AI tool
dots-skills sync              Regenerate symlinks for all skills (run after chezmoi apply)
dots-skills install <name>    Install a skill from the registry by name
dots-skills check             Validate that required tools are installed for each skill
dots-skills add <source>      Add an external skill: npm:<pkg>, github:<owner/repo>, url:<url>
```

## Recommended daily workflow

```bash
dots-update-check
chezmoi apply --dry-run
chezmoi apply
dots-doctor
dots-skills check
```
