# ADR-002: Profile-driven tooling model

## Status

Accepted

## Context

The workstation baseline serves users with very different needs:

- **Technical engineers** need Node.js, Python, Docker, and AI tooling
- **Non-technical users** only need core CLI tools and AI assistants
- **Data engineers** need Python and AI but not necessarily Node.js or Docker
- **Infrastructure engineers** need Docker and language runtimes but may not need AI tooling

A single "install everything" approach wastes time, disk space, and creates confusion. Host-specific customization (e.g. per-hostname configs) drifts quickly and is hard to maintain.

## Decision

Define **package groups** (`core`, `node`, `python`, `docker`, `ai`) and map them to named **profiles** in `home/.chezmoidata/profiles.yaml`. Users select a profile during `chezmoi init`, which determines which groups are installed.

Key factors:

- **Composable** — profiles map to groups, groups map to packages; easy to add new combinations
- **Deterministic** — same profile always installs the same set of tools
- **Interactive escape hatch** — the `none` profile enables a fully custom questionnaire for edge cases
- **No host-specific logic** — behavior is driven by profile choice, not hostname

## Consequences

### Positive

- Lower baseline complexity — each user only gets what they need
- Clear extensibility for future personas (e.g. `mobile`, `ml-engineer`)
- Reduced risk of machine-specific customization drift
- Profile choice is persisted — subsequent `chezmoi apply` runs are non-interactive

### Negative

- Adding a new tool requires deciding which group(s) it belongs to
- Users who need a unique combination must either use `none` or modify chezmoi data
- Profile names must be chosen carefully to remain intuitive as the baseline grows
