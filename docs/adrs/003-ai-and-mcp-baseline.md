# ADR 003: AI and MCP baseline in shared local paths

## Status

Accepted

## Context

dots-ai needs a reusable AI enablement layer and MCP templates without storing credentials.

## Decision

Ship AI assets and MCP templates under `~/.local/share/dots-ai/` and enforce env-var-only secrets.

## Consequences

- Consistent, auditable AI baseline.
- No credential leakage through repository files.
- Easier enablement across teams and projects.
