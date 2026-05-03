# CLI Helpers

> `dots-*` commands for workstation management, diagnostics, and AI tooling.

---

## Commands

| Command | Description |
|---------|-------------|
| `dots-doctor` | Health check — validates tools, directories, compliance, plus **system snapshot**; use `--issue` for ticket-friendly Markdown |
| `dots-skills list` | Show installed skills and their per-tool symlink status |
| `dots-skills sync` | Regenerate symlinks for all skills across AI tools |
| `dots-skills install <name>` | Install a skill from the registry |
| `dots-devcompanion enqueue <id>` | Queue a background job for the LLM runner |
| `dots-devcompanion run-once` | Process the next queued job |
| `dots-loadenv` | Load environment variables from `~/.config/dots-ai/env.d/` |
| `dots-update-check` | Check if the local baseline is behind origin/main |
| `dots-bootstrap` | Re-run `chezmoi apply` with dry-run preview |

---

## Common workflows

### Validate your setup

```bash
dots-doctor
```

Checks: installed commands, expected directories, compliance status. Default output includes host/OS/disk/profile context, **integrations** (`env.d` file names, `gh` / `clickup` / `glab` auth — no secrets); `dots-doctor --issue` emits Markdown for issues; `dots-doctor --json` prints one JSON line (needs `python3`).

### Update to latest baseline

```bash
dots-update-check    # check for changes
chezmoi update      # pull + apply
dots-doctor          # verify
```

### Manage skills

```bash
dots-skills list           # show all skills
dots-skills sync           # regenerate symlinks
dots-skills install jira   # install optional skill
```

### Run a dev companion job

```bash
dots-devcompanion enqueue my-task    # queue a job
dots-devcompanion run-once           # process next job
```

---

**Canonical doc:** [`docs/CLI_HELPERS.md`](https://github.com/ulises-jeremias/dots-ai/blob/main/docs/CLI_HELPERS.md)
