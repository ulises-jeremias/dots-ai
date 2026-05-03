# Init questionnaire reference

> What every `chezmoi init` prompt does, every answer it accepts, and how to drive it non-interactively.

---

## Quick start

```bash
# Interactive install (the usual case)
chezmoi init --apply ulises-jeremias/dots-ai -c ~/.config/chezmoi/dots-ai.toml

# Re-run the questionnaire (every prompt re-appears with your last answer as default)
chezmoi init --apply ulises-jeremias/dots-ai -c ~/.config/chezmoi/dots-ai.toml

# Wipe saved answers and start over from hardcoded defaults
chezmoi init --force --apply ulises-jeremias/dots-ai -c ~/.config/chezmoi/dots-ai.toml

# Fully unattended (CI, fleet rollouts, testing)
WORKSTATION_PROFILE=technical chezmoi init --force --apply ulises-jeremias/dots-ai -c ~/.config/chezmoi/dots-ai.toml
```

Every interactive `chezmoi init` re-asks the questionnaire, **but each prompt
shows your previous answer as the default in `[brackets]`**. Press <kbd>Enter</kbd>
to keep the saved value, or type a new value (`yes`/`no`, `technical`/`custom`,
etc.) to change it.

`chezmoi apply` does **not** re-prompt — it reads the rendered config from disk.
Only `chezmoi init` re-runs the questionnaire. To wipe all saved answers and
return to hardcoded defaults, pass `--force`.

> Earlier versions used `promptChoiceOnce`/`promptStringOnce`, which silently
> skipped a prompt whenever a value was already on disk. That made the prompts
> feel like a "speed mode" that auto-pressed Enter for you. We now use
> `promptChoice`/`promptString` so every prompt is visible and editable.

---

## Step 1 — Profile

**Prompt:** "PROFILE — which persona matches your role?"

**Type:** single choice (keyed value). `yes/no` does not apply here.

| Answer          | Enables                                                                 |
| --------------- | ----------------------------------------------------------------------- |
| `technical`     | Full developer stack: node, python, docker, ai, jira, confluence, productivity |
| `non-technical` | Productivity + AI only                                                  |
| `ai`            | AI agents + productivity                                                |
| `node`          | Node stack + productivity                                               |
| `python`        | Python stack + productivity                                             |
| `data`          | Python + AI + JIRA + Confluence + productivity                          |
| `infra`         | Node + Python + Docker + productivity                                   |
| `minimal`       | Core CLI baseline only                                                  |
| `custom`        | Skip the shortcuts; answer every group question by hand                 |

Default on a fresh machine: `technical`. On re-init, the default becomes whatever
you previously chose.

---

## Step 2 — Group questions (only when `profile=custom`)

Each group gets one prompt. Every prompt accepts **exactly** `yes` or `no`. No more f/t, s/n, 1/0 confusion.

| Prompt                                                                                      | Flag                                   |
| ------------------------------------------------------------------------------------------- | -------------------------------------- |
| Install Node.js tooling (fnm + Node LTS + pnpm)?                                            | `install_group_node`                   |
| Install Python tooling (python + uv + pipx)?                                                | `install_group_python`                 |
| Install Docker CLI?                                                                         | `install_group_docker`                 |
| Install AI coding agents group? (Claude Code, OpenCode, pi, Copilot CLI)                    | `install_group_ai`                     |
| Install JIRA Assistant skill pack (14 skills)?                                              | `install_skill_jira_assistant`         |
| Install Confluence Assistant skill pack (17 skills)?                                        | `install_skill_confluence_assistant`   |
| Install productivity CLIs (clickup, slack, rtk, uipro-cli)?                                 | `install_group_skills_productivity`    |

Default on a fresh machine: `no` for every group. On re-init, the default for
each prompt is your previously saved answer.

---

## Step 3 — AI agents (only when the `ai` group is enabled)

**Prompt:** "Agents (comma-separated)"

**Options:** `claude-code`, `opencode`, `pi`, `copilot-cli`

**Shortcuts:**

| Shortcut      | Meaning                                         |
| ------------- | ----------------------------------------------- |
| `all`         | Install every agent                             |
| `none`        | Skip every agent (the `ai` group is still on)   |
| `recommended` | Just `opencode`                                 |

Default: `opencode`.

Examples:

```
claude-code, pi        # install both
opencode               # install just one
none                   # enable group, install no agents
all                    # install everything
```

---

## Step 4 — Editors

**Prompt:** "Editors (comma-separated)"

**Options:** `vscode`, `cursor`

**Shortcut:** `none` (default).

When `vscode` is included, Step 5 is asked. When only `cursor` is picked, VSCode extensions are not installed.

---

## Step 5 — VSCode extensions (only when `vscode` is selected)

**Prompt:** "Extensions (comma-separated)"

**Options:** `gitlens`, `editorconfig`, `copilot`, `copilot-chat`, `python`, `yaml`, `spellcheck`, `markdown`, `claude-code`

**Shortcuts:**

| Shortcut      | Extensions                                                  |
| ------------- | ----------------------------------------------------------- |
| `recommended` | gitlens, editorconfig, python, yaml, markdown (**default**) |
| `all`         | every extension in the list above                           |
| `none`        | install none                                                |

---

## Non-interactive installs

| Method                       | Example                                                                                                              |
| ---------------------------- | -------------------------------------------------------------------------------------------------------------------- |
| `WORKSTATION_PROFILE` env    | `WORKSTATION_PROFILE=technical chezmoi init --force --apply ... -c ~/.config/chezmoi/dots-ai.toml`                        |
| `--promptChoice` per field   | `chezmoi init --force --promptChoice "PROFILE… Choose one=technical" --apply ...`                                    |
| Override data file           | `chezmoi init --config /tmp/init.toml --force --apply ...`                                                           |

The env-var path is the simplest and is the one used by `scripts/test-init-render.sh` for the golden-fixture render tests.

---

## Opt-out safety

Every `install_*` flag defaults to `false`. Every install block is wrapped in a template-time `{{- if ... -}}` guard. If you say `no` to a feature, the corresponding script block disappears at render time — there is nothing left to break at runtime.

Run `dots-doctor` after `chezmoi apply` to validate your profile end-to-end. `dots-doctor` only lints the checks whose flags are enabled, so opting out of a group never produces false diagnostic failures.

---

## Related docs

- [PROFILES.md](PROFILES.md) — profile/group matrix
- [CHEZMOI_WORKFLOW.md](CHEZMOI_WORKFLOW.md) — init/apply/update cycle
- [SKILLS.md](SKILLS.md) — available skill packs
