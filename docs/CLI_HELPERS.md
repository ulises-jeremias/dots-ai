# CLI Helpers

Operational helper commands are installed with the `dots-` prefix to avoid collisions.

> [!NOTE]
> All `dots-*` commands are installed to `~/.local/bin/` by chezmoi. Ensure this directory is in your `$PATH`.

## Command reference

| Command | Purpose |
| --- | --- |
| `dots-bootstrap` | Guided bootstrap output with optional `--apply` |
| `dots-sync-ai` | Verify shared AI directories are present |
| `dots-doctor` | Validate baseline compliance and required tooling |
| `dots-update-check` | Check whether local baseline is outdated |
| `dots-skills` | Manage AI skills across all installed AI tools |
| `dots-loadenv` | Show/emit opt-in env loading for `~/.config/dots-ai/env.d/*.env` |
| `dots-devcompanion` | Dev companion background job queue and runner |
| `dots-llm-server` | Manage local LLM server profiles (coding / reasoning) |

## dots-skills

```
dots-skills list              List installed skills and their status per AI tool
dots-skills sync              Regenerate symlinks for all skills (run after chezmoi apply)
dots-skills install <name>    Install a skill from the registry by name
dots-skills check             Validate that required tools are installed for each skill
dots-skills add <source>      Add an external skill: npm:<pkg>, github:<owner/repo>, url:<url>
```

## dots-devcompanion

```
dots-devcompanion enqueue <id>    Queue a background job for the LLM runner
dots-devcompanion run-once        Process the next queued job
dots-devcompanion status          Show queue status
dots-devcompanion done <id>       Mark a job as complete
```

## dots-llm-server

> [!NOTE]
> Requires a machine with an NVIDIA GPU (e.g. RTX 3060 12GB). Profiles share GPU memory — only one can run at a time.

```
dots-llm-server install              Pull images, download models, register Ollama model
dots-llm-server start [profile]      Start a profile: coding (default) or reasoning
dots-llm-server stop                 Stop all running LLM services
dots-llm-server switch [profile]     Toggle or switch to another profile
dots-llm-server status               Show status of all services
dots-llm-server logs [profile]       Follow logs for a profile
```

| Profile | Engine | Port | Model | Speed |
|---------|--------|------|-------|-------|
| `coding` | vLLM (Docker) | 8000 | Qwen2.5-Coder-7B-AWQ | ~400 tok/s |
| `reasoning` | Ollama | 11434 | DeepSeek-R1-7B-Q4 | ~26 tok/s |

## Recommended daily workflow

```bash
dots-update-check
chezmoi apply --dry-run
chezmoi apply
dots-doctor
dots-skills check
```

> [!TIP]
> Run this sequence at the start of each workday to ensure your baseline is current and all required tools are available.

---

## See Also

- [TECHNICAL_QUICKSTART.md](TECHNICAL_QUICKSTART.md) — Full bootstrap guide
- [CHEZMOI_WORKFLOW.md](CHEZMOI_WORKFLOW.md) — Standard chezmoi apply/update workflow
- [SKILLS.md](SKILLS.md) — Skills system documentation (`dots-skills` details)
- [DEV_COMPANION.md](DEV_COMPANION.md) — Dev companion overview (`dots-devcompanion` details)
- [DEV_COMPANION_LLM.md](DEV_COMPANION_LLM.md) — LLM provider integration (`dots-llm-server` details)
