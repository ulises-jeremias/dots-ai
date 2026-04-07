# Skill orchestration (dots-ai)

Authoritative routing lives with the **dots-ai-assistant** skill. This file is a short operational guide; **`~/.local/share/dots-ai/skills/skill-catalog.yaml`** is the machine-readable index (domain, WHAT vs HOW, triggers, `depends_on`).

## Role of this skill

**dots-ai-assistant** is the **orchestrator and fallback**:

- **Orchestrator:** choose workflow vs tool skills using the catalog and the user’s request.
- **Fallback:** when the task is unclear, spans domains, or no specialized skill fits, keep using this skill’s repo-inspection order and citation rules.

Do **not** duplicate full procedures owned by Jira, ClickUp, forge, or data skills inside this file.

## Routing algorithm (reasoning-based)

1. **Read** `skill-catalog.yaml` (same directory as bundled skills) and note **responsibility**: **WHAT** = workflow phases and gates; **HOW** = CLI and automation steps.
2. **Classify** the user request:
   - **Setup/onboarding** (new dev, validate install) → cite `dots-doctor`, `docs/TECHNICAL_QUICKSTART.md`
   - **Sunstone Credit** (explicit mention, or Jira context such as `SUNENG-*`) → **sunstone-dev-companion** (companion framing) + **workflow-sunstone-credit-data-project** (WHAT). Do **not** mix with generic client workflow on the same task.
   - **Generic dots-ai/client delivery** (not Sunstone) → **dots-ai-dev-companion** (companion framing) + **workflow-generic-project** (WHAT).
   - **Background job/plan generation** → **dev-companion-llm** (uses OpenCode with big-pickle by default, zero config)
   - **Ticket system only** → external **jira-*** skills, external **confluence-*** skills, or bundled **clickup-cli** as appropriate.
   - **Draft PR/MR** after push → **github-cli-workflow** or **gitlab-cli-workflow** by remote host.
   - **dbt checks** → **dbt-validation**; **Snowflake checks** → **snowflake-validation** (read-only; never claim success without creds).
3. **Delegate** with one explicit line in the reply, e.g. *Applying **workflow-generic-project** for phases; using **github-cli-workflow** for draft PR.*
4. **If uncertain**, ask which workflow applies (Generic vs Sunstone) before heavy work, then fall back to this skill’s discovery pass.

## Delegation phrasing

- Workflow skills state **phases, gates, and artifacts** only; they **name** the HOW skill to use next (see each workflow `SKILL.md`).
- Tool skills contain **commands, flags, and fallbacks**.
- One-line **telemetry-lite** for traceability: attribute the active workflow and tool skills by name when making a non-trivial decision.

## Conflicts

- If **AGENTS.md** or repo docs contradict a workflow skill, **surface the conflict** and default to **AGENTS.md** for repo-specific guardrails unless the user directs otherwise.
- **workflow-sunstone-credit-data-project** and **workflow-generic-project** are **mutually exclusive** on a single task.

## Installed paths (after `chezmoi apply`)

| Asset | Path |
| --- | --- |
| Catalog | `~/.local/share/dots-ai/skills/skill-catalog.yaml` |
| This orchestrator | `~/.local/share/dots-ai/skills/dots-ai-assistant/SKILL.md` |
| Repo inspection detail | `~/.local/share/dots-ai/skills/dots-ai-assistant/references/REPO_INSPECTION.md` |
