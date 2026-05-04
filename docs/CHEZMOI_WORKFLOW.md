# Chezmoi Workflow

> Compatibility reference. The user-facing chezmoi lifecycle now lives in [wiki/CHEZMOI.md](wiki/CHEZMOI.md).

## Primary user guide

- [Chezmoi Workflow](wiki/CHEZMOI.md)
- [Technical Quickstart](wiki/TECHNICAL_QUICKSTART.md)
- [Profiles](wiki/PROFILES.md)

## Maintainer contract

- `.chezmoiroot` points to `home/`.
- Source-state files live under `home/`.
- Profile and package data live under `home/.chezmoidata/`.
- Apply with `chezmoi apply --source=. -c ~/.config/chezmoi/dots-ai.toml`.

Keep source-state conventions here only when they are needed by maintainers or automation. Keep walkthroughs in the wiki.
