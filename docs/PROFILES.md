# Profiles

> Profile-to-feature-group mapping for workstation setup.

---

Profiles are declared in [`home/.chezmoidata/profiles.yaml`](../home/.chezmoidata/profiles.yaml) and map user personas to feature groups. Every `chezmoi init` starts by asking for a profile; picking `custom` runs the detailed questionnaire instead.

A feature group is a bundle of related install flags. When a group is enabled all flags inside it are rendered `true` and the guarding install scripts run. When a group is disabled, every flag defaults to `false` and the guarded scripts render to an inert shebang — **the worst case of opting out is "nothing installs"**, never a broken shell.

---

## Available profiles

| Profile          | Groups enabled                                                                    |
| ---------------- | --------------------------------------------------------------------------------- |
| `technical`      | core, node, python, docker, ai, skills_jira, skills_confluence, skills_productivity |
| `non-technical`  | core, ai, skills_productivity                                                     |
| `ai`             | core, ai, skills_productivity                                                     |
| `node`           | core, node, skills_productivity                                                   |
| `python`         | core, python, skills_productivity                                                 |
| `data`           | core, python, ai, skills_jira, skills_confluence, skills_productivity             |
| `infra`          | core, node, python, docker, skills_productivity                                   |
| `minimal`        | core                                                                              |
| `custom`         | _nothing by default — answer each group question interactively_                   |

---

## Feature groups

| Group                 | Flag                                  | Contents                                                                 |
| --------------------- | ------------------------------------- | ------------------------------------------------------------------------ |
| `core`                | _always on_                           | Baseline CLI (ripgrep, fd, jq, git, shellcheck, etc.)                    |
| `node`                | `install_group_node`                  | fnm + Node.js LTS + pnpm                                                 |
| `python`              | `install_group_python`                | Python + uv + pipx                                                       |
| `docker`              | `install_group_docker`                | Docker CLI (engine install stays OS-specific)                            |
| `ai`                  | `install_group_ai`                    | AI coding agents (Claude Code, OpenCode, pi, Copilot CLI — individually opt-in) |
| `skills_jira`         | `install_skill_jira_assistant`        | JIRA Assistant skill pack (14 skills)                                    |
| `skills_confluence`   | `install_skill_confluence_assistant`  | Confluence Assistant skill pack (17 skills)                              |
| `skills_productivity` | `install_group_skills_productivity`   | clickup, slack, rtk, uipro-cli                                           |

> [!NOTE]
> The `ai` group installs the **dispatcher** but keeps each agent individually opt-in through the questionnaire. You can enable the group but install zero agents — the script will still render a valid no-op.

---

## Running the questionnaire

| Mode                | Command                                                               |
| ------------------- | --------------------------------------------------------------------- |
| Fresh interactive   | `chezmoi init --apply ulises-jeremias/dots-ai -c ~/.config/chezmoi/dots-ai.toml` |
| Re-run interactive  | `chezmoi init --force --apply ulises-jeremias/dots-ai -c ~/.config/chezmoi/dots-ai.toml` |
| Non-interactive (env) | `WORKSTATION_PROFILE=technical chezmoi init --force --apply ... -c ~/.config/chezmoi/dots-ai.toml` |
| Non-interactive (CLI) | `chezmoi init --promptChoice "… pick one=technical" --force ...`    |

See [INIT_QUESTIONNAIRE.md](INIT_QUESTIONNAIRE.md) for the full prompt reference and every shortcut (`all`, `none`, `recommended`).

---

## Opt-out guarantee

Every feature group, agent and editor is guarded at template render time. If you answer "no" to Claude Code, `install_agent_claude_code` stays `false` and the Claude Code block in [`run_onchange_45-install-ai-agents.sh.tmpl`](../home/.chezmoiscripts/run_onchange_45-install-ai-agents.sh.tmpl) is elided — there is no `if [[ claude_code ]]` at runtime to go wrong. The same pattern applies to node-baseline, python-tooling, docker-tooling, editors, VSCode extensions and external skill packs.

The included `dots-doctor` command respects the same flags — it will only lint for checks whose flags are enabled.

---

## See also

- [INIT_QUESTIONNAIRE.md](INIT_QUESTIONNAIRE.md) — prompt reference
- [CHEZMOI_WORKFLOW.md](CHEZMOI_WORKFLOW.md) — init, apply, update flows
- [TECHNICAL_QUICKSTART.md](TECHNICAL_QUICKSTART.md) — step-by-step onboarding
- [ARCHITECTURE.md](ARCHITECTURE.md) — layered design model
