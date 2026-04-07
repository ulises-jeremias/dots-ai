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

## Group intent

- `core`: baseline CLI and shell tooling.
- `node`: Node.js runtime and package managers.
- `python`: Python runtime and package tooling.
- `docker`: container tooling.
- `ai`: AI assistant support tooling.

Profiles are intentionally simple and can evolve without renaming bootstrap scripts. Selecting `none` enables the full custom questionnaire for all stacks/tools/editors/extensions during init.
