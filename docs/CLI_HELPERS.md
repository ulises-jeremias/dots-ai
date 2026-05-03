# CLI Helpers

> Operational helper commands installed with the `dots-` prefix.

---

## Command reference

| Command | Purpose |
| --- | --- |
| `dots-bootstrap` | Guided bootstrap output with optional `--apply` |
| `dots-sync-ai` | Verify shared AI directories are present |
| `dots-doctor` | Validate baseline compliance, required tooling, and **system / install snapshot** |
| `dots-update-check` | Check whether local baseline is outdated |
| `dots-skills` | Manage AI skills across all installed AI tools |
| `dots-loadenv` | Show/emit opt-in env loading for `~/.config/dots-ai/env.d/*.env` |
| `dots-devcompanion` | Dev companion background job runner |
| `dots-newnotebook` | Scaffold a reproducible Jupyter notebook from the bundled `jupyter-notebook` skill templates |

---

## dots-doctor

Default run prints a **snapshot** (host, user, OS/kernel/arch, WSL hint, locale, disk on `$HOME`, `profile.env` groups, bundled skill count, optional `chezmoi` source git, optional `~/.dots-ai-workspace` git branch, legacy `workflow-*` symlink targets) and then the same **compliance checks** as before (commands + dots-ai directories). Profile flags from `~/.config/dots-ai/profile.env` still skip groups you did not install.

An **integrations** block follows the snapshot: **`~/.config/dots-ai/env.d` / `dots-loadenv`** (names of `*.env` files and examples missing a live file — **never** values), **`gh auth status`**, **`clickup auth status`** (if the CLI exists), **`glab auth status`** (if installed), plus **warnings** when JIRA/Confluence skills are enabled in the profile but the matching `jira.env` / `confluence.env` is missing. Integration auth issues are **warnings** (yellow) so a missing ClickUp login does not fail the whole baseline unless you treat warnings as blocking in your process.

```text
dots-doctor                 # snapshot + checks (TTY colors when stdout is a terminal)
dots-doctor --issue         # Markdown for GitHub issues / Slack (alias: --paste)
dots-doctor --json          # Single JSON line on stdout (requires python3); exit 1 if non-compliant
dots-doctor --no-snapshot   # Checks only (omit snapshot block)
dots-doctor --help
```

When opening a **support ticket**, ask the reporter to attach the output of `dots-doctor --issue` (no secrets: API keys are only reported as `set` / `unset` when the `ai` check group is enabled).

---

## dots-skills

```
dots-skills list              List installed skills and their status per AI tool
dots-skills sync              Regenerate symlinks for all skills (run after chezmoi apply)
dots-skills install <name>    Install a skill from the registry by name
dots-skills check             Validate that required tools are installed for each skill
dots-skills add <source>      Add an external skill: npm:<pkg>, github:<owner/repo>, url:<url>
```

> [!TIP]
> Run `dots-skills sync` after any `chezmoi apply` to ensure skill symlinks are up to date across all AI tools.

`dots-skills list` is safe to run often: it renders the table in **one** `python3` process (one `skill.json` read per skill) instead of spawning a subprocess per table cell, so it stays fast even with many bundled and external skills.

`dots-skills sync` also deletes **dangling** symlinks in each tool’s skills directory (for example after a bundled skill is renamed), so `list` and the on-disk view stay consistent.

---

## dots-newnotebook

Thin wrapper around the bundled `jupyter-notebook` skill's
`scripts/new_notebook.py` (Python stdlib only). Scaffolds a reproducible
notebook from one of two templates:

```text
dots-newnotebook --kind experiment --title "Compare prompt variants" \
  --out output/jupyter-notebook/compare-prompt-variants.ipynb

dots-newnotebook --kind tutorial --title "Intro to embeddings"
dots-newnotebook --help                # forwards to the underlying script
```

The wrapper resolves the script under `~/.local/share/dots-ai/skills/jupyter-notebook/`,
so it requires `chezmoi apply` (or `dots-skills sync`) to have run at least once.
See `~/.local/share/dots-ai/skills/jupyter-notebook/SKILL.md` for full usage and
the four bundled reference docs (experiment patterns, tutorial patterns,
notebook structure, quality checklist).

---

## dots-devcompanion

```
dots-devcompanion enqueue <id>          Queue a background job for the LLM runner
dots-devcompanion run-once              Process the next queued job
dots-devcompanion status                Check queue status
dots-devcompanion done <id>             Mark a job as complete
dots-devcompanion llm-status [--job F]  Show the active LLM policy without calling any model
```

> [!NOTE]
> The dev companion runner uses a provider-agnostic LLM layer **constrained by an explicit policy** (env vars, optional `~/.config/dots-ai/devcompanion-llm.json`, and per-job overrides). For client engagements that mandate a single AI account (e.g. only the customer's Anthropic key), set `DOTS_AI_DEVCOMPANION_LLM_ALLOWLIST=...` and `DOTS_AI_DEVCOMPANION_LLM_STRICT=1`, then verify with `dots-devcompanion llm-status`. See [DEV_COMPANION_LLM.md](DEV_COMPANION_LLM.md) for the full reference and Cursor/Copilot guidance.

---

## Recommended daily workflow

```bash
dots-update-check       # check for upstream changes
chezmoi apply --source=. -c ~/.config/chezmoi/dots-ai.toml --dry-run  # preview
chezmoi apply --source=. -c ~/.config/chezmoi/dots-ai.toml            # apply
dots-doctor               # verify compliance + snapshot (host, OS, disk, profile, chezmoi hint)
dots-doctor --issue       # Markdown report for GitHub / Slack (paste into tickets)
dots-doctor --json        # One-line JSON summary (needs python3); stdout only
dots-doctor --no-snapshot # Checks only (narrow CI / legacy parsers)
dots-skills check         # verify skill requirements
```

---

## See Also

- [TECHNICAL_QUICKSTART.md](TECHNICAL_QUICKSTART.md) — step-by-step onboarding
- [CHEZMOI_WORKFLOW.md](CHEZMOI_WORKFLOW.md) — chezmoi init, apply, update
- [DEV_COMPANION.md](DEV_COMPANION.md) — dev companion overview
- [SKILLS.md](SKILLS.md) — full skills system
