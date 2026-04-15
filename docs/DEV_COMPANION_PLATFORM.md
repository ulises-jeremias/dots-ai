# dots-ai Dev Companion Platform

This document explains the **platform-level** design for dots-ai "Dev Companion" automation across **multiple harnesses** (Cursor, Claude Code, pi.dev, CLI), and across **multiple client accounts**.

Authoritative, machine-installed assets live under `~/.local/share/dots-ai/` after `chezmoi apply`.

> [!NOTE]
> This document describes the **platform architecture**. For the human-facing overview, see [DEV_COMPANION.md](DEV_COMPANION.md). For reliability invariants, see [DEV_COMPANION_RELIABILITY.md](DEV_COMPANION_RELIABILITY.md).

## Goals

- **Multi-harness**: users can keep their preferred harness; dots-ai ships consistent policies.
- **Account separation**: dots-ai has multiple client accounts; not all workflows and access are generalizable.
- **Reliability**: background runs are bounded, observable, resumable, and safe by default.
- **Portability**: policies are defined as files (skills/catalog/packs), not hardcoded in one IDE.

## Mental model: policy vs runtime

### Policy (portable, stable)

- Skills under `~/.local/share/dots-ai/skills/`:
  - **Companion layers** (e.g. `dots-ai-dev-companion`)
  - **Workflow skills** (WHAT) (e.g. `workflow-generic-project`)
  - **Tool skills** (HOW) (e.g. `github-cli-workflow`, `dbt-validation`, `snowflake-validation`)
- Routing metadata: `~/.local/share/dots-ai/skills/skill-catalog.yaml`
- Account/team packs: `~/.local/share/dots-ai/dev-companion/packs/` (see below)

### Runtime (pluggable, optional)

- Interactive (default): Cursor or any harness that loads skills.
- Background: systemd user timer + queue worker under `~/.local/share/dots-ai/dev-companion/`.
- Multi-agent (optional): pi.dev teams or Claude Code agent teams/subagents.

## Account/team packs

Packs allow dots-ai to ship **account-specific** boundaries without forcing every engineer to enable everything.

Installed path:

```
~/.local/share/dots-ai/dev-companion/packs/
  accounts/<accountSlug>/pack.yaml
  teams/<teamSlug>/pack.yaml
```

Each pack defines:

- **triggers**: how to detect the account/team context (repo paths, ticket keys, keywords)
- **allowed_paths**: where automation is allowed to operate
- **required_env**: env var *names* required for privileged operations (no secrets in repo)
- **tool_requirements**: required CLIs (dbt, gh, jira-as, etc.)
- **automation_level**: defaults and guardrails (plan-only vs PR automation)

## Recommended defaults for dots-ai

> [!IMPORTANT]
> The default is **plan-only** automation. Execution beyond planning requires explicit opt-in via job JSON or account pack configuration.

- **Per-developer local runtime by default**: skills + optional worker/timer; developers opt into multi-agent runtime.
- **Per-account separation by allowlists first**:
  - `allowed_paths` prevents cross-account access on a single machine.
  - Credentials stay in `~/.config/dots-ai/env.d/*.env` and are scoped by naming convention.
- **Escalation-first**: if context is ambiguous, ask; if credentials missing, record “skipped” and stop.

## LLM Provider Abstraction

The runner includes a **provider-agnostic LLM layer** for intelligent plan generation:

```
~/.local/share/dots-ai/dev-companion/runner/
  providers/
    base.py              # Abstract LLMProvider interface
    opencode_provider.py # OpenCode (big-pickle, free)
    ollama_provider.py   # Ollama (local models, free)
    anthropic_provider.py # Anthropic Claude (paid)
    openai_provider.py   # OpenAI GPT (paid)
  llm_dispatcher.py      # Auto-selects best available provider
  prompts/
    plan.md.j2           # Prompt template
```

Priority: OpenCode → Ollama → Anthropic → OpenAI (first available wins).

## Where to put harness-specific assets

- Cursor: keep project rules thin (see [DEV_COMPANION.md](DEV_COMPANION.md)).
- Claude Code: project/user subagents under `.claude/agents/` and `~/.claude/agents/` (optional adapter shipped by this repo).
- pi.dev: optional teams runtime configuration and hooks (optional adapter shipped by this repo).

See [DEV_COMPANION_LLM.md](DEV_COMPANION_LLM.md) for LLM provider details.

---

## See Also

- [DEV_COMPANION.md](DEV_COMPANION.md) — Human-facing overview and layers
- [DEV_COMPANION_LLM.md](DEV_COMPANION_LLM.md) — LLM provider integration details
- [DEV_COMPANION_RELIABILITY.md](DEV_COMPANION_RELIABILITY.md) — Reliability invariants and failure policy
- [MULTI_AGENT_ORCHESTRATION.md](MULTI_AGENT_ORCHESTRATION.md) — Optional multi-agent runtime
- [SKILLS.md](SKILLS.md) — Skills system documentation
- [CLIENT_AI_PLAYBOOKS.md](CLIENT_AI_PLAYBOOKS.md) — Client engagement workflows
