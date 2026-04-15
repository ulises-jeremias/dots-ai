# Technical Quickstart

Step-by-step bootstrap for engineers. For full details, see [docs/TECHNICAL_QUICKSTART.md](https://github.com/ulises-jeremias/dots-ai/blob/main/docs/TECHNICAL_QUICKSTART.md).

## Prerequisites

- `git`
- `chezmoi` ([install guide](https://www.chezmoi.io/install/))
- Network access to the repository

## 1. Clone and initialize

```bash
git clone git@github.com:ulises-jeremias/dots-ai.git
cd dots-ai
chezmoi init --source "$PWD/home"
```

> [!TIP]
> During `chezmoi init`, an interactive questionnaire lets you select your profile (e.g. `full`, `ai`, `minimal`) and opt into specific tooling.

## 2. Preview and apply

```bash
chezmoi apply --dry-run   # preview changes
chezmoi apply             # apply to your machine
```

## 3. Validate

```bash
dots-doctor
```

If non-compliance is reported, follow the output instructions.

## 4. Keep updated

```bash
dots-update-check
chezmoi update
```

## 5. Useful daily commands

| Command | Purpose |
|---------|---------|
| `dots-doctor` | Validate tooling and expected files |
| `dots-skills list` | Show installed skills and status |
| `dots-skills check` | Verify required CLI tools per skill |
| `dots-update-check` | Check if local baseline is outdated |
| `dots-bootstrap --apply` | Guided bootstrap flow |

## See also

- [Chezmoi Workflow](CHEZMOI) — init, apply, update details
- [Profiles](PROFILES) — profile options
- [Windows Setup](WINDOWS) — Windows-specific guide
