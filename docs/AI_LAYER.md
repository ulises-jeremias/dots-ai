# AI Layer

Shared AI resources are installed under `~/.local/share/dots-ai/`.

## Directory structure

| Path | Purpose |
| --- | --- |
| `prompts/` | Reusable internal prompts |
| `skills/` | Bundled skills (managed by chezmoi); includes **`skill-catalog.yaml`** (routing metadata) |
| `skills-external/` | External skills installed by `dots-skills` |
| `templates/` | Reusable text templates |
| `mcp/` | MCP provider examples and wrappers |
| `skills-registry.yaml` | Runtime skills registry (deployed from chezmoidata) |

## Skills system

Skills are the primary AI-facing assets. Each skill lives in its own directory and contains:

- `SKILL.md` — the main content read by AI tools (frontmatter + instructions)
- `skill.json` — machine-readable manifest declaring source, version, and **per-tool compatibility**

Skills support multiple AI tools through a compatibility matrix in `skill.json`. `dots-skills sync` reads each skill's manifest and creates symlinks only in the directories of tools that declare `"supported": true`.

| Tool | Skills directory |
|------|-----------------|
| Claude Code | `~/.claude/skills/` |
| GitHub Copilot CLI | `~/.copilot/skills/` |
| Cursor | `~/.cursor/skills/` |
| OpenCode | `~/.config/opencode/skills/` |
| pi agent | `~/.pi/agent/skills/` |

See [docs/SKILLS.md](SKILLS.md) for the full skills system documentation including how to add bundled or external skills.

**Dev companion** layers are documented for humans in [docs/DEV_COMPANION.md](DEV_COMPANION.md); companion skills live next to the workflow skills under `skills/`.

**Client/project** bundled skills ship in the same `skills/` tree. **Workflow** and **dev companion** skills default to **`enabled: true`** in `skills-registry.yaml` (override in private chezmoi data to opt out). The **Generic Project** workflow is documented in [docs/CLIENT_AI_PLAYBOOKS.md](CLIENT_AI_PLAYBOOKS.md) and [docs/DEV_COMPANION.md](DEV_COMPANION.md). Routing is summarized in **`skills/skill-catalog.yaml`**; full orchestration rules live in **`skills/dots-ai-assistant/references/ORCHESTRATION.md`** (installed path).

**dots-ai-assistant** (dots-ai Assistant) is the recommended **organization-wide orchestrator and fallback**: in **any** repo it drives a **document-first** pass (README, `docs/`, `AGENTS.md`, CONTRIBUTING, PR templates, task runners, devcontainer, CI, tooling config, then source), with **`AGENTS.md` as the primary agent contract** when present. It includes `references/REPO_INSPECTION.md`, `references/ORCHESTRATION.md`, and an optional **`AGENTS.project.md.tmpl`** in `home/.chezmoitemplates/agents/` for new application repos. On the baseline checkout it also uses `docs/` and `dots-*`. Future org playbooks should live under documented paths under `~/.local/share/dots-ai/` so the skill stays pointer-based.

## Conceptual model: The Ralph Loop

This workstation is the **infrastructure layer** of a [Ralph Loop](https://ghuntley.com/loop/) implementation. Each component is intentionally mapped to a Ralph concept:

| Ralph concept | What this workstation provides |
|---------------|-------------------------------|
| **Backing specifications** | `AGENTS.md` templates in `home/.chezmoitemplates/agents/` — deployed to each repo/session |
| **Context engineering** | `~/.local/share/dots-ai/skills/` — modular skills that prime each loop with domain context |
| **Persistent memory between loops** | `internal-ai-workspace/knowledge/` — the running instance's knowledge base |
| **Fix the loop** | `dots-ai-workspace-knowledge-sync` skill — auto-syncs discoveries after each session |
| **Monolithic orchestrator** | `dots-ai-assistant` as single entry point; multi-agent is optional and bounded |
| **Forward mode** | Dev companion skills driving autonomous delivery phases |
| **Reverse mode** | Archiving procedure |

The conceptual model, operational guide, and session loop documentation live in the running instance:
**[internal-ai-workspace/knowledge/learnings/general.md](https://github.com/ulises-jeremias/internal-ai-workspace/blob/main/knowledge/learnings/general.md)**

---

## Agent templates

Project-level assistant templates live in `home/.chezmoitemplates/agents/` and include:

- `AGENTS.md.tmpl` (this workstation repository)
- `AGENTS.project.md.tmpl` (starter for **application** repos — portable `AGENTS.md` body)
- `CLAUDE.md.tmpl`
- `copilot-instructions.md.tmpl`

## Init-time AI and editor setup

Interactive `chezmoi init` captures user choices for:

- AI agent CLIs (ClickUp, Slack, rtk, uipro, Claude Code, OpenCode, pi, Copilot CLI extension)
- Editor installation (VSCode, Cursor)
- VSCode extension installation (including Claude Code extension)

Those choices are persisted and used by `home/.chezmoiscripts/` installer scripts on future applies without re-prompting. At the end of each apply, `dots-skills sync` regenerates all skill symlinks.

## Safety guarantees

- No credentials are committed.
- Secrets are consumed via environment variables only.
- MCP templates are examples and require explicit local configuration.
