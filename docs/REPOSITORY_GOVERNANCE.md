# Repository Governance

This document defines repository-level standards for collaboration and quality.

## Source of truth

- `main` is the canonical baseline branch.
- `docs/` is canonical for repository documentation.
- `docs/wiki/` is canonical for wiki-synced content.

## Review and change management

- Use pull requests for all changes.
- Prefer small, focused PRs with clear validation notes.
- Keep commit messages in Conventional Commit format.

## Quality gates

- `scripts/validate-repo-structure.sh`
- `scripts/check-shell-syntax.sh`
- `validate-workstation` GitHub Actions workflow
- `megalinter-v9` GitHub Actions workflow

## Governance files

- `CONTRIBUTING.md`
- `SECURITY.md`
- `.github/CODE_OF_CONDUCT.md`
- `.github/PULL_REQUEST_TEMPLATE.md`
- `.github/ISSUE_TEMPLATE/*`
- `.github/dependabot.yml`

## Documentation policy

- Keep core docs under `docs/` with uppercase filenames.
- Keep wiki-facing docs in `docs/wiki/`.
- Update ADRs when repository-level architectural decisions change.
