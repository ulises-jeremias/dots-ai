# Documentation Index

> **📚 dots-ai documentation directory**

## 📑 Technical Documentation

### Architecture & Design

- **[Architecture](ARCHITECTURE.md)** — High-level architecture, layered model, Mermaid diagrams
- **[AI Layer](AI_LAYER.md)** — Shared AI resources, agent templates, Ralph Loop model
- **[Skills](SKILLS.md)** — Skills system: sources, manifests, compatibility matrix, `dots-skills` CLI
- **[Profiles](PROFILES.md)** — Profile-driven tooling and package groups
- **[MCP Templates](MCP_TEMPLATES.md)** — Model Context Protocol provider starter templates

### Dev Companion

- **[Dev Companion](DEV_COMPANION.md)** — Companion layers, delivery flow, Cursor rules pattern
- **[Dev Companion Platform](DEV_COMPANION_PLATFORM.md)** — Multi-harness platform design and account packs
- **[Dev Companion LLM](DEV_COMPANION_LLM.md)** — LLM provider abstraction and zero-config setup
- **[Dev Companion Reliability](DEV_COMPANION_RELIABILITY.md)** — Reliability invariants and failure policy
- **[Multi-Agent Orchestration](MULTI_AGENT_ORCHESTRATION.md)** — Optional multi-agent runtime and pi.dev teams

### Operations & Setup

- **[Technical Quickstart](TECHNICAL_QUICKSTART.md)** — Bootstrap, validate, and operate the baseline
- **[Chezmoi Workflow](CHEZMOI_WORKFLOW.md)** — Standard init/apply/update workflow
- **[CLI Helpers](CLI_HELPERS.md)** — `dots-*` command reference
- **[Windows Setup](WINDOWS.md)** — WSL2, Git Bash, and skills-only installation

### Governance & Patterns

- **[Repository Governance](REPOSITORY_GOVERNANCE.md)** — Branch policy, review, quality gates
- **[Client AI Playbooks](CLIENT_AI_PLAYBOOKS.md)** — Client engagement skill naming and workflows
- **[ECC Patterns](ECC_PATTERNS.md)** — everything-claude-code pattern reference

### Architecture Decision Records (ADRs)

- **[ADR-001](adrs/001-chezmoi-home-source-state.md)** — Use `home/` as chezmoi source state
- **[ADR-002](adrs/002-profile-driven-tooling.md)** — Profile-driven tooling model
- **[ADR-003](adrs/003-ai-and-mcp-baseline.md)** — AI and MCP baseline in shared local paths
- **[ADR-004](adrs/004-skills-compatibility-matrix.md)** — Skills system with per-tool compatibility matrix
- **[ADR-005](adrs/005-llm-provider-abstraction.md)** — LLM provider abstraction for dev companion runner
- **[ADR-006](adrs/006-multi-tool-portability.md)** — Multi-tool portability via symlinks and thin adapters
- **[ADR-007](adrs/007-dev-companion-queue-safety.md)** — Dev companion queue with plan-only default

## 📖 User Documentation

### Wiki

The `wiki/` directory contains comprehensive user-facing guides synced to the GitHub Wiki:

- Getting started, chezmoi workflow, profiles
- AI layer, skills, MCP, LLM providers
- Dev companion, architecture, ADRs
- Windows setup, security, troubleshooting

See [wiki/HOME.md](wiki/HOME.md) for the complete wiki index.

## 🚀 Quick Navigation

### For Users

- [Main README](../README.md) — Project overview and installation
- [Technical Quickstart](TECHNICAL_QUICKSTART.md) — Get started fast
- [Contributing Guide](../CONTRIBUTING.md) — How to contribute
- [Security Policy](../SECURITY.md) — Security practices

### For AI Agents

- [AGENTS.md](../AGENTS.md) — AI agent quick reference and CLI list
- Architecture & Skills docs (above) — Architectural deep-dives

## 📂 Directory Structure

```txt
docs/
├── README.md                        # This file
├── ARCHITECTURE.md                  # High-level architecture
├── AI_LAYER.md                      # Shared AI resources
├── SKILLS.md                        # Skills system
├── PROFILES.md                      # Profile-driven tooling
├── MCP_TEMPLATES.md                 # MCP provider templates
├── DEV_COMPANION.md                 # Dev companion overview
├── DEV_COMPANION_PLATFORM.md        # Multi-harness platform
├── DEV_COMPANION_LLM.md            # LLM provider integration
├── DEV_COMPANION_RELIABILITY.md    # Reliability invariants
├── MULTI_AGENT_ORCHESTRATION.md    # Optional multi-agent
├── TECHNICAL_QUICKSTART.md          # Bootstrap guide
├── CHEZMOI_WORKFLOW.md              # chezmoi apply/update
├── CLI_HELPERS.md                   # dots-* command reference
├── WINDOWS.md                       # Windows setup guide
├── REPOSITORY_GOVERNANCE.md         # Branch policy & quality gates
├── CLIENT_AI_PLAYBOOKS.md          # Client engagement workflows
├── ECC_PATTERNS.md                  # ECC pattern reference
├── adrs/                            # Architecture Decision Records
│   ├── README.md
│   ├── 001-chezmoi-home-source-state.md
│   ├── 002-profile-driven-tooling.md
│   ├── 003-ai-and-mcp-baseline.md
│   ├── 004-skills-compatibility-matrix.md
│   ├── 005-llm-provider-abstraction.md
│   ├── 006-multi-tool-portability.md
│   └── 007-dev-companion-queue-safety.md
└── wiki/                            # User-facing wiki pages
    ├── HOME.md
    ├── _Sidebar.md
    └── ... (17 wiki pages)
```

---

*For questions, see [GitHub Issues](https://github.com/ulises-jeremias/dots-ai/issues)*
