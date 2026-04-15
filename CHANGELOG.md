# Changelog

All notable changes to `dots-ai` are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

> [!NOTE]
> For commit-level detail, see the [commit history](https://github.com/ulises-jeremias/dots-ai/commits/main).

---

## [Unreleased]

### Added

- **Documentation overhaul (Phase 1–4)**:
  - Expanded wiki from 9 stub pages → 17 substantive pages with full content
  - README visual upgrade: hero section, for-the-badge badges, collapsible ToC, documentation index
  - 4 new ADRs: skills compatibility matrix, LLM provider abstraction, multi-tool portability, dev companion queue safety
  - Mermaid diagrams in ARCHITECTURE.md, SKILLS.md, DEV_COMPANION.md, MCP_TEMPLATES.md
  - GitHub admonitions (`[!TIP]`, `[!NOTE]`, `[!IMPORTANT]`, `[!WARNING]`) across all docs/
  - "See Also" cross-reference sections in all documentation files
  - `docs/README.md` documentation index with directory tree
  - Root `CHANGELOG.md` (this file)
- `dots-llm-server` documentation in CLI reference and README
- `docs/CLIENT_AI_PLAYBOOKS.md` for client workflow skill conventions
- Expanded 3 existing ADRs from skeleton to full format (Context bullets, Decision rationale, Positive/Negative consequences)

### Changed

- `MCP_TEMPLATES.md` expanded from 28 → 100+ lines with Mermaid diagrams, provider tables, and usage examples

### Fixed

- 13 stale `internal-workstation` references updated to `dots-ai` across 13 files
- `install.ps1` archive filter corrected from `internal-workstation-*` to `dots-ai-*`
- CONTRIBUTING.md removed incorrect "private repo" claim
- 4 broken `CLIENT_AI_PLAYBOOKS.md` links resolved by creating the missing file
- `DEV_COMPANION_LLM.md` duplicate `#` title header removed

---

## [0.1.0] — Initial Release

### Added

- Chezmoi-managed workstation AI layer for Linux, macOS, and Windows
- 12 bundled AI skills with multi-tool compatibility (Claude Code, OpenCode, Cursor, Copilot CLI, Windsurf)
- 13 specialized AI subagents for Claude Code, OpenCode, Cursor, and Windsurf
- Profile-driven installation: `technical`, `non-technical`, `ai`, `node`, `python`, `data`, `infra`, `none`
- MCP server templates: GitHub, ClickUp, Notion, Slack
- Dev companion with LLM-powered background runner and plan-only default
- `dots-*` CLI helpers: `dots-doctor`, `dots-skills`, `dots-devcompanion`, `dots-llm-server`, `dots-bootstrap`, `dots-sync-ai`, `dots-update-check`, `dots-loadenv`
- External skill packs via chezmoiexternal: JIRA Assistant (14 skills), Confluence
- CI pipeline: `validate-workstation`, `megalinter-v9`, `wiki-sync`, pre-commit hooks
- Windows support with 3 installation modes: WSL2 (full), Git Bash (basic), Skills-only
- Architecture Decision Records: ADR-001 through ADR-003
- 9 documentation files under `docs/`
- GitHub Wiki sync from `docs/wiki/`

---

[Unreleased]: https://github.com/ulises-jeremias/dots-ai/compare/main...HEAD
[0.1.0]: https://github.com/ulises-jeremias/dots-ai/commits/main
