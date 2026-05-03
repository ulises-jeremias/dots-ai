# Chezmoi Workflow

> Init, apply, and update flows for the dots-ai workstation.

---

## Standard flow

```bash
cd /path/to/dots-ai
chezmoi init --source=. -c ~/.config/chezmoi/dots-ai.toml
chezmoi apply --source=. -c ~/.config/chezmoi/dots-ai.toml --dry-run
chezmoi apply --source=. -c ~/.config/chezmoi/dots-ai.toml
```

---

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

> [!TIP]
> Choose `none` as your profile to get maximum control over every install choice during the interactive questionnaire.

---

## Recommended validation after apply

```bash
dots-doctor
```

> [!IMPORTANT]
> Always open a **new terminal** after `chezmoi apply` to ensure updated PATH and environment variables are loaded.

---

## Update flow

```bash
dots-update-check
chezmoi update
dots-doctor
```

---

## Notes

- Keep local customizations in user-local files instead of editing managed templates directly.
- Re-run `chezmoi apply --source=. -c ~/.config/chezmoi/dots-ai.toml --dry-run` before major profile or tooling changes.

> [!CAUTION]
> Never edit files deployed by chezmoi directly in your home directory — changes will be overwritten on the next `chezmoi apply`. Modify the source state in `home/` instead.

---

## See Also

- [TECHNICAL_QUICKSTART.md](TECHNICAL_QUICKSTART.md) — step-by-step engineer onboarding
- [PROFILES.md](PROFILES.md) — profile-to-package-group mapping
- [CLI_HELPERS.md](CLI_HELPERS.md) — `dots-*` command reference
