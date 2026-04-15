# Skills System

Full documentation of the dots-ai skill system — manifests, registry, compatibility, and publishing. For canonical reference, see [docs/SKILLS.md](https://github.com/ulises-jeremias/dots-ai/blob/main/docs/SKILLS.md).

## What is a skill?

A **skill** is a markdown document (`SKILL.md`) plus optional supporting assets that teaches an AI tool how to perform a specific workflow. Skills are loaded at startup and influence how AI tools respond to user requests.

## Skill sources

| Source | Mechanism | Example |
|--------|-----------|---------|
| `bundled` | chezmoi source state | `clickup-cli`, `slack-cli` |
| `npm` | `dots-skills install` | `uipro-cli` (ui-ux-pro-max) |
| `github` | chezmoi `.chezmoiexternal` | JIRA Assistant Skills pack |
| `url` | chezmoi `.chezmoiexternal` | Any HTTP archive |

## Bundled skills (12)

| Skill | Purpose |
|-------|---------|
| `dev-assistant` | Repository inspection, routing, discovery orchestration |
| `dev-companion` | Delivery workflow companion (WHAT/HOW) |
| `workspace-knowledge-sync` | Session knowledge persistence |
| `github-cli-workflow` | GitHub PR creation via `gh` |
| `gitlab-cli-workflow` | GitLab MR creation via `glab` |
| `dbt-validation` | dbt parse/compile/test workflows |
| `snowflake-validation` | Read-only Snowflake validation |
| `workflow-generic-project` | Delivery phases for any project |
| `workstation-triage` | Health check and diagnostics |
| `clickup-cli` | ClickUp task management |
| `slack-cli` | Slack app development CLI |
| `ui-ux-pro-max` | UI/UX design intelligence |

## The `skill.json` manifest

Every skill has a `skill.json` that declares compatibility:

```json
{
  "name": "my-skill",
  "version": "1.0.0",
  "description": "Short description for skill selection",
  "source": "bundled",
  "compatibility": {
    "claude-code":  { "supported": true },
    "copilot-cli":  { "supported": true },
    "cursor":       { "supported": true },
    "opencode":     { "supported": true },
    "pi":           { "supported": false, "notes": "Not yet supported" },
    "windsurf":     { "supported": true }
  }
}
```

> [!NOTE]
> Skills without `skill.json` (e.g. from chezmoiexternal) are treated as universally compatible.

## External skill packs (opt-in)

| Pack | Skills | Install |
|------|--------|---------|
| JIRA Assistant | 14 specialized JIRA skills | `install_skill_jira_assistant = true` |
| Confluence Assistant | 17 Confluence skills | `install_skill_confluence_assistant = true` |

```bash
chezmoi edit-config   # add flag under [data]
chezmoi apply         # downloads + syncs
```

## Managing skills

```bash
dots-skills list              # show all installed skills
dots-skills sync              # regenerate symlinks
dots-skills install <name>    # install from registry
dots-skills check             # verify dependencies
```

## See also

- [AI Overview](AI) — the broader AI layer
- [CLI Reference](CLI) — `dots-skills` subcommands
- [Dev Companion](DEV_COMPANION) — companion workflows
