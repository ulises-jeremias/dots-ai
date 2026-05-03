# Skills System

> How dots-ai skills are defined, distributed, installed, and made available to AI tools.

---

## What is a skill?

A **skill** is a markdown document (plus optional supporting assets) that teaches an AI tool how to perform a specific workflow. Skills are loaded by AI tools at startup.

Each skill contains:

- `SKILL.md` — instructions read by AI tools (frontmatter + body)
- `skill.json` — manifest declaring source, version, and per-tool compatibility

---

## Bundled skills

|-------|---------|

---

## Best Practices and Assessment Skills

The bundled Best Practices skills are intentionally atomic. The orchestrator loads the smallest skill needed instead of one large process document.

### Output handshake

Before producing a final artifact, the assistant must ask:

- Where should the final content live?
- Who will review it?

This applies to PRDs, TRDs, ADRs, work items, meeting minutes, assessment reports, scorecards, evidence maps, incidents, spikes, and PR/MR bodies.

### Project assessments

Project assessments use four skills:

|-------|------|

The assistant must not score indicators without evidence. If evidence is unavailable, it should mark the indicator as missing evidence, not assessed, or low confidence with the assumption clearly stated.

### Example chats

End-to-end assessment:

```text
User: Run a project assessment for this engagement.
Assistant: I will use dots-ai-project-assessment. Where should the final report live, and who will review it?
User: Put the draft in docs/assessment.md. I will review it.
Assistant: What period and units should be assessed? Should this cover management, technical units, or both?
User: Last quarter, both. Backend and data pipelines are in scope.
Assistant: I will collect evidence first. Where are the repositories, board, planning docs, dashboards, incidents, decisions, and stakeholder feedback?
```

Technical-only assessment:

```text
User: Assess the cloud infrastructure and CI/CD maturity.
Assistant: I will use dots-ai-project-assessment-evidence and dots-ai-technical-unit-assessment. Where are the IaC repo, pipeline history, deployment docs, monitoring dashboards, security scans, and incident records?
```

Management-only assessment:

```text
User: Review governance and delivery health.
Assistant: I will use dots-ai-project-assessment-evidence and dots-ai-management-unit-assessment. Where are the board, backlog, planning notes, retrospectives, risks, delivery reports, decisions, agreements, and stakeholder feedback?
```

Missing evidence:

```text
User: Score observability based on what you can see.
Assistant: I can inspect the repository, but observability scoring also needs dashboards, alerts, logs, or incident evidence. Where can I find those sources? If they are unavailable, I will mark the indicator as missing evidence or low confidence.
```

---

## External skills (opt-in)

|-------|-------------|

---

## Skill lifecycle

1. Skills are defined in `home/dot_local/share/dots-ai/skills/`
2. `chezmoi apply` deploys them to `~/.local/share/dots-ai/skills/`
3. `dots-skills sync` reads each `skill.json` and creates symlinks to supported AI tools
4. AI tools load `SKILL.md` at startup

---

## Tool compatibility

Each `skill.json` declares which tools are supported:

|------|-----------------|

---

**Canonical doc:** [`docs/SKILLS.md`](https://github.com/ulises-jeremias/dots-ai/blob/main/docs/SKILLS.md)
