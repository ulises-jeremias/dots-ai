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
   - **Setup/onboarding** (new dev, validate install) → cite `dots-doctor`, `docs/wiki/TECHNICAL_QUICKSTART.md`
   - **Client/account overlay** (explicit engagement mention, ticket prefix, or repo path context) → load the **workspace pack overlay** (see below), then proceed with **dots-ai-dev-companion** + **dots-ai-workflow-generic-project** (WHAT). Do **not** mix multiple workflow drivers on the same task.
   - **Generic dots-ai/client delivery** → **dots-ai-dev-companion** (companion framing) + **dots-ai-workflow-generic-project** (WHAT).
   - **Planning / estimation / capacity** → **dots-ai-planning** (after output handshake for final notes).
   - **Default development workflow / DoR / DoD / validation** → **dots-ai-development-workflow** unless repo docs override.
   - **Work item creation or refinement** → **dots-ai-work-item** and then **dots-ai-epic**, **dots-ai-user-story**, **dots-ai-task**, **dots-ai-bug**, or **dots-ai-incident**.
   - **Meeting minutes** → **dots-ai-meeting-minutes**.
   - **Decision or agreement** → **dots-ai-decision-log**, **dots-ai-agreement**, or **dots-ai-adr** depending on durability and scope.
   - **Spike or research findings** → **dots-ai-spike**.
   - **Project assessment / maturity assessment / technical or management unit scorecard** → **dots-ai-project-assessment**; collect sources with **dots-ai-project-assessment-evidence**, then score via **dots-ai-technical-unit-assessment** or **dots-ai-management-unit-assessment**.
   - **Background job/plan generation** → **dev-companion-llm**. Default mode picks OpenCode/big-pickle; **for client engagements with a single-AI-account policy** (e.g. "only their Anthropic key") set **`DOTS_AI_DEVCOMPANION_LLM_ALLOWLIST`** + **`DOTS_AI_DEVCOMPANION_LLM_STRICT=1`** and verify with **`dots-devcompanion llm-status`** before queuing jobs. See **`docs/DEV_COMPANION_LLM.md`** for Cursor/Copilot guidance (`--no-llm` skeleton + IDE-driven LLM).
   - **Ticket system only** → external **jira-*** skills, external **confluence-*** skills, or bundled **clickup-cli** as appropriate.
   - **Where to save a deliverable + review** → **dots-ai-output-handshake** (what path, which system, who reviews) before final PRD/TRD/ADR or PR text.
   - **PRD / TRD / ADR structure** → **dots-ai-prd**, **dots-ai-trd**, **dots-ai-adr** (after the handshake when output is final).
   - **Default pull-request body** when the repo has no template → **dots-ai-pr-fallback** (after the handshake) before **github-cli-workflow** or for MR description with **gitlab-cli-workflow** when applicable.
   - **Draft PR/MR** after push → **github-cli-workflow** or **gitlab-cli-workflow** by remote host.
   - **GitHub PR review comments / threads** on the open PR → **gh-address-comments** (read/triage); pair with **github-cli-workflow** when pushing fixes.
   - **Failing GitHub Actions checks** → **gh-fix-ci** (logs + snippet); pair with **dots-ai-planning** for an explicit fix plan before coding.
   - **Linear** issues, cycles, projects → **linear** (Linear MCP; OAuth).
   - **Figma design → code** → start from **figma** / **figma-implement-design**; **figma-code-connect-components** for Code Connect; **figma-create-design-system-rules** for `AGENTS.md`/rules files; **figma-create-new-file** for new files. Heavy canvas/plugin flows (**figma-use**, **figma-generate-design**) are opt-in packs — see `docs/SKILLS.md`.
   - **Terminal browser automation** (snapshot/click, not test specs) → **playwright-cli**. **Playwright test suites** → **dots-ai-e2e-runner**.
   - **Scaffold or refactor `.ipynb`** → **jupyter-notebook** (**dots-newnotebook** wrapper).
   - **Workstation install / health / pasteable diagnostics** → **dots-ai-workstation-triage** (**dots-doctor**, **`dots-doctor --issue`**).
   - **dbt checks** → **dbt-validation**; **Snowflake checks** → **snowflake-validation** (read-only; never claim success without creds).
3. **Delegate** with one explicit line in the reply, e.g. *Applying **dots-ai-workflow-generic-project** for phases; using **github-cli-workflow** for draft PR.*
4. **If uncertain**, ask which engagement context applies before heavy work, then fall back to this skill’s discovery pass.

## Delegation phrasing

- Workflow skills state **phases, gates, and artifacts** only; they **name** the HOW skill to use next (see each workflow `SKILL.md`).
- Tool skills contain **commands, flags, and fallbacks**.
- One-line **telemetry-lite** for traceability: attribute the active workflow and tool skills by name when making a non-trivial decision.

## Conflicts

- If **AGENTS.md** or repo docs contradict a workflow skill, **surface the conflict** and default to **AGENTS.md** for repo-specific guardrails unless the user directs otherwise.
- Client overlays (workspace packs) and **dots-ai-workflow-generic-project** are compatible; avoid mixing multiple workflow drivers on the same task.

## Client/account overlays (workspace packs)

Client-specific and account-specific overlays live in the user workspace under:

- `~/.ai-workspace/packs/`
- `~/.ai-workspace/knowledge/`

If the user signals an engagement (ticket prefix, repo path prefix, explicit name), prefer loading the corresponding pack first, then proceed with the generic workflow and tool skills.

## Installed paths (after `chezmoi apply`)

| Asset | Path |
| --- | --- |
| Catalog | `~/.local/share/dots-ai/skills/skill-catalog.yaml` |
| This orchestrator | `~/.local/share/dots-ai/skills/dots-ai-assistant/SKILL.md` |
| Repo inspection detail | `~/.local/share/dots-ai/skills/dots-ai-assistant/references/REPO_INSPECTION.md` |
