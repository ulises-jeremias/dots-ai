# ADR-004: Skills system with per-tool compatibility matrix

## Status

Accepted

## Context

AI tools have different capabilities and configuration formats:

- **Claude Code** supports YAML frontmatter with `allowed-tools` in `SKILL.md`
- **OpenCode** reads SKILL.md but ignores Claude-specific frontmatter fields
- **Cursor** loads skills as project rules with different glob and trigger patterns
- **pi agent** has limited external skill support
- **Windsurf** reads skills similarly to Cursor

A "write once, works everywhere" assumption is dangerous — a skill that works in Claude Code may break or behave unexpectedly in another tool. We needed a system that:

- Allows skills to explicitly declare per-tool compatibility
- Prevents broken symlinks to unsupported tools
- Supports multiple skill sources (bundled, npm, GitHub, URL)
- Is machine-readable for automation (`dots-skills sync`)

## Decision

Every skill must include a `skill.json` manifest with a `compatibility` object that declares `"supported": true|false` per tool. `dots-skills sync` reads these manifests and only creates symlinks for tools where the skill declares support.

Skills without `skill.json` (e.g. external packs from `.chezmoiexternal`) are treated as universally compatible — this is a pragmatic default for third-party skills that don't ship manifests.

The `skill-catalog.yaml` file provides routing metadata (WHAT vs HOW, triggers, dependencies) for the orchestrator skill to use at runtime.

## Consequences

### Positive

- Explicit opt-in prevents broken tool integrations
- Machine-readable manifests enable automated management
- The `skill-catalog.yaml` provides routing intelligence without hardcoding in skill bodies
- External skills can plug in with minimal friction (no `skill.json` = universal)

### Negative

- Skill authors must maintain `skill.json` alongside `SKILL.md`
- Universal-by-default for external skills may cause issues if a tool can't parse the format
- The compatibility matrix grows with each new AI tool supported
