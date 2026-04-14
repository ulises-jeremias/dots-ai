---
name: dev-companion
description: >-
  WHAT — Dev Companion (general): layered companion for client delivery; modes, gates,
  delegation to dots-ai-assistant and workflow-generic-project; no CLI matrices.
---

# Dev Companion (WHAT) — general layer (L2)

This skill is the **general** dev companion for dots-ai work. It does **not** replace **`dots-ai-assistant`** (orchestrator); it **sits above** workflows and names **what to invoke next**.

**Language:** English for ticket comments, PR text, and user-facing outputs when this companion drives delivery work.

## Layering

| Layer | Skill | Role |
| --- | --- | --- |
| L1 | **dots-ai-assistant** | Repo inspection order, conflict resolution, fallback |
| **L2 (this skill)** | **dots-ai-dev-companion** | Companion framing: modes, gates, delegation for generic client work |

## Mode selection

- **Default** for dots-ai/client delivery: use **workflow-generic-project** for phased delivery.
- If unclear → **ask** before proceeding.

## Delegation (HOW is in other skills)

| Need | Delegate to |
| --- | --- |
| Discovery, AGENTS conflict handling | **dots-ai-assistant** |
| Generic client delivery phases | **workflow-generic-project** |
| ClickUp | **clickup-cli** |
| Jira | External **jira-*** pack (**jira-assistant** router; CLI: `jira-as`) |
| Confluence | External **confluence-*** pack (**confluence-assistant** router; CLI: `confluence-as` or `confluence`) |
| Draft PR GitHub / GitLab | **github-cli-workflow** / **gitlab-cli-workflow** |
| UI depth | **ui-ux-pro-max** |
| Workstation health | **workstation-triage** |

Do **not** paste forge or ticket CLI sequences here.

## Operating modes

- **Interactive (default):** IDE session; user steers each step.
- **Queued job (optional):** only when a local runner is configured; see `~/.local/share/dots-ai/dev-companion/README.md` (installed from chezmoi) and **references/LOOP_GUARDRAILS.md**.

The queue worker is **mandatory infrastructure** (installed by workstation). The **workspace** (`~/ai-workspace`) is optional — it provides project-aware wrappers, job templates, and knowledge base integration. When both are present, the runner automatically enriches LLM prompts with workspace context (`projects.yaml`, `projects/`, `knowledge/todos/`).

## Checklist

- [ ] **dots-ai-assistant** discovery pass before large edits
- [ ] **workflow-generic-project** phases and gates when doing generic client delivery
- [ ] Tool skills used for all CLI operations
