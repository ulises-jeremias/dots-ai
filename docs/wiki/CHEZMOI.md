# Chezmoi Workflow

```bash
chezmoi init --source /path/to/internal-workstation
chezmoi apply --dry-run
chezmoi apply
dots-doctor
```

Update cycle:

```bash
dots-update-check
chezmoi update
dots-doctor
```
