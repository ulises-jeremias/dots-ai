# Technical Quickstart

```bash
git clone git@github.com:ulises-jeremias/dots-ai.git
cd internal-workstation
chezmoi init --source "$PWD/home"
chezmoi apply --dry-run
chezmoi apply
dots-doctor
```

To check updates:

```bash
dots-update-check
chezmoi update
```
