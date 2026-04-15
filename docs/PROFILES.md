# Profiles

Profiles are declared in `home/.chezmoidata/profiles.yaml` and map user personas to package groups.
Profiles provide defaults only; the interactive init questionnaire asks for concrete install choices independently of profile membership.

## Available profiles

| Profile | Package groups |
| --- | --- |
| `technical` | `core`, `node`, `python`, `docker`, `ai` |
| `non-technical` | `core`, `ai` |
| `ai` | `core`, `ai` |
| `node` | `core`, `node` |
| `python` | `core`, `python` |
| `data` | `core`, `python`, `ai` |
| `infra` | `core`, `docker`, `node`, `python` |
| `none` | no preset groups (`custom` init questionnaire mode) |

> [!TIP]
> If you're unsure which profile to choose, start with `technical` — it includes everything. You can always switch later by editing `~/.config/chezmoi/chezmoi.toml` and re-running `chezmoi apply`.

## Group intent

- `core`: baseline CLI and shell tooling.
- `node`: Node.js runtime and package managers.
- `python`: Python runtime and package tooling.
- `docker`: container tooling.
- `ai`: AI assistant support tooling.

> [!NOTE]
> The `none` profile enables a fully custom questionnaire during `chezmoi init`. Each stack, tool, editor, and extension is asked independently — useful for edge cases that don't fit a standard profile.

Profiles are intentionally simple and can evolve without renaming bootstrap scripts. Selecting `none` enables the full custom questionnaire for all stacks/tools/editors/extensions during init.

---

## See Also

- [CHEZMOI_WORKFLOW.md](CHEZMOI_WORKFLOW.md) — How profiles are selected during init
- [TECHNICAL_QUICKSTART.md](TECHNICAL_QUICKSTART.md) — Full bootstrap guide
- [ARCHITECTURE.md](ARCHITECTURE.md) — Layered model and data model layer
- [CLI_HELPERS.md](CLI_HELPERS.md) — `dots-doctor` for validating profile compliance
