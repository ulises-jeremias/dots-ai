# Contributing

Contribution guidelines for dots-ai. For the full guide, see [CONTRIBUTING.md](https://github.com/ulises-jeremias/dots-ai/blob/main/CONTRIBUTING.md).

## Quick workflow

1. Create a branch from `main`
2. Make focused changes
3. Run local checks:
   ```bash
   bash scripts/validate-repo-structure.sh
   bash scripts/check-shell-syntax.sh
   ```
4. Open a pull request using the template

## Commit style

Use [Conventional Commits](https://www.conventionalcommits.org/):

- `feat:` — new features
- `fix:` — bug fixes
- `docs:` — documentation changes
- `refactor:` — code restructuring
- `chore:` — maintenance tasks

## Key rules

- Keep PRs small and reviewable
- Update documentation when behavior changes
- Never commit credentials or secrets
- All commits, PRs, and docs in **English**

## Related

- [SECURITY.md](https://github.com/ulises-jeremias/dots-ai/blob/main/SECURITY.md) — vulnerability reporting
- [Repository Governance](https://github.com/ulises-jeremias/dots-ai/blob/main/docs/REPOSITORY_GOVERNANCE.md) — quality gates and change management
