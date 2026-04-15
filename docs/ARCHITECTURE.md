# Architecture

`dots-ai` keeps repository governance and workstation state clearly separated.

## Design principles

- Keep the source state simple and predictable.
- Prefer profile-driven behavior over host-specific custom logic.
- Keep scripts idempotent and safe to re-run.
- Treat docs, wiki, and ADRs as first-class product artifacts.

## High-level overview

```mermaid
flowchart TB
    subgraph repo["dots-ai repository"]
        direction TB
        chezmoidata["home/.chezmoidata\n(profiles, packages, skills registry)"]
        scripts["home/.chezmoiscripts\n(bootstrap & install)"]
        templates["home/.chezmoitemplates\n(AI agent templates)"]
        skills_src["home/dot_local/share/dots-ai/skills/\n(bundled skills)"]
        bin_src["home/dot_local/bin/\n(dots-* CLI helpers)"]
        lib_src["home/dot_local/lib/dots-ai/\n(shared libraries)"]
        mcp_src["home/dot_local/share/dots-ai/mcp/\n(MCP templates)"]
    end

    subgraph machine["Applied machine (~/)"]
        direction TB
        chezmoi_engine["chezmoi apply"]
        skills_dest["~/.local/share/dots-ai/skills/"]
        ext_skills["~/.local/share/dots-ai/skills-external/"]
        bin_dest["~/.local/bin/dots-*"]
        lib_dest["~/.local/lib/dots-ai/"]
        mcp_dest["~/.local/share/dots-ai/mcp/"]
        registry["~/.local/share/dots-ai/skills-registry.yaml"]
    end

    subgraph tools["AI Tools"]
        direction LR
        claude["Claude Code\n~/.claude/skills/"]
        opencode["OpenCode\n~/.config/opencode/skills/"]
        cursor["Cursor\n~/.cursor/skills/"]
        copilot["Copilot CLI\n~/.copilot/skills/"]
    end

    repo -->|chezmoi apply| chezmoi_engine
    chezmoi_engine --> skills_dest & ext_skills & bin_dest & lib_dest & mcp_dest & registry
    skills_dest & ext_skills -->|dots-skills sync| tools
```

## Layered model

```mermaid
flowchart LR
    A["1. Data Model\n.chezmoidata"] --> B["2. Bootstrap Scripts\n.chezmoiscripts"]
    B --> C["3. Templates\n.chezmoitemplates"]
    C --> D["4. Shared Assets\n~/.local/share/dots-ai/"]
    D --> E["5. CLI Helpers\n~/.local/bin/dots-*"]
```

1. **Data model** (`home/.chezmoidata`)
   Shared configuration for package groups, AI settings, profiles, and the skills registry index.
2. **Bootstrap scripts** (`home/.chezmoiscripts`)
   Idempotent setup scripts executed by `chezmoi`. Includes skills sync via `dots-skills sync`.
3. **Templates** (`home/.chezmoitemplates`)
   Reusable AI instruction templates for projects and assistants.
4. **Shared assets** (`home/private_dot_local/share/dots-ai`)
   Prompts, skills, templates, MCP provider examples, and the runtime skills registry.
5. **CLI helpers** (`home/private_dot_local/bin`)
   Internal operations commands with `dots-` prefix, including `dots-skills`.

> [!TIP]
> Run `chezmoi apply --dry-run` before any major profile or tooling change to preview what will be modified on disk.

## Skills architecture

Skills are the primary AI-facing assets. They follow a two-layer model:

- **Bundled skills** — defined in this repo, distributed via chezmoi to `~/.local/share/dots-ai/skills/`.
- **External skills** — installed from npm, GitHub, or URLs by `dots-skills install`, placed in `~/.local/share/dots-ai/skills-external/`.

Each skill contains a `skill.json` manifest that declares compatibility with each AI tool. `dots-skills sync` reads those manifests and creates symlinks in tool-specific directories (e.g. `~/.claude/skills/`, `~/.copilot/skills/`).

```mermaid
flowchart TD
    subgraph sources["Skill Sources"]
        bundled["Bundled\n(chezmoi source state)"]
        npm["npm\n(dots-skills install)"]
        github["GitHub\n(.chezmoiexternal)"]
        url["URL\n(.chezmoiexternal)"]
    end

    subgraph installed["Installed on Machine"]
        skills_dir["~/.local/share/dots-ai/skills/"]
        ext_dir["~/.local/share/dots-ai/skills-external/"]
    end

    subgraph sync["dots-skills sync"]
        manifest["Read skill.json manifests"]
        compat["Check compatibility matrix"]
        symlink["Create/remove symlinks"]
    end

    subgraph targets["AI Tool Directories"]
        t1["~/.claude/skills/"]
        t2["~/.config/opencode/skills/"]
        t3["~/.cursor/skills/"]
        t4["~/.copilot/skills/"]
    end

    bundled --> skills_dir
    npm --> ext_dir
    github --> ext_dir
    url --> ext_dir

    skills_dir & ext_dir --> sync
    sync --> targets
```

> [!IMPORTANT]
> Skills without a `skill.json` manifest (e.g. from chezmoiexternal packs) are treated as **universally compatible** and will be symlinked to all configured AI tools.

See [SKILLS.md](SKILLS.md) for the full skills system documentation.

## Source state convention

- `.chezmoiroot` points to `home`.
- The repository root stays dedicated to docs, CI, project metadata, and shared schemas.
- `lib/schemas/` contains JSON Schema definitions (e.g. `skill.schema.json`).

> [!NOTE]
> The `home/` prefix is stripped by chezmoi during apply. Files at `home/dot_local/bin/` become `~/.local/bin/` on the target machine.

---

## See Also

- [SKILLS.md](SKILLS.md) — Full skills system documentation
- [AI_LAYER.md](AI_LAYER.md) — Shared AI resources and agent templates
- [DEV_COMPANION.md](DEV_COMPANION.md) — Dev companion layers and automation
- [CHEZMOI_WORKFLOW.md](CHEZMOI_WORKFLOW.md) — Standard chezmoi apply/update workflow
- [PROFILES.md](PROFILES.md) — Profile-driven tooling model
- [adrs/](adrs/README.md) — Architecture Decision Records
