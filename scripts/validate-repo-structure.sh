#!/usr/bin/env bash
set -euo pipefail

if [[ -t 1 && -z ${NO_COLOR:-} ]]; then
  c_reset=$'\033[0m'
  c_blue=$'\033[1;34m'
  c_red=$'\033[1;31m'
  c_green=$'\033[1;32m'
else
  c_reset=''
  c_blue=''
  c_red=''
  c_green=''
fi

info() { printf '%b[repo-structure]%b %s\n' "$c_blue" "$c_reset" "$*"; }
fail() { printf '%b[repo-structure]%b %s\n' "$c_red" "$c_reset" "$*"; }
ok() { printf '%b[repo-structure]%b %s\n' "$c_green" "$c_reset" "$*"; }

required_paths=(
  ".chezmoiroot"
  "README.md"
  "CONTRIBUTING.md"
  "CHANGELOG.md"
  "SECURITY.md"
  "docs/README.md"
  "docs/adrs/README.md"
  "docs/adrs/001-chezmoi-home-source-state.md"
  "docs/adrs/002-profile-driven-tooling.md"
  "docs/adrs/003-ai-and-mcp-baseline.md"
  "docs/adrs/004-skills-compatibility-matrix.md"
  "docs/adrs/005-llm-provider-abstraction.md"
  "docs/adrs/006-multi-tool-portability.md"
  "docs/adrs/007-dev-companion-queue-safety.md"
  "docs/ARCHITECTURE.md"
  "docs/AI_LAYER.md"
  "docs/CHEZMOI_WORKFLOW.md"
  "docs/CLI_HELPERS.md"
  "docs/CLIENT_AI_PLAYBOOKS.md"
  "docs/DEV_COMPANION.md"
  "docs/DEV_COMPANION_LLM.md"
  "docs/DEV_COMPANION_PLATFORM.md"
  "docs/DEV_COMPANION_RELIABILITY.md"
  "docs/ECC_PATTERNS.md"
  "docs/MCP_TEMPLATES.md"
  "docs/MULTI_AGENT_ORCHESTRATION.md"
  "docs/PROFILES.md"
  "docs/REPOSITORY_GOVERNANCE.md"
  "docs/SKILLS.md"
  "docs/TECHNICAL_QUICKSTART.md"
  "docs/WINDOWS.md"
  "docs/wiki/_Sidebar.md"
  "docs/wiki/HOME.md"
  "docs/wiki/TECHNICAL_QUICKSTART.md"
  "docs/wiki/CONTRIBUTING.md"
  "docs/wiki/CHANGELOG.md"
  "docs/wiki/SECURITY.md"
  "docs/wiki/TROUBLESHOOTING.md"
  "static/hero-banner.svg"
  "home/.chezmoi.toml.tmpl"
  "home/.chezmoidata/base.yaml"
  "home/.chezmoiscripts/run_once_before_10-install-core-tools.sh.tmpl"
  "home/dot_local/bin/executable_dots-doctor"
  "home/dot_local/bin/executable_dots-bootstrap"
  "home/dot_local/bin/executable_dots-skills"
  "home/dot_local/bin/executable_dots-loadenv"
  "home/dot_local/bin/executable_dots-devcompanion"
  "home/dot_local/bin/executable_dots-update-check"
  "home/dot_local/bin/executable_dots-sync-ai"
  "home/dot_local/lib/dots-ai/easy-options/easyoptions.sh"
  ".github/workflows/release-ai-assets.yml"
  "scripts/check-shell-syntax.sh"
)

info "validating required repository paths"
for path in "${required_paths[@]}"; do
  info "checking: ${path}"
  if [[ ! -e ${path} ]]; then
    fail "Missing required path: ${path}" >&2
    exit 1
  fi
  ok "found: ${path}"
done

ok "Repository structure validation passed."
