# Chezmoi Workflow

How `dots-ai` uses [chezmoi](https://www.chezmoi.io/) for workstation state management. For full details, see [docs/CHEZMOI_WORKFLOW.md](https://github.com/ulises-jeremias/dots-ai/blob/main/docs/CHEZMOI_WORKFLOW.md).

## Standard flow

```bash
chezmoi init --source /path/to/dots-ai
chezmoi apply --dry-run    # always preview first
chezmoi apply
dots-doctor                # validate
```

## Init questionnaire

Interactive `chezmoi init` asks what to install:

- **Profile mode** — choose a preset profile (`full`, `ai`, `minimal`, `custom`)
- **Custom mode** — answer per-tool questions (Node, Python, Docker, AI agents, editors)
- Answers are persisted and reused for future applies

> [!NOTE]
> Non-interactive runs (`chezmoi apply` after init) never re-prompt — they use persisted values.

## Update flow

```bash
dots-update-check       # check for upstream changes
chezmoi update          # pull + apply
dots-doctor             # re-validate
```

## External skills refresh

Skills installed via `.chezmoiexternal` (JIRA, Confluence packs) are cached. To force re-download:

```bash
chezmoi apply --refresh-externals
```

## Best practices

- Keep local customizations in user-local files — don't edit managed templates directly
- Run `chezmoi apply --dry-run` before major profile or tooling changes
- Use `dots-skills sync` if you only need to regenerate skill symlinks

## See also

- [Technical Quickstart](TECHNICAL_QUICKSTART) — full onboarding steps
- [Profiles](PROFILES) — available profiles
