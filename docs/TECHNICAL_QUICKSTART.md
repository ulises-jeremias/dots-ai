# Technical Quickstart

> Compatibility reference. The guided setup flow now lives in [wiki/TECHNICAL_QUICKSTART.md](wiki/TECHNICAL_QUICKSTART.md).

Use this file only when you need a stable `docs/` link for repository validation or external references.

## Primary user guide

- [Technical Quickstart](wiki/TECHNICAL_QUICKSTART.md)
- [Credentials & Env Files](wiki/CREDENTIALS.md)
- [Integrations Overview](wiki/INTEGRATIONS.md)
- [Troubleshooting](wiki/TROUBLESHOOTING.md)

## Maintainer notes

- The source state still lives under `home/`.
- Apply with `chezmoi apply --source=. -c ~/.config/chezmoi/dots-ai.toml`.
- Validate with `dots-doctor` after opening a new terminal.
