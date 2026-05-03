# Repository Governance

This document defines repository-level standards for collaboration and quality.

> [!IMPORTANT]
> All changes to `main` must go through pull requests. Direct pushes are blocked by branch protection rules.

## Source of truth

- `main` is the canonical baseline branch.
- `docs/` is canonical for repository documentation.
- `docs/wiki/` is canonical for wiki-synced content.

## Review and change management

- Use pull requests for all changes.
- Prefer small, focused PRs with clear validation notes.
- Keep commit messages in Conventional Commit format.

## Quality gates

> [!TIP]
> Run `scripts/validate-repo-structure.sh` locally before pushing to catch structural issues early. CI runs it automatically on every PR.

- `scripts/validate-repo-structure.sh`
- `scripts/check-shell-syntax.sh`
- `validate-workstation` GitHub Actions workflow
- `megalinter-v9` GitHub Actions workflow

## Governance files

- [`CONTRIBUTING.md`](../CONTRIBUTING.md)
- [`SECURITY.md`](../SECURITY.md)
- [`.github/CODE_OF_CONDUCT.md`](../.github/CODE_OF_CONDUCT.md)
- [`.github/PULL_REQUEST_TEMPLATE.md`](../.github/PULL_REQUEST_TEMPLATE.md)
- `.github/ISSUE_TEMPLATE/*`
- [`.github/dependabot.yml`](../.github/dependabot.yml)

## Documentation policy

- Keep core docs under `docs/` with uppercase filenames.
- Keep wiki-facing docs in `docs/wiki/`.
- Update ADRs when repository-level architectural decisions change.

---

## See Also

- [ARCHITECTURE.md](ARCHITECTURE.md) — High-level architecture overview
- [CONTRIBUTING.md](../CONTRIBUTING.md) — Contribution guidelines
- [SECURITY.md](../SECURITY.md) — Security policy
- [adrs/README.md](adrs/README.md) — Architecture Decision Records index
