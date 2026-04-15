# Troubleshooting

Common issues and solutions for dots-ai.

## Installation issues

| Issue | Solution |
|-------|---------|
| `chezmoi: command not found` | Install chezmoi: `sh -c "$(curl -fsLS get.chezmoi.io)"` |
| `dots-doctor: command not found` | Open a **new terminal** after `chezmoi apply` |
| Skills not appearing | Run `dots-skills sync` to regenerate symlinks |
| External skills not downloaded | Run `chezmoi apply --refresh-externals` |
| Pre-commit hooks failing | Run `pipx install pre-commit && pre-commit install` |

## dots-doctor failures

| Check | Meaning | Fix |
|-------|---------|-----|
| `Missing directory` | Expected path not created | Re-run `chezmoi apply` |
| `Tool not found` | Required CLI not installed | Install the tool per output instructions |
| `Skill not linked` | Symlink missing | Run `dots-skills sync` |
| `Outdated baseline` | Local is behind remote | Run `chezmoi update` |

## LLM server issues

| Issue | Solution |
|-------|---------|
| `dots-llm-server: GPU not found` | Verify NVIDIA drivers: `nvidia-smi` |
| vLLM container won't start | Check Docker is running: `docker ps` |
| Ollama model not found | Run `dots-llm-server install` to pull models |
| Port already in use | Stop conflicting service or change port in `~/.local/share/dots-ai/llm/config.env` |

## Skills issues

| Issue | Solution |
|-------|---------|
| Skill shows `✗ not linked` | Check `skill.json` compatibility for your AI tool |
| `dots-skills check` reports missing tool | Install the tool listed in the skill's `requires` field |
| JIRA/Confluence skills not installed | Set `install_skill_jira_assistant = true` in chezmoi config, then `chezmoi apply` |

## Chezmoi issues

| Issue | Solution |
|-------|---------|
| `chezmoi apply` fails | Run with `--dry-run --verbose` to identify the issue |
| Re-prompt during apply | Run `chezmoi init` to reset answers |
| Template rendering error | Check `home/.chezmoidata/` for syntax issues |

> [!TIP]
> For issues not listed here, run `dots-doctor` first — it often identifies and suggests fixes.

## Getting help

- Open an [issue](https://github.com/ulises-jeremias/dots-ai/issues) with the `documentation` template
- Check the [CLI Reference](CLI) for command usage
- Review the [Technical Quickstart](TECHNICAL_QUICKSTART) for setup steps

---

## Uninstalling dots-ai

If you need to remove the dots-ai workstation baseline:

### Step 1: Remove chezmoi-managed files

```bash
# Preview what will be removed
chezmoi managed

# Remove all managed files
chezmoi purge
```

> [!WARNING]
> `chezmoi purge` removes **all** files managed by chezmoi — not just dots-ai files. If chezmoi manages other dotfiles, use a selective approach instead.

### Step 2: Remove remaining directories

```bash
# Remove AI assets
rm -rf ~/.local/share/dots-ai/

# Remove skill symlinks (per AI tool)
rm -rf ~/.claude/skills/
rm -rf ~/.config/opencode/skills/
rm -rf ~/.cursor/skills/
rm -rf ~/.copilot/skills/

# Remove env.d configuration (optional)
rm -rf ~/.config/dots-ai/

# Remove dots-* scripts
rm -f ~/.local/bin/dots-*
```

### Step 3: Remove agent files (optional)

```bash
# Claude Code agents
rm -rf ~/.claude/agents/

# OpenCode agents
rm -rf ~/.config/opencode/agents/

# Cursor agents/rules
rm -rf ~/.cursor/agents/
```

### Step 4: Clean chezmoi state

```bash
rm -rf ~/.local/share/chezmoi
rm -rf ~/.config/chezmoi
```

> [!NOTE]
> After uninstalling, you may need to remove the `~/.local/bin` entry from your `$PATH` in `~/.bashrc` or `~/.zshrc` if it was added manually.
