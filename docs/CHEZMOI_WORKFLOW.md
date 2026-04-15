# Chezmoi Workflow

## Standard flow

```bash
chezmoi init --source /path/to/dots-ai
chezmoi apply --dry-run
chezmoi apply
```

> [!TIP]
> Always run `--dry-run` first to preview what will change before applying. This is especially important when switching profiles or upgrading the baseline.

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

> [!NOTE]
> Profile answers are stored in `~/.config/chezmoi/chezmoi.toml` under `[data]`. You can edit this file directly to change your profile without re-running `chezmoi init`.

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

> [!IMPORTANT]
> After a `chezmoi update`, always run `dots-doctor` to verify the baseline is still compliant. Updates may introduce new required tools or change expected paths.

## External skills refresh

To update external skills (installed via `.chezmoiexternal`):

```bash
chezmoi apply --refresh-externals
dots-skills sync
```

## Notes

- Keep local customizations in user-local files instead of editing managed templates directly.
- Re-run `chezmoi apply --dry-run` before major profile or tooling changes.

---

## See Also

- [TECHNICAL_QUICKSTART.md](TECHNICAL_QUICKSTART.md) — Full bootstrap guide
- [PROFILES.md](PROFILES.md) — Available profiles and package groups
- [ARCHITECTURE.md](ARCHITECTURE.md) — Source state convention and layered model
- [SKILLS.md](SKILLS.md) — Skills system and `dots-skills sync`
- [CLI_HELPERS.md](CLI_HELPERS.md) — `dots-doctor`, `dots-update-check` reference
