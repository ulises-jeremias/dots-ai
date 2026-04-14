# Chezmoi Workflow

## Standard flow

```bash
chezmoi init --source /path/to/internal-workstation
chezmoi apply --dry-run
chezmoi apply
```

## Init questionnaire behavior

- Interactive `chezmoi init` asks what to install across:
  - core CLI packages
  - profile mode:
    - choose a preset profile and use profile-driven package groups
  - custom mode:
    - choose profile `none` to answer Node/Python/Docker, AI agent CLIs, editors (VSCode/Cursor), and VSCode extensions one by one
- Answers are persisted in `chezmoi` data and reused for subsequent applies.
- Interactive `chezmoi apply` after init does not re-ask those questions.
- Non-interactive runs never prompt and use the persisted values.

## Recommended validation after apply

```bash
dots-doctor
```

## Update flow

```bash
dots-update-check
chezmoi update
dots-doctor
```

## Notes

- Keep local customizations in user-local files instead of editing managed templates directly.
- Re-run `chezmoi apply --dry-run` before major profile or tooling changes.
