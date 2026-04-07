# ADR 001: Use `home/` as chezmoi source state

## Status

Accepted

## Context

We need a repository root that can host docs, workflows, and platform scripts without mixing them with managed home files.

## Decision

Keep `.chezmoiroot` set to `home`.

## Consequences

- Cleaner repository organization.
- Easier onboarding for maintainers.
- Better separation between managed files and platform assets.
