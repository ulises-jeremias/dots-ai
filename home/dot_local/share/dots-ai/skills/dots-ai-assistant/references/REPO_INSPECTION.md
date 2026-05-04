# Repository inspection checklist (reference)

Concrete paths and globs to use after reading `SKILL.md`. Prefer **Glob** / **Read** on the **opened repo root**.

## 0. Quick Onboarding Check (for new developers)

When entering `dots-ai` or a new client repo, first check:

1. **Validate setup**: Run `dots-doctor` (if available on the machine)
2. **Quick start**: Read `README.md` → `docs/wiki/TECHNICAL_QUICKSTART.md`
3. **AI tooling**: Confirm skills exist in `~/.local/share/dots-ai/skills/`
4. **Help**: If lost, ask `#tech-support` or run `dots-update-check`

## 1. README.md

- Usually repo root: `README.md`, sometimes `readme.md`.
- Monorepos: root README + package/service `README.md` for the area you edit.

## 2. Documentation directories

Typical locations (first match wins; read `index.md` / `README.md` inside if present):

- `docs/`
- `doc/`, `documentation/`
- Wiki mirrors: `docs/wiki/`

Look for architecture, conventions, ADRs (`docs/adrs/`, `**/ADR-*.md`), runbooks, API docs.

## 3. Agent instructions (project)

- `AGENTS.md` (repo root; sometimes `docs/AGENTS.md` — check both if root missing)

## 4. Contributing

- `CONTRIBUTING.md`, `docs/CONTRIBUTING.md`

## 5. Pull request templates

- `.github/pull_request_template.md`
- `.github/PULL_REQUEST_TEMPLATE.md`
- `.github/PULL_REQUEST_TEMPLATE/*.md`

## 6. Task runners and scripts

- `Makefile` — targets often self-document via `make help` or comments
- `justfile` / `Justfile` — `just --list`
- `package.json` — `scripts` section
- `pyproject.toml` — `[tool.poetry.scripts]`, task runners
- `Taskfile.yml` / `taskfile.yml`
- `mise.toml` / `.mise.toml` task definitions

**Rule:** Prefer a script already defined in the repo over inventing `npm run` / `pytest` paths that are not listed.

## 7. Dev environment

- `.devcontainer/devcontainer.json`
- `docker-compose.yml`, `compose.yaml`, `compose.yml`
- `Dockerfile` at root or in `docker/`

## 8. CI/CD

- `.github/workflows/*.yml`
- `.gitlab-ci.yml`
- `azure-pipelines.yml`, `Jenkinsfile`, `.circleci/config.yml`, `buildkite.yml`

Summarize **which jobs run on PR** vs main; that is what contributors must satisfy.

## 9. Tooling config (non-exhaustive)

- JavaScript/TS: `tsconfig.json`, `eslint.config.*`, `.eslintrc*`, `prettier.config.*`, `biome.json`
- Python: `ruff.toml`, `pyproject.toml` `[tool.ruff]`, `mypy.ini`
- Go: `.golangci.yml`
- Ruby: `.rubocop.yml`
- Test: `vitest.config.*`, `jest.config.*`, `pytest.ini`, `playwright.config.*`

## 10. Source code

After steps 1–9, read implementation. Start from entrypoints mentioned in README or docs (e.g. `src/`, `apps/`, `cmd/`).
