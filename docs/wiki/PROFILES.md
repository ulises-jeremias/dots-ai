# Profiles

Profiles control which package groups are installed during `chezmoi init`. For full details, see [docs/PROFILES.md](https://github.com/ulises-jeremias/dots-ai/blob/main/docs/PROFILES.md).

## Available profiles

| Profile | Core CLI | Node.js | Python | Docker | AI Layer | Description |
|---------|:--------:|:-------:|:------:|:------:|:--------:|-------------|
| `technical` | Yes | Yes | Yes | Yes | Yes | Full-stack developer workstation |
| `non-technical` | Yes | No | No | No | Yes | Non-dev users — AI tools only |
| `ai` | Yes | No | No | No | Yes | AI-only — skills, agents, MCP |
| `node` | Yes | Yes | No | No | Yes | Node.js developer |
| `python` | Yes | No | Yes | No | Yes | Python developer |
| `data` | Yes | No | Yes | Yes | Yes | Data engineer (Python + Docker) |
| `infra` | Yes | No | No | Yes | Yes | Infrastructure (Docker-focused) |
| `none` | — | — | — | — | — | Custom — answer each question individually |

## How profiles work

1. During `chezmoi init`, you select a profile
2. The profile maps to package groups in `home/.chezmoidata/profiles.yaml`
3. `chezmoi apply` installs only the selected groups
4. Choose `none` to customize every option individually

> [!TIP]
> You can change profiles later by re-running `chezmoi init` — it will re-prompt.

## See also

- [Technical Quickstart](TECHNICAL_QUICKSTART) — initial setup
- [Chezmoi Workflow](CHEZMOI) — how init and apply work
