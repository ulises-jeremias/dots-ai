# AGENTS.md — portable starter (copy into a project repo root)

Use this as a **project-local** supplement. The **dots-ai-assistant** skill explains how agents should discover README, docs, and this file; do not duplicate long prose from those sources here—link or point to them instead.

---

# AI agent instructions — {{PROJECT_NAME}}

## Scope

- **Repository:** short one-line purpose (link to `README.md` for detail).
- **Human owner / team:** optional.

## Priority

1. Follow **this file** for agent-specific behavior when it conflicts with informal README wording.
2. Follow **CONTRIBUTING.md** and **PR templates** for collaboration mechanics.
3. Prefer **documented commands** (Makefile, `package.json` scripts, CI) over invented commands.

## Guardrails

- Do not commit secrets, credentials, or tokens.
- Do not disable security checks or linters to “make it pass” without explicit human approval.
- Prefer small, reviewable changes; match existing code style and patterns in the repo.

## Where to look first

- `README.md` — run, stack, structure
- `docs/` — architecture, ADRs, conventions
- `CONTRIBUTING.md` — branches, commits, PRs
- `.github/workflows/` — required checks
- Task runner — `Makefile` / `justfile` / `package.json` scripts

## Conventions (keep short)

- **Branching:** (e.g. `main` + feature branches; link to CONTRIBUTING if long)
- **Tests:** (how to run the canonical test command)
- **Lint/format:** (canonical command names only)

## Out of scope for the agent

- (e.g. production deploys, schema migrations without review)

## Consolidation note

If instructions also exist in `.cursor/rules`, `CLAUDE.md`, or Copilot instructions, **this file should summarize or link** to avoid drift. Prefer one portable `AGENTS.md` plus minimal tool-specific stubs if needed.

---

Replace `{{PROJECT_NAME}}` with the project name when copying manually. The chezmoi-managed variant lives in `home/.chezmoitemplates/agents/AGENTS.project.md.tmpl`.
