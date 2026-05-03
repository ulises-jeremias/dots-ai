# ADR-001: Use `home/` as chezmoi source state

## Status

Accepted

## Context

The repository needs to host multiple categories of content:

- **Managed home files** — dotfiles, scripts, and configs that chezmoi deploys to `~/`
- **Docs and ADRs** — documentation that lives in the repo but is not deployed
- **CI/CD workflows** — GitHub Actions, pre-commit configs, linters
- **Project metadata** — README, CONTRIBUTING, SECURITY, LICENSE
- **Shared schemas** — JSON Schema definitions for validation (e.g. `skill.schema.json`)
- **Wiki content** — `docs/wiki/` synced to GitHub Wiki via CI

Mixing all of these under a single root creates confusion about what is deployed vs. what stays in the repo.

## Decision

Set `.chezmoiroot` to `home`, making `home/` the chezmoi source state. Everything outside `home/` is repository-only.

Key factors:

- **Separation of concerns** — deployed files live under `home/`, everything else at the repo root
- **Intuitive structure** — `home/dot_local/bin/` clearly maps to `~/.local/bin/`
- **Standard chezmoi pattern** — recommended by chezmoi documentation for repos with non-deployed content
- **Scalability** — adding docs, schemas, or CI config never risks accidental deployment

## Consequences

### Positive

- Cleaner repository organization with clear boundaries
- Easier onboarding — contributors immediately know `home/` = deployed, root = repo-only
- Better separation between managed files and platform assets
- CI and docs changes never trigger chezmoi template re-evaluation

### Negative

- Slightly deeper file paths for source state (e.g. `home/dot_local/bin/` instead of `dot_local/bin/`)
- Contributors must remember that `home/` is the chezmoi root, not the repository root
