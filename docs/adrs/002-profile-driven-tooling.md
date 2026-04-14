# ADR 002: Profile-driven tooling model

## Status

Accepted

## Context

Technical and non-technical users require different tooling footprints.

## Decision

Define package groups and map them to profiles in `home/.chezmoidata/profiles.yaml`.

## Consequences

- Lower baseline complexity.
- Clear extensibility for future personas.
- Reduced risk of machine-specific customization drift.
