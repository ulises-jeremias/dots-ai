# Repository Governance

This document defines repository-level standards for collaboration and quality.

> [!NOTE]
> This document covers the `dots-ai` repository itself. For client/project governance, see [CLIENT_AI_PLAYBOOKS.md](CLIENT_AI_PLAYBOOKS.md).

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

> [!TIP]
> Use Conventional Commit format for all commit messages: `feat:`, `fix:`, `docs:`, `chore:`, etc. This enables automated changelog generation.

---

## See Also

- [ARCHITECTURE.md](ARCHITECTURE.md) — High-level architecture
- [adrs/README.md](adrs/README.md) — Architecture Decision Records index
- [CLIENT_AI_PLAYBOOKS.md](CLIENT_AI_PLAYBOOKS.md) — Client engagement governance
- [../CONTRIBUTING.md](../CONTRIBUTING.md) — Contribution guidelines
