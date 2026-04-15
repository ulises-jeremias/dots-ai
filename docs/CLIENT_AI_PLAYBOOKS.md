# Client and Project AI Playbooks

This document defines how to ship **reusable AI skills** for **client engagements** in `dots-ai`. Workflow and companion skills are **enabled by default** in `skills-registry.yaml`; engineers can **opt out** via private chezmoi data if they want a slimmer symlink set.

**Authoritative agent behavior** for orchestration and routing is in the **installed** skill under `~/.local/share/dots-ai/skills/dev-assistant/` (see **`references/ORCHESTRATION.md`** there) and **`~/.local/share/dots-ai/skills/skill-catalog.yaml`**. This doc is a **human** summary; keep it short.

**Companion layers** and Cursor rules patterns: [docs/DEV_COMPANION.md](DEV_COMPANION.md).

**Language:** skills that drive agent behavior for these workflows require **English** for ticket comments, PR text, and user-facing outputs.

## Workflow model

| Workflow | Skill | When to use |
| --- | --- | --- |
| **Generic Project** | `workflow-generic-project` | Default for any client delivery work |

> [!TIP]
> Add client-specific workflow rows to this table as your team creates them.

**Mode selection:** if unclear which workflow applies, the agent **must ask** before starting.

**HOW** (CLIs, forge, dbt, Snowflake) is implemented in **tool skills** — see the catalog — not in workflow `SKILL.md` bodies.

## Goals

- Keep **org-wide** skills (`dev-assistant`, `workstation-triage`, etc.) separate from **client/project** workflows.
- Ship **Generic Project** as `workflow-generic-project` (WHAT: phases, gates, traceability; delegates to ClickUp, Jira pack, **github-cli-workflow** / **gitlab-cli-workflow**).
- Register new optional skills in `skills-registry.yaml`; **bundled** workflows and **dev companions** default to **`enabled: true`** (see `home/.chezmoidata/skills-registry.yaml`).

## Slugs and naming

| Concept | Rule | Example |
| --- | --- | --- |
| Client slug | kebab-case from client name | `Acme Corp` → `acme-corp` |
| Project slug | kebab-case from project name | `Data Pipeline` → `data-pipeline` |
| Bundled skill directory | `home/dot_local/share/dots-ai/skills/<name>/` | `workflow-acme-corp-data-pipeline` |
| Workflow skills | Prefer `workflow-<client>-<project>-<purpose>` when clarity helps | `workflow-acme-corp-migration` |

Use `references/` under the skill for long annexes so `SKILL.md` stays concise.

**Orchestrator** and org-wide companion: **`dev-assistant`** (not a client workflow).

## Catalog (bundled client/project)

| Skill | Workflow | Purpose |
| --- | --- | --- |
| `workflow-generic-project` | **Generic Project** | WHAT: Jira/ClickUp context, human approvals, English ticket traceability; delegates forge/tool steps |

> [!NOTE]
> Add rows here as you create client-specific workflow skills.

## Registry and symlinks

Bundled skills are listed in `home/.chezmoidata/skills-registry.yaml`. **Workflows** (e.g. `workflow-generic-project`) and **dev companions** (e.g. `dev-companion`) default to **`enabled: true`** so `dots-skills sync` creates symlinks under `~/.cursor/skills/`, `~/.claude/skills/`, etc., after `chezmoi apply`.

To **disable** specific skills on a machine, merge or override chezmoi data and set `enabled: false` for those names (or edit the deployed `~/.local/share/dots-ai/skills-registry.yaml` if your setup copies it mutably — prefer chezmoi data merge long term).

Then run `chezmoi apply` (or `dots-skills sync` if only the registry changed).

Verify with:

```bash
dots-skills list
```

## Adding a new client/project skill

1. Read [docs/SKILLS.md](SKILLS.md) for bundled skill layout and `skill.json` schema.
2. Add a directory under `home/dot_local/share/dots-ai/skills/<skill-name>/` with `SKILL.md` and `skill.json`.
3. Add entries to **`skill-catalog.yaml`** (routing metadata) and **`skills-registry.yaml`** (`source: bundled`, `enabled: false` if the skill should stay off by default for most engineers).
4. Add a row to the **Catalog** above and state **workflow independence** if relevant.

## Related docs

- [SKILLS.md](SKILLS.md) — Skill system and registry
- [AI_LAYER.md](AI_LAYER.md) — Where skills live after apply
- [DEV_COMPANION.md](DEV_COMPANION.md) — Companion layers and Cursor rules
- [REPOSITORY_GOVERNANCE.md](REPOSITORY_GOVERNANCE.md) — Repository-level governance standards
