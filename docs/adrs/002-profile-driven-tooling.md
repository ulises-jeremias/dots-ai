# ADR-002: Profile-driven tooling model

## Status

Accepted

## Context

The workstation serves users with very different needs:

- **Technical engineers** need the full toolchain: Docker, Python (uv/pipx), Node (fnm/pnpm), AI CLIs, and development utilities
- **Non-technical users** (designers, PMs) only need AI skills and basic CLI helpers
- **Data engineers** need dbt, Snowflake CLI, and data-specific tooling in addition to the base
- **CI environments** need a minimal, deterministic subset for validation

Installing everything on every machine creates:

- Long install times (10+ minutes for unused tools)
- Unnecessary complexity for non-technical users
- Machine-specific customization drift when people disable parts manually

## Decision

Define package groups in `home/.chezmoidata/profiles.yaml` and map them to named profiles. During `chezmoi init`, the user selects a profile, and only the corresponding package groups are installed.

Profiles:

| Profile | Target audience | Includes |
|---------|----------------|----------|
| `full` | Technical engineers | Everything: toolchain, AI, Docker, development tools |
| `basic` | Non-technical users | AI skills, agents, basic CLI helpers |
| `minimal` | CI / scripting | Core utilities only, no interactive tools |

Package groups are composable — a profile is a list of groups to enable.

## Consequences

### Positive

- Lower baseline complexity for non-technical users
- Clear extensibility for future profiles (e.g. `data-engineer`, `devops`)
- Reduced risk of machine-specific customization drift
- Faster `chezmoi apply` for profiles that skip heavy toolchains
- CI can use `minimal` profile for fast, deterministic validation

### Negative

- Profile system adds indirection — contributors must understand the mapping
- Adding a new tool requires deciding which profile(s) it belongs to
- Profile selection is sticky (persisted in chezmoi config) — changing requires re-init or manual config edit
