# GitHub Releases (AI assets)

This document explains how **tagged releases** are built, who they are for, and how they relate to chezmoi.

## Audience

| Path | Best for |
|------|-----------|
| **`install.sh` / `install.ps1`** (from `main`) | Most users: full workstation via chezmoi `init --apply`. |
| **`install-skills.sh` / `install-skills.ps1`** (from a release) | Skills + editor/agent bundles **without** cloning the repo; pinned to a tag version. |
| **Manual ZIP download** | Air-gapped or scripted installs; same layout as the installers expect. |

Non-technical users should prefer **`install.sh` / `install.ps1`** when possible. Release ZIPs are an **offline / version-pinned** complement, not a replacement for chezmoi for the full OS baseline.

## How artifacts are built

On every tag `v*.*.*`, CI runs [`.github/workflows/release-ai-assets.yml`](../.github/workflows/release-ai-assets.yml):

1. **Checkout** this repository.
2. **Install chezmoi** and run `chezmoi init --source=. -c ~/.config/chezmoi/dots-ai.toml --promptDefaults` then `chezmoi apply --source=. -c ~/.config/chezmoi/dots-ai.toml --force` into `$HOME` (the chezmoi **target state** — templates rendered, same as a real machine).
3. **`scripts/verify-release-dump.sh`** — smoke-checks that key paths exist and that `chezmoi dump` returns non-empty output for a few targets (catches broken trees early).
4. **`scripts/build-release-artifacts.py`** — reads **`scripts/release-artifacts.json`** and produces archives:
   - **`zip_materialize`** (via `scripts/build-release-artifacts.py`) for per-tool ZIPs: each bundle copies real files from paths under `$HOME` after `chezmoi apply` (symlinks followed) so installers work everywhere. `chezmoi archive` alone is not used for those ZIPs because it preserves symlink entries that break stock unzip / .NET extraction.
   - **`tar`** (GNU) for `dots-ai-assets-full-*.tar.gz` with a `dots-ai-assets/` prefix (same layout as before).
5. **Pin** `install-skills.*` to the tag download URL, generate `RELEASE_NOTES.md`, verify every file in `dist/.release-upload-files.txt`, upload to the GitHub Release.

To add or change a bundle, edit **`scripts/release-artifacts.json`** only — avoid duplicating paths in the workflow YAML.

## Symlinks and “ship everything in one file”

After `apply`, tool-specific **skill symlinks** (e.g. under `~/.claude/skills/`) often point at `~/.local/share/dots-ai/skills/...`. Archiving those symlinks **verbatim** bakes in absolute paths from the CI runner — **not portable**.

Therefore:

- **`dots-ai-skills-*.zip`** ships the **real files** under `~/.local/share/dots-ai/skills/`.
- **Agent/rule ZIPs** ship **static trees** (e.g. `.claude/agents`, `.cursor/rules`, `.github/copilot-instructions.md`) and avoid symlink-only skill trees.
- Users who want symlink layouts should run **`dots-skills sync`** (or full **`install.sh`**) on their machine.

### Optional monolith (advanced)

A single “entire `$HOME` dotfile export” tarball is **possible** with `chezmoi archive` (no targets) or `chezmoi archive` over a very wide path list, but it is **not** published by default because of symlink portability, size, and the risk of pulling in machine-specific state. Safer pattern: keep **two layers** — (1) `dots-ai-skills` + `dots-ai-assets-full` for share content, (2) per-tool rule/agent ZIPs — plus post-install `dots-skills sync` when CLI tooling is available.

## Migrating away from chezmoi (“eject”)

Upstream chezmoi documents migration paths, including:

- [`chezmoi archive`](https://www.chezmoi.io/reference/commands/archive/) — export the **target state** to tar/zip (same primitive our release builder uses).
- [`chezmoi dump`](https://www.chezmoi.io/reference/commands/dump/) — machine-readable view of the target state for custom tooling.
- **`chezmoi purge`** — remove chezmoi metadata after you no longer want it to manage files.

For dots-ai, the **recommended** story for “I want files only, no chezmoi” is: export with **`chezmoi archive`**, then manage those files with another dotfile manager or plain git, following [chezmoi user documentation](https://www.chezmoi.io/user-guide/).

## Release profile (CI)

The workflow uses the same **non-interactive** `chezmoi init` defaults as today. If you need a **maximum-content** release (more optional files present under `$HOME` after apply), set a dedicated environment variable in the workflow (for example `WORKSTATION_PROFILE`) and document the implications — some features still require **interactive credentials** or CLIs and cannot be represented as static ZIPs alone.

## See also

- [AI_LAYER.md](AI_LAYER.md) — directory layout and tools.
- [WINDOWS.md](WINDOWS.md) — Windows-specific install notes.
- [GUIDED_AI_INSTALL.md](GUIDED_AI_INSTALL.md) — non-developer copy-paste install of these bundles.
- [CHEZMOI_WORKFLOW.md](CHEZMOI_WORKFLOW.md) — day-to-day chezmoi usage.

## CI coverage

Every documented install entry-point (`install.sh`, `install.ps1`, manual `chezmoi init/apply`, `install-skills.{sh,ps1}` with all flags, and the `check-ai-install-prereqs.*` scripts) is exercised by [`.github/workflows/install-methods-matrix.yml`](../.github/workflows/install-methods-matrix.yml). The PR matrix runs hermetically against artifacts built from the PR's HEAD; a daily scheduled job additionally smoke-tests the published `releases/latest` URLs on Linux, macOS, and native Windows.
