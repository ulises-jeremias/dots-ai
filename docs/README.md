# Documentation Index

> Documentation map for the dots-ai platform.

---

## Documentation model

This repository follows the same split as `dotfiles`:

| Location | Purpose |
|---|---|
| `docs/` | Technical references, architecture, maintainer contracts, validation-stable links |
| `docs/wiki/` | User-facing guides, setup flows, troubleshooting, and integration walkthroughs |
| `docs/adrs/` | Architecture Decision Records |

When a user asks “how do I set this up?”, link to `docs/wiki/`. When a maintainer asks “how is this designed?”, link to `docs/`.

## Navigation

| Document | Topic | Audience |
|----------|-------|----------|
| **Getting Started** | | |
| [TECHNICAL_QUICKSTART.md](TECHNICAL_QUICKSTART.md) | Compatibility pointer to wiki setup | All |
| [CHEZMOI_WORKFLOW.md](CHEZMOI_WORKFLOW.md) | Chezmoi maintainer contract | Maintainers |
| [PROFILES.md](PROFILES.md) | Profile data contract | Maintainers |
| [WINDOWS.md](WINDOWS.md) | Compatibility pointer to Windows wiki | Windows users |
| [GUIDED_AI_INSTALL.md](GUIDED_AI_INSTALL.md) | Compatibility pointer to guided AI install wiki | All |
| [RELEASES.md](RELEASES.md) | Compatibility pointer to releases wiki | All |
| **AI System** | | |
| [AI_LAYER.md](AI_LAYER.md) | AI directory structure and Ralph Loop | All |
| [SKILLS.md](SKILLS.md) | Full skills system — manifests, registry, publishing, Best Practices use cases | Skill authors, delivery leads |
| [AGENTIC_HARNESS.md](AGENTIC_HARNESS.md) | Three-layer architecture, personas, packs | Architects |
| [CLIENT_AI_PLAYBOOKS.md](CLIENT_AI_PLAYBOOKS.md) | Client workflow skill conventions | Delivery leads |
| [MCP_TEMPLATES.md](MCP_TEMPLATES.md) | MCP provider template reference | Maintainers, integrators |
| [CREDENTIALS_SETUP.md](CREDENTIALS_SETUP.md) | Legacy credentials reference | All |
| **Dev Companion** | | |
| [DEV_COMPANION.md](DEV_COMPANION.md) | Companion layers, Cursor rules, registry | All |
| [DEV_COMPANION_LLM.md](DEV_COMPANION_LLM.md) | LLM provider priority and configuration | All |
| [DEV_COMPANION_PLATFORM.md](DEV_COMPANION_PLATFORM.md) | Platform schema and multi-harness design | Architects |
| [DEV_COMPANION_RELIABILITY.md](DEV_COMPANION_RELIABILITY.md) | Reliability patterns and error handling | Architects |
| [MULTI_AGENT_ORCHESTRATION.md](MULTI_AGENT_ORCHESTRATION.md) | Multi-agent runtime and persona constraints | Architects |
| [ECC_PATTERNS.md](ECC_PATTERNS.md) | Error correction and context patterns | Reference |
| **Infrastructure** | | |
| [ARCHITECTURE.md](ARCHITECTURE.md) | Layered design model and source state | Architects |
| [CLI_HELPERS.md](CLI_HELPERS.md) | CLI maintainer contract | Maintainers |
| [REPOSITORY_GOVERNANCE.md](REPOSITORY_GOVERNANCE.md) | Change management and quality gates | Contributors |
| **Architecture Decisions** | | |
| [adrs/](adrs/) | Architecture Decision Records | All |

---

## Wiki

User-friendly summaries of these docs are available in the [Wiki](https://github.com/ulises-jeremias/dots-ai/wiki).
For guided external-service setup, start with [wiki/INTEGRATIONS.md](wiki/INTEGRATIONS.md).

Recommended user entry points:

- [wiki/TECHNICAL_QUICKSTART.md](wiki/TECHNICAL_QUICKSTART.md)
- [wiki/GUIDED_AI_INSTALL.md](wiki/GUIDED_AI_INSTALL.md)
- [wiki/QUESTIONNAIRE.md](wiki/QUESTIONNAIRE.md)
- [wiki/INTEGRATIONS.md](wiki/INTEGRATIONS.md)
- [wiki/TROUBLESHOOTING.md](wiki/TROUBLESHOOTING.md)

## Contributing

See [CONTRIBUTING.md](../CONTRIBUTING.md) for contribution guidelines.
