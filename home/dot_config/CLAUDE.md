# CLAUDE.md — Claude Code Instructions

> See AGENTS.md for full standards.

## Agents

dots-ai agents are deployed to `~/.claude/agents/` by chezmoi.
All agent files use the `dots-ai-` prefix (e.g. `dots-ai-code-reviewer.md`).

## Usage

```bash
@dots-ai-planner design a feature
@dots-ai-code-reviewer review this code
@dots-ai-reference-lookup React state patterns
```

## dots-ai Skills

Delegate to skills:
- `dbt-validation` — dbt checks
- `snowflake-validation` — Snowflake checks
- `jira-*` — Jira operations
- `confluence-*` — Confluence operations
