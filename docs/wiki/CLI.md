# CLI Reference

All `dots-*` CLI helpers with subcommands. For full details, see [docs/CLI_HELPERS.md](https://github.com/ulises-jeremias/dots-ai/blob/main/docs/CLI_HELPERS.md).

## Command overview

| Command | Purpose |
|---------|---------|
| `dots-doctor` | Validate baseline compliance and required tooling |
| `dots-skills` | Manage AI skills across all installed AI tools |
| `dots-devcompanion` | Dev companion background job queue and runner |
| `dots-llm-server` | Manage local LLM server profiles |
| `dots-bootstrap` | Guided bootstrap output with optional `--apply` |
| `dots-sync-ai` | Verify shared AI directories are present |
| `dots-update-check` | Check whether local baseline is outdated |
| `dots-loadenv` | Show/emit opt-in env loading for `~/.config/dots-ai/env.d/*.env` |

## dots-skills

```
dots-skills list              List installed skills and status per AI tool
dots-skills sync              Regenerate symlinks for all skills
dots-skills install <name>    Install a skill from the registry
dots-skills check             Validate required CLI tools per skill
dots-skills add npm:<pkg>     Add an npm skill to the registry
```

## dots-devcompanion

```
dots-devcompanion enqueue <id>    Queue a background job
dots-devcompanion run-once        Process the next queued job
dots-devcompanion status          Show queue status
dots-devcompanion done <id>       Mark a job as complete
```

## dots-llm-server

> [!NOTE]
> Requires an NVIDIA GPU. Profiles share GPU memory — only one runs at a time.

```
dots-llm-server install           Pull images and download models
dots-llm-server start [profile]   Start coding (default) or reasoning
dots-llm-server stop              Stop all LLM services
dots-llm-server switch [profile]  Toggle or switch profile
dots-llm-server status            Show service status
dots-llm-server logs [profile]    Follow logs
```

| Profile | Engine | Port | Model | Speed |
|---------|--------|------|-------|-------|
| `coding` | vLLM (Docker) | 8000 | Qwen2.5-Coder-7B-AWQ | ~400 tok/s |
| `reasoning` | Ollama | 11434 | DeepSeek-R1-7B-Q4 | ~26 tok/s |

## Recommended daily workflow

```bash
dots-update-check          # check for updates
chezmoi apply --dry-run    # preview changes
chezmoi apply              # apply
dots-doctor                # validate
dots-skills check          # verify skill dependencies
```

## See also

- [Technical Quickstart](TECHNICAL_QUICKSTART) — full setup guide
- [Skills System](SKILLS) — skill management details
