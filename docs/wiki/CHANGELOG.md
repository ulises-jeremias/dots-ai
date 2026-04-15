# Changelog

Notable changes to dots-ai.

> [!NOTE]
> This page tracks high-level changes. For commit-level detail, see the [commit history](https://github.com/ulises-jeremias/dots-ai/commits/main). For the full changelog, see [CHANGELOG.md](https://github.com/ulises-jeremias/dots-ai/blob/main/CHANGELOG.md).

---

## Unreleased

### Added

- Documentation overhaul (Phases 1–5):
  - Expanded wiki from 9 stub pages → 17 substantive pages with full content
  - README visual upgrade: hero section, for-the-badge badges, collapsible ToC, documentation index
  - 4 new ADRs (004–007): skills compatibility, LLM provider abstraction, multi-tool portability, queue safety
  - Mermaid diagrams in ARCHITECTURE.md, SKILLS.md, DEV_COMPANION.md, MCP_TEMPLATES.md
  - GitHub admonitions and "See Also" cross-references across all docs/
  - `docs/README.md` documentation index with directory tree
  - Root `CHANGELOG.md` with Keep a Changelog format
  - Uninstall documentation in TECHNICAL_QUICKSTART.md and TROUBLESHOOTING wiki page
- `dots-llm-server` documentation in CLI reference and README
- `docs/CLIENT_AI_PLAYBOOKS.md` for client workflow skill conventions

### Changed

- Expanded 3 existing ADRs from skeleton (~19 lines) to full format (~40+ lines)
- `MCP_TEMPLATES.md` expanded from 28 → 100+ lines

### Fixed

- 13 stale `internal-workstation` references updated to `dots-ai`
- `install.ps1` archive filter updated from `internal-workstation-*` to `dots-ai-*`
- CONTRIBUTING.md removed incorrect "private repo" claim
- Broken `CLIENT_AI_PLAYBOOKS.md` links (4 references) resolved

---

## Initial Release

### Added

- Chezmoi-managed workstation AI layer for Linux, macOS, and Windows
- 12 bundled AI skills with multi-tool compatibility
- 13 specialized AI subagents for Claude Code, OpenCode, Cursor, and Windsurf
- Profile-driven installation (technical, ai, minimal, custom)
- MCP server templates (GitHub, ClickUp, Notion, Slack)
- Dev companion with LLM-powered background runner
- `dots-*` CLI helpers (doctor, skills, devcompanion, llm-server, etc.)
- External skill packs via chezmoiexternal (JIRA, Confluence)
- CI pipeline: validation, security scanning, pre-commit, MegaLinter
- Windows support with 3 installation modes
